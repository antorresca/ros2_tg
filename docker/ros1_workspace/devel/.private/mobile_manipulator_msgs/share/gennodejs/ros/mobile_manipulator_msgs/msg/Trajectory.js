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
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class Trajectory {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.pose = null;
      this.vel = null;
      this.accel = null;
      this.joints = null;
    }
    else {
      if (initObj.hasOwnProperty('pose')) {
        this.pose = initObj.pose
      }
      else {
        this.pose = new geometry_msgs.msg.Transform();
      }
      if (initObj.hasOwnProperty('vel')) {
        this.vel = initObj.vel
      }
      else {
        this.vel = new geometry_msgs.msg.Twist();
      }
      if (initObj.hasOwnProperty('accel')) {
        this.accel = initObj.accel
      }
      else {
        this.accel = new geometry_msgs.msg.Accel();
      }
      if (initObj.hasOwnProperty('joints')) {
        this.joints = initObj.joints
      }
      else {
        this.joints = new Joints();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Trajectory
    // Serialize message field [pose]
    bufferOffset = geometry_msgs.msg.Transform.serialize(obj.pose, buffer, bufferOffset);
    // Serialize message field [vel]
    bufferOffset = geometry_msgs.msg.Twist.serialize(obj.vel, buffer, bufferOffset);
    // Serialize message field [accel]
    bufferOffset = geometry_msgs.msg.Accel.serialize(obj.accel, buffer, bufferOffset);
    // Serialize message field [joints]
    bufferOffset = Joints.serialize(obj.joints, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Trajectory
    let len;
    let data = new Trajectory(null);
    // Deserialize message field [pose]
    data.pose = geometry_msgs.msg.Transform.deserialize(buffer, bufferOffset);
    // Deserialize message field [vel]
    data.vel = geometry_msgs.msg.Twist.deserialize(buffer, bufferOffset);
    // Deserialize message field [accel]
    data.accel = geometry_msgs.msg.Accel.deserialize(buffer, bufferOffset);
    // Deserialize message field [joints]
    data.joints = Joints.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 188;
  }

  static datatype() {
    // Returns string type for a message object
    return 'mobile_manipulator_msgs/Trajectory';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '3d2b7226198a8d6ec3af71882709c30d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    geometry_msgs/Transform pose
    geometry_msgs/Twist vel
    geometry_msgs/Accel accel
    Joints joints
    ================================================================================
    MSG: geometry_msgs/Transform
    # This represents the transform between two coordinate frames in free space.
    
    Vector3 translation
    Quaternion rotation
    
    ================================================================================
    MSG: geometry_msgs/Vector3
    # This represents a vector in free space. 
    # It is only meant to represent a direction. Therefore, it does not
    # make sense to apply a translation to it (e.g., when applying a 
    # generic rigid transformation to a Vector3, tf2 will only apply the
    # rotation). If you want your data to be translatable too, use the
    # geometry_msgs/Point message instead.
    
    float64 x
    float64 y
    float64 z
    ================================================================================
    MSG: geometry_msgs/Quaternion
    # This represents an orientation in free space in quaternion form.
    
    float64 x
    float64 y
    float64 z
    float64 w
    
    ================================================================================
    MSG: geometry_msgs/Twist
    # This expresses velocity in free space broken into its linear and angular parts.
    Vector3  linear
    Vector3  angular
    
    ================================================================================
    MSG: geometry_msgs/Accel
    # This expresses acceleration in free space broken into its linear and angular parts.
    Vector3  linear
    Vector3  angular
    
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
    const resolved = new Trajectory(null);
    if (msg.pose !== undefined) {
      resolved.pose = geometry_msgs.msg.Transform.Resolve(msg.pose)
    }
    else {
      resolved.pose = new geometry_msgs.msg.Transform()
    }

    if (msg.vel !== undefined) {
      resolved.vel = geometry_msgs.msg.Twist.Resolve(msg.vel)
    }
    else {
      resolved.vel = new geometry_msgs.msg.Twist()
    }

    if (msg.accel !== undefined) {
      resolved.accel = geometry_msgs.msg.Accel.Resolve(msg.accel)
    }
    else {
      resolved.accel = new geometry_msgs.msg.Accel()
    }

    if (msg.joints !== undefined) {
      resolved.joints = Joints.Resolve(msg.joints)
    }
    else {
      resolved.joints = new Joints()
    }

    return resolved;
    }
};

module.exports = Trajectory;
