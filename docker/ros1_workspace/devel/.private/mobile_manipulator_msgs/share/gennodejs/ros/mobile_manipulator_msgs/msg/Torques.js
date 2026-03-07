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

class Torques {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.torque1 = null;
      this.torque2 = null;
      this.torque3 = null;
      this.torque4 = null;
      this.torque5 = null;
      this.torque6 = null;
      this.torque7 = null;
      this.torque8 = null;
      this.torque9 = null;
    }
    else {
      if (initObj.hasOwnProperty('torque1')) {
        this.torque1 = initObj.torque1
      }
      else {
        this.torque1 = 0.0;
      }
      if (initObj.hasOwnProperty('torque2')) {
        this.torque2 = initObj.torque2
      }
      else {
        this.torque2 = 0.0;
      }
      if (initObj.hasOwnProperty('torque3')) {
        this.torque3 = initObj.torque3
      }
      else {
        this.torque3 = 0.0;
      }
      if (initObj.hasOwnProperty('torque4')) {
        this.torque4 = initObj.torque4
      }
      else {
        this.torque4 = 0.0;
      }
      if (initObj.hasOwnProperty('torque5')) {
        this.torque5 = initObj.torque5
      }
      else {
        this.torque5 = 0.0;
      }
      if (initObj.hasOwnProperty('torque6')) {
        this.torque6 = initObj.torque6
      }
      else {
        this.torque6 = 0.0;
      }
      if (initObj.hasOwnProperty('torque7')) {
        this.torque7 = initObj.torque7
      }
      else {
        this.torque7 = 0.0;
      }
      if (initObj.hasOwnProperty('torque8')) {
        this.torque8 = initObj.torque8
      }
      else {
        this.torque8 = 0.0;
      }
      if (initObj.hasOwnProperty('torque9')) {
        this.torque9 = initObj.torque9
      }
      else {
        this.torque9 = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Torques
    // Serialize message field [torque1]
    bufferOffset = _serializer.float32(obj.torque1, buffer, bufferOffset);
    // Serialize message field [torque2]
    bufferOffset = _serializer.float32(obj.torque2, buffer, bufferOffset);
    // Serialize message field [torque3]
    bufferOffset = _serializer.float32(obj.torque3, buffer, bufferOffset);
    // Serialize message field [torque4]
    bufferOffset = _serializer.float32(obj.torque4, buffer, bufferOffset);
    // Serialize message field [torque5]
    bufferOffset = _serializer.float32(obj.torque5, buffer, bufferOffset);
    // Serialize message field [torque6]
    bufferOffset = _serializer.float32(obj.torque6, buffer, bufferOffset);
    // Serialize message field [torque7]
    bufferOffset = _serializer.float32(obj.torque7, buffer, bufferOffset);
    // Serialize message field [torque8]
    bufferOffset = _serializer.float32(obj.torque8, buffer, bufferOffset);
    // Serialize message field [torque9]
    bufferOffset = _serializer.float32(obj.torque9, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Torques
    let len;
    let data = new Torques(null);
    // Deserialize message field [torque1]
    data.torque1 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [torque2]
    data.torque2 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [torque3]
    data.torque3 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [torque4]
    data.torque4 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [torque5]
    data.torque5 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [torque6]
    data.torque6 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [torque7]
    data.torque7 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [torque8]
    data.torque8 = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [torque9]
    data.torque9 = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 36;
  }

  static datatype() {
    // Returns string type for a message object
    return 'mobile_manipulator_msgs/Torques';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '51af3a57814ea678a622d88758f096dc';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 torque1
    float32 torque2
    float32 torque3
    float32 torque4
    float32 torque5
    float32 torque6
    float32 torque7
    float32 torque8
    float32 torque9
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Torques(null);
    if (msg.torque1 !== undefined) {
      resolved.torque1 = msg.torque1;
    }
    else {
      resolved.torque1 = 0.0
    }

    if (msg.torque2 !== undefined) {
      resolved.torque2 = msg.torque2;
    }
    else {
      resolved.torque2 = 0.0
    }

    if (msg.torque3 !== undefined) {
      resolved.torque3 = msg.torque3;
    }
    else {
      resolved.torque3 = 0.0
    }

    if (msg.torque4 !== undefined) {
      resolved.torque4 = msg.torque4;
    }
    else {
      resolved.torque4 = 0.0
    }

    if (msg.torque5 !== undefined) {
      resolved.torque5 = msg.torque5;
    }
    else {
      resolved.torque5 = 0.0
    }

    if (msg.torque6 !== undefined) {
      resolved.torque6 = msg.torque6;
    }
    else {
      resolved.torque6 = 0.0
    }

    if (msg.torque7 !== undefined) {
      resolved.torque7 = msg.torque7;
    }
    else {
      resolved.torque7 = 0.0
    }

    if (msg.torque8 !== undefined) {
      resolved.torque8 = msg.torque8;
    }
    else {
      resolved.torque8 = 0.0
    }

    if (msg.torque9 !== undefined) {
      resolved.torque9 = msg.torque9;
    }
    else {
      resolved.torque9 = 0.0
    }

    return resolved;
    }
};

module.exports = Torques;
