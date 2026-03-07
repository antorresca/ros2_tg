// Auto-generated. Do not edit!

// (in-package mobile_manipulator_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class SingularValues {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.min_pos_sv = null;
      this.min_ori_sv = null;
    }
    else {
      if (initObj.hasOwnProperty('min_pos_sv')) {
        this.min_pos_sv = initObj.min_pos_sv
      }
      else {
        this.min_pos_sv = 0.0;
      }
      if (initObj.hasOwnProperty('min_ori_sv')) {
        this.min_ori_sv = initObj.min_ori_sv
      }
      else {
        this.min_ori_sv = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SingularValues
    // Serialize message field [min_pos_sv]
    bufferOffset = _serializer.float32(obj.min_pos_sv, buffer, bufferOffset);
    // Serialize message field [min_ori_sv]
    bufferOffset = _serializer.float32(obj.min_ori_sv, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SingularValues
    let len;
    let data = new SingularValues(null);
    // Deserialize message field [min_pos_sv]
    data.min_pos_sv = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [min_ori_sv]
    data.min_ori_sv = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'mobile_manipulator_msgs/SingularValues';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f9c78d5181449c9ee849e15fab621090';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 min_pos_sv
    float32 min_ori_sv
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SingularValues(null);
    if (msg.min_pos_sv !== undefined) {
      resolved.min_pos_sv = msg.min_pos_sv;
    }
    else {
      resolved.min_pos_sv = 0.0
    }

    if (msg.min_ori_sv !== undefined) {
      resolved.min_ori_sv = msg.min_ori_sv;
    }
    else {
      resolved.min_ori_sv = 0.0
    }

    return resolved;
    }
};

module.exports = SingularValues;
