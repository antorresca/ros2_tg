// Auto-generated. Do not edit!

// (in-package mobile_manipulator_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let PositionData = require('./PositionData.js');
let OrientationData = require('./OrientationData.js');
let SingularValues = require('./SingularValues.js');
let Torques = require('./Torques.js');
let JointData = require('./JointData.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class MobileManipulator {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.position = null;
      this.orientation = null;
      this.singular = null;
      this.torques = null;
      this.joints = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('position')) {
        this.position = initObj.position
      }
      else {
        this.position = new PositionData();
      }
      if (initObj.hasOwnProperty('orientation')) {
        this.orientation = initObj.orientation
      }
      else {
        this.orientation = new OrientationData();
      }
      if (initObj.hasOwnProperty('singular')) {
        this.singular = initObj.singular
      }
      else {
        this.singular = new SingularValues();
      }
      if (initObj.hasOwnProperty('torques')) {
        this.torques = initObj.torques
      }
      else {
        this.torques = new Torques();
      }
      if (initObj.hasOwnProperty('joints')) {
        this.joints = initObj.joints
      }
      else {
        this.joints = new JointData();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MobileManipulator
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [position]
    bufferOffset = PositionData.serialize(obj.position, buffer, bufferOffset);
    // Serialize message field [orientation]
    bufferOffset = OrientationData.serialize(obj.orientation, buffer, bufferOffset);
    // Serialize message field [singular]
    bufferOffset = SingularValues.serialize(obj.singular, buffer, bufferOffset);
    // Serialize message field [torques]
    bufferOffset = Torques.serialize(obj.torques, buffer, bufferOffset);
    // Serialize message field [joints]
    bufferOffset = JointData.serialize(obj.joints, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MobileManipulator
    let len;
    let data = new MobileManipulator(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [position]
    data.position = PositionData.deserialize(buffer, bufferOffset);
    // Deserialize message field [orientation]
    data.orientation = OrientationData.deserialize(buffer, bufferOffset);
    // Deserialize message field [singular]
    data.singular = SingularValues.deserialize(buffer, bufferOffset);
    // Deserialize message field [torques]
    data.torques = Torques.deserialize(buffer, bufferOffset);
    // Deserialize message field [joints]
    data.joints = JointData.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 164;
  }

  static datatype() {
    // Returns string type for a message object
    return 'mobile_manipulator_msgs/MobileManipulator';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b292abda1dc86e0e527bfb472074f00f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    Header header
    PositionData position
    OrientationData orientation
    SingularValues singular
    Torques torques
    JointData joints
    ================================================================================
    MSG: std_msgs/Header
    # Standard metadata for higher-level stamped data types.
    # This is generally used to communicate timestamped data 
    # in a particular coordinate frame.
    # 
    # sequence ID: consecutively increasing ID 
    uint32 seq
    #Two-integer timestamp that is expressed as:
    # * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
    # * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
    # time-handling sugar is provided by the client library
    time stamp
    #Frame this data is associated with
    string frame_id
    
    ================================================================================
    MSG: mobile_manipulator_msgs/PositionData
    Vector3 current_position
    Vector3 desired_position
    ================================================================================
    MSG: mobile_manipulator_msgs/Vector3
    float32 x
    float32 y
    float32 z
    ================================================================================
    MSG: mobile_manipulator_msgs/OrientationData
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
    ================================================================================
    MSG: mobile_manipulator_msgs/SingularValues
    float32 min_pos_sv
    float32 min_ori_sv
    ================================================================================
    MSG: mobile_manipulator_msgs/Torques
    float32 torque1
    float32 torque2
    float32 torque3
    float32 torque4
    float32 torque5
    float32 torque6
    float32 torque7
    float32 torque8
    float32 torque9
    ================================================================================
    MSG: mobile_manipulator_msgs/JointData
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
    const resolved = new MobileManipulator(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.position !== undefined) {
      resolved.position = PositionData.Resolve(msg.position)
    }
    else {
      resolved.position = new PositionData()
    }

    if (msg.orientation !== undefined) {
      resolved.orientation = OrientationData.Resolve(msg.orientation)
    }
    else {
      resolved.orientation = new OrientationData()
    }

    if (msg.singular !== undefined) {
      resolved.singular = SingularValues.Resolve(msg.singular)
    }
    else {
      resolved.singular = new SingularValues()
    }

    if (msg.torques !== undefined) {
      resolved.torques = Torques.Resolve(msg.torques)
    }
    else {
      resolved.torques = new Torques()
    }

    if (msg.joints !== undefined) {
      resolved.joints = JointData.Resolve(msg.joints)
    }
    else {
      resolved.joints = new JointData()
    }

    return resolved;
    }
};

module.exports = MobileManipulator;
