#pragma once

#include <zmq.hpp>
#include <string>
#include <vector>
#include <stdexcept>
#include <iostream>
#include <sstream>

// Minimal CBOR encoder/decoder for CoppeliaSim ZMQ Remote API
// Only implements what we need: int, double, string, arrays

namespace coppeliasim_client
{

// ── CBOR primitives ──────────────────────────────────────────────────────────

inline std::vector<uint8_t> cbor_encode_int(int64_t val)
{
    std::vector<uint8_t> buf;
    if (val >= 0) {
        if (val <= 23)                { buf = {(uint8_t)val}; }
        else if (val <= 0xFF)         { buf = {0x18, (uint8_t)val}; }
        else if (val <= 0xFFFF)       { buf = {0x19, (uint8_t)(val>>8), (uint8_t)val}; }
        else if (val <= 0xFFFFFFFF)   { buf = {0x1a,
            (uint8_t)(val>>24),(uint8_t)(val>>16),(uint8_t)(val>>8),(uint8_t)val}; }
        else { buf = {0x1b,
            (uint8_t)(val>>56),(uint8_t)(val>>48),(uint8_t)(val>>40),(uint8_t)(val>>32),
            (uint8_t)(val>>24),(uint8_t)(val>>16),(uint8_t)(val>>8),(uint8_t)val}; }
    } else {
        uint64_t uval = (uint64_t)(-(val+1));
        std::vector<uint8_t> pos = cbor_encode_int((int64_t)uval);
        pos[0] |= 0x20;
        buf = pos;
    }
    return buf;
}

inline std::vector<uint8_t> cbor_encode_double(double val)
{
    std::vector<uint8_t> buf = {0xfb};
    uint64_t bits;
    memcpy(&bits, &val, 8);
    for (int i = 7; i >= 0; --i)
        buf.push_back((bits >> (i*8)) & 0xFF);
    return buf;
}

inline std::vector<uint8_t> cbor_encode_string(const std::string& s)
{
    std::vector<uint8_t> buf;
    size_t len = s.size();
    if (len <= 23) buf.push_back(0x60 | len);
    else if (len <= 0xFF) { buf.push_back(0x78); buf.push_back((uint8_t)len); }
    else { buf.push_back(0x79); buf.push_back(len>>8); buf.push_back(len&0xFF); }
    buf.insert(buf.end(), s.begin(), s.end());
    return buf;
}

inline std::vector<uint8_t> cbor_encode_array_header(size_t n)
{
    std::vector<uint8_t> buf;
    if (n <= 23) buf.push_back(0x80 | n);
    else if (n <= 0xFF) { buf.push_back(0x98); buf.push_back((uint8_t)n); }
    else { buf.push_back(0x99); buf.push_back(n>>8); buf.push_back(n&0xFF); }
    return buf;
}

inline std::vector<uint8_t> cbor_encode_map_header(size_t n)
{
    std::vector<uint8_t> buf;
    if (n <= 23) buf.push_back(0xa0 | n);
    else { buf.push_back(0xb8); buf.push_back((uint8_t)n); }
    return buf;
}

// ── CBOR decoder helpers ─────────────────────────────────────────────────────

struct CborValue {
    enum Type { INT, DOUBLE, STRING, ARRAY, MAP, BOOL, NIL } type;
    int64_t     i{0};
    double      d{0.0};
    std::string s;
    std::vector<CborValue> arr;
    bool        b{false};
};

inline size_t decode_uint(const std::vector<uint8_t>& buf, size_t& pos, uint8_t info, uint64_t& out)
{
    if (info <= 23) { out = info; }
    else if (info == 24) { out = buf[pos++]; }
    else if (info == 25) { out = ((uint64_t)buf[pos]<<8)|buf[pos+1]; pos+=2; }
    else if (info == 26) { out = ((uint64_t)buf[pos]<<24)|((uint64_t)buf[pos+1]<<16)|
                                  ((uint64_t)buf[pos+2]<<8)|buf[pos+3]; pos+=4; }
    else if (info == 27) {
        out = 0;
        for(int i=0;i<8;i++) out=(out<<8)|buf[pos+i];
        pos+=8;
    }
    return out;
}

inline CborValue cbor_decode(const std::vector<uint8_t>& buf, size_t& pos);

inline CborValue cbor_decode(const std::vector<uint8_t>& buf, size_t& pos)
{
    CborValue v;
    uint8_t byte = buf[pos++];
    uint8_t major = byte >> 5;
    uint8_t info  = byte & 0x1f;

    uint64_t uval = 0;
    decode_uint(buf, pos, info, uval);

    switch(major) {
        case 0: v.type = CborValue::INT;    v.i = (int64_t)uval; break;
        case 1: v.type = CborValue::INT;    v.i = -(int64_t)uval - 1; break;
        case 2: { // bytes
            v.type = CborValue::STRING;
            v.s = std::string(buf.begin()+pos, buf.begin()+pos+uval);
            pos += uval; break;
        }
        case 3: { // text
            v.type = CborValue::STRING;
            v.s = std::string(buf.begin()+pos, buf.begin()+pos+uval);
            pos += uval; break;
        }
        case 4: { // array
            v.type = CborValue::ARRAY;
            for(size_t i=0;i<uval;i++) v.arr.push_back(cbor_decode(buf,pos));
            break;
        }
        case 5: { // map
            v.type = CborValue::MAP;
            for(size_t i=0;i<uval;i++) {
                v.arr.push_back(cbor_decode(buf,pos)); // key
                v.arr.push_back(cbor_decode(buf,pos)); // value
            }
            break;
        }
        case 7: {
            if (info == 20 || info == 21) { v.type = CborValue::BOOL; v.b = (info==21); }
            else if (info == 22) { v.type = CborValue::NIL; }
            else if (info == 27) { // float64
                v.type = CborValue::DOUBLE;
                uint64_t bits = 0;
                // already read into uval via decode_uint path — but for 0xfb we need raw bytes
                // re-read: pos already advanced 8 bytes via decode_uint(info=27)
                // uval holds the bits
                memcpy(&v.d, &uval, 8);
                // fix endianness: uval was read big-endian above, swap to host
                uint64_t swapped = 0;
                uint8_t* src = reinterpret_cast<uint8_t*>(&uval);
                uint8_t* dst = reinterpret_cast<uint8_t*>(&swapped);
                // uval already big-endian assembled, copy as-is to double bits
                memcpy(&v.d, &uval, 8);
            }
            break;
        }
    }
    return v;
}

// ── Client ───────────────────────────────────────────────────────────────────

class Client
{
public:
    explicit Client(const std::string& host = "localhost", int port = 23000)
        : ctx_(1), socket_(ctx_, zmq::socket_type::req)
    {
        socket_.connect("tcp://" + host + ":" + std::to_string(port));
        socket_.set(zmq::sockopt::rcvtimeo, 5000);
        socket_.set(zmq::sockopt::sndtimeo, 5000);
    }

    // Generic call: func(args...) → CborValue response
    CborValue call(const std::string& func, const std::vector<uint8_t>& args_cbor)
    {
        // Build request map: {"func": func, "args": args_cbor}
        std::vector<uint8_t> req;
        auto h = cbor_encode_map_header(2);
        req.insert(req.end(), h.begin(), h.end());

        auto k1 = cbor_encode_string("func");
        req.insert(req.end(), k1.begin(), k1.end());
        auto v1 = cbor_encode_string(func);
        req.insert(req.end(), v1.begin(), v1.end());

        auto k2 = cbor_encode_string("args");
        req.insert(req.end(), k2.begin(), k2.end());
        req.insert(req.end(), args_cbor.begin(), args_cbor.end());

        zmq::message_t msg(req.data(), req.size());
        socket_.send(msg, zmq::send_flags::none);

        zmq::message_t reply;
        auto res = socket_.recv(reply, zmq::recv_flags::none);
        if (!res) throw std::runtime_error("ZMQ timeout calling " + func);

        std::vector<uint8_t> data(
            reinterpret_cast<uint8_t*>(reply.data()),
            reinterpret_cast<uint8_t*>(reply.data()) + reply.size());

        size_t pos = 0;
        return cbor_decode(data, pos);
    }

    // ── Convenience wrappers ─────────────────────────────────────────────────

    int getObject(const std::string& path)
    {
        auto args = cbor_encode_array_header(2);
        auto s = cbor_encode_string(path);
        args.insert(args.end(), s.begin(), s.end());
        auto minus1 = cbor_encode_int(-1);
        args.insert(args.end(), minus1.begin(), minus1.end());

        auto resp = call("sim.getObject", args);
        if (resp.type == CborValue::MAP) {
            for (size_t i = 0; i+1 < resp.arr.size(); i+=2)
                if (resp.arr[i].s == "err")
                    throw std::runtime_error("getObject error: " + resp.arr[i+1].s);
            for (size_t i = 0; i+1 < resp.arr.size(); i+=2)
                if (resp.arr[i].s == "ret")
                    return (int)resp.arr[i+1].arr[0].i;
        }
        throw std::runtime_error("getObject: unexpected response");
    }

    double getJointPosition(int handle)
    {
        auto args = cbor_encode_array_header(1);
        auto h = cbor_encode_int(handle);
        args.insert(args.end(), h.begin(), h.end());
        auto resp = call("sim.getJointPosition", args);
        for (size_t i = 0; i+1 < resp.arr.size(); i+=2)
            if (resp.arr[i].s == "ret") {
                auto& v = resp.arr[i+1].arr[0];
                return v.type == CborValue::DOUBLE ? v.d : (double)v.i;
            }
        throw std::runtime_error("getJointPosition failed");
    }

    double getJointVelocity(int handle)
    {
        auto args = cbor_encode_array_header(1);
        auto h = cbor_encode_int(handle);
        args.insert(args.end(), h.begin(), h.end());
        auto resp = call("sim.getJointVelocity", args);
        for (size_t i = 0; i+1 < resp.arr.size(); i+=2)
            if (resp.arr[i].s == "ret") {
                auto& v = resp.arr[i+1].arr[0];
                return v.type == CborValue::DOUBLE ? v.d : (double)v.i;
            }
        throw std::runtime_error("getJointVelocity failed");
    }

    void setJointTargetForce(int handle, double tau)
    {
        auto args = cbor_encode_array_header(2);
        auto h = cbor_encode_int(handle);
        args.insert(args.end(), h.begin(), h.end());
        auto t = cbor_encode_double(tau);
        args.insert(args.end(), t.begin(), t.end());
        call("sim.setJointTargetForce", args);
    }

    void setJointMode(int handle, int mode, int options)
    {
        auto args = cbor_encode_array_header(3);
        auto h = cbor_encode_int(handle);  args.insert(args.end(), h.begin(), h.end());
        auto m = cbor_encode_int(mode);    args.insert(args.end(), m.begin(), m.end());
        auto o = cbor_encode_int(options); args.insert(args.end(), o.begin(), o.end());
        call("sim.setJointMode", args);
    }

    // jointmode constants (from CoppeliaSim API)
    static constexpr int jointmode_kinematic = 0;
    static constexpr int jointmode_force     = 2;

private:
    zmq::context_t ctx_;
    zmq::socket_t  socket_;
};

}  // namespace coppeliasim_client
