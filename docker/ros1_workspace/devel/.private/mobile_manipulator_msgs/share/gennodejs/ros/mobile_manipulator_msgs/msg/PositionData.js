// Auto-generated. Do not edit!

// (in-package mobile_manipulator_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Vector3 = require('./Vector3.js');

//-----------------------------------------------------------

class PositionData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.current_position = null;
      this.desired_position = null;
    }
    else {
      if (initObj.hasOwnProperty('current_position')) {
        this.current_position = initObj.current_position
      }
      else {
        this.current_position = new Vector3();
      }
      if (initObj.hasOwnProperty('desired_position')) {
        this.desired_position = initObj.desired_position
      }
      else {
        this.desired_position = new Vector3();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PositionData
    // Serialize message field [current_position]
    bufferOffset = Vector3.serialize(obj.current_position, buffer, bufferOffset);
    // Serialize message field [desired_position]
    bufferOffset = Vector3.serialize(obj.desired_position, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PositionData
    let len;
    let data = new PositionData(null);
    // Deserialize message field [current_position]
    data.current_position = Vector3.deserialize(buffer, bufferOffset);
    // Deserialize message field [desired_position]
    data.desired_position = Vector3.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'mobile_manipulator_msgs/PositionData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f6920a2c98186d4bf709632ac111101d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Vector3 current_position
    Vector3 desired_position
    ================================================================================
    MSG: mobile_manipulator_msgs/Vector3
    float32 x
    float32 y
    float32 z
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new PositionData(null);
    if (msg.current_position !== undefined) {
      resolved.current_position = Vector3.Resolve(msg.current_position)
    }
    else {
      resolved.current_position = new Vector3()
    }

    if (msg.desired_position !== undefined) {
      resolved.desired_position = Vector3.Resolve(msg.desired_position)
    }
    else {
      resolved.desired_position = new Vector3()
    }

    return resolved;
    }
};

module.exports = PositionData;
