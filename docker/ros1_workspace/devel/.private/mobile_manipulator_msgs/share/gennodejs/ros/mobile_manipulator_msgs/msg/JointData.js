// Auto-generated. Do not edit!

// (in-package mobile_manipulator_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Joints = require('./Joints.js');

//-----------------------------------------------------------

class JointData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.actual = null;
      this.desired = null;
    }
    else {
      if (initObj.hasOwnProperty('actual')) {
        this.actual = initObj.actual
      }
      else {
        this.actual = new Joints();
      }
      if (initObj.hasOwnProperty('desired')) {
        this.desired = initObj.desired
      }
      else {
        this.desired = new Joints();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type JointData
    // Serialize message field [actual]
    bufferOffset = Joints.serialize(obj.actual, buffer, bufferOffset);
    // Serialize message field [desired]
    bufferOffset = Joints.serialize(obj.desired, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type JointData
    let len;
    let data = new JointData(null);
    // Deserialize message field [actual]
    data.actual = Joints.deserialize(buffer, bufferOffset);
    // Deserialize message field [desired]
    data.desired = Joints.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 72;
  }

  static datatype() {
    // Returns string type for a message object
    return 'mobile_manipulator_msgs/JointData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b9180821b4f48e275f64a7616084c29b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Joints actual
    Joints desired
    ================================================================================
    MSG: mobile_manipulator_msgs/Joints
    float32 mobjoint1
    float32 mobjoint2
    float32 mobjoint3
    float32 joint1
    float32 joint2
    float32 joint3
    float32 joint4
    float32 joint5
    float32 joint6
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new JointData(null);
    if (msg.actual !== undefined) {
      resolved.actual = Joints.Resolve(msg.actual)
    }
    else {
      resolved.actual = new Joints()
    }

    if (msg.desired !== undefined) {
      resolved.desired = Joints.Resolve(msg.desired)
    }
    else {
      resolved.desired = new Joints()
    }

    return resolved;
    }
};

module.exports = JointData;
