// Auto-generated. Do not edit!

// (in-package mobile_manipulator_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let RPY = require('./RPY.js');

//-----------------------------------------------------------

class OrientationData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.current_orient = null;
      this.desired_orient = null;
    }
    else {
      if (initObj.hasOwnProperty('current_orient')) {
        this.current_orient = initObj.current_orient
      }
      else {
        this.current_orient = new RPY();
      }
      if (initObj.hasOwnProperty('desired_orient')) {
        this.desired_orient = initObj.desired_orient
      }
      else {
        this.desired_orient = new RPY();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type OrientationData
    // Serialize message field [current_orient]
    bufferOffset = RPY.serialize(obj.current_orient, buffer, bufferOffset);
    // Serialize message field [desired_orient]
    bufferOffset = RPY.serialize(obj.desired_orient, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type OrientationData
    let len;
    let data = new OrientationData(null);
    // Deserialize message field [current_orient]
    data.current_orient = RPY.deserialize(buffer, bufferOffset);
    // Deserialize message field [desired_orient]
    data.desired_orient = RPY.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'mobile_manipulator_msgs/OrientationData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0ea91799dc6fd84b700660686d98fd66';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    RPY current_orient
    RPY desired_orient
    ================================================================================
    MSG: mobile_manipulator_msgs/RPY
    # Orientation of a reference frame
    
    # Fixed-axis roll, in radians
    float32 roll
    
    # Fixed-axis pitch, in radians
    float32 pitch
    
    # Fixed-axis yaw, in radians
    float32 yaw
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new OrientationData(null);
    if (msg.current_orient !== undefined) {
      resolved.current_orient = RPY.Resolve(msg.current_orient)
    }
    else {
      resolved.current_orient = new RPY()
    }

    if (msg.desired_orient !== undefined) {
      resolved.desired_orient = RPY.Resolve(msg.desired_orient)
    }
    else {
      resolved.desired_orient = new RPY()
    }

    return resolved;
    }
};

module.exports = OrientationData;
