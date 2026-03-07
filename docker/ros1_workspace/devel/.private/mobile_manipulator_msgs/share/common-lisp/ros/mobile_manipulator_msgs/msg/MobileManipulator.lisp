; Auto-generated. Do not edit!


(cl:in-package mobile_manipulator_msgs-msg)


;//! \htmlinclude MobileManipulator.msg.html

(cl:defclass <MobileManipulator> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (position
    :reader position
    :initarg :position
    :type mobile_manipulator_msgs-msg:PositionData
    :initform (cl:make-instance 'mobile_manipulator_msgs-msg:PositionData))
   (orientation
    :reader orientation
    :initarg :orientation
    :type mobile_manipulator_msgs-msg:OrientationData
    :initform (cl:make-instance 'mobile_manipulator_msgs-msg:OrientationData))
   (singular
    :reader singular
    :initarg :singular
    :type mobile_manipulator_msgs-msg:SingularValues
    :initform (cl:make-instance 'mobile_manipulator_msgs-msg:SingularValues))
   (torques
    :reader torques
    :initarg :torques
    :type mobile_manipulator_msgs-msg:Torques
    :initform (cl:make-instance 'mobile_manipulator_msgs-msg:Torques))
   (joints
    :reader joints
    :initarg :joints
    :type mobile_manipulator_msgs-msg:JointData
    :initform (cl:make-instance 'mobile_manipulator_msgs-msg:JointData)))
)

(cl:defclass MobileManipulator (<MobileManipulator>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MobileManipulator>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MobileManipulator)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mobile_manipulator_msgs-msg:<MobileManipulator> is deprecated: use mobile_manipulator_msgs-msg:MobileManipulator instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <MobileManipulator>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mobile_manipulator_msgs-msg:header-val is deprecated.  Use mobile_manipulator_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'position-val :lambda-list '(m))
(cl:defmethod position-val ((m <MobileManipulator>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mobile_manipulator_msgs-msg:position-val is deprecated.  Use mobile_manipulator_msgs-msg:position instead.")
  (position m))

(cl:ensure-generic-function 'orientation-val :lambda-list '(m))
(cl:defmethod orientation-val ((m <MobileManipulator>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mobile_manipulator_msgs-msg:orientation-val is deprecated.  Use mobile_manipulator_msgs-msg:orientation instead.")
  (orientation m))

(cl:ensure-generic-function 'singular-val :lambda-list '(m))
(cl:defmethod singular-val ((m <MobileManipulator>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mobile_manipulator_msgs-msg:singular-val is deprecated.  Use mobile_manipulator_msgs-msg:singular instead.")
  (singular m))

(cl:ensure-generic-function 'torques-val :lambda-list '(m))
(cl:defmethod torques-val ((m <MobileManipulator>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mobile_manipulator_msgs-msg:torques-val is deprecated.  Use mobile_manipulator_msgs-msg:torques instead.")
  (torques m))

(cl:ensure-generic-function 'joints-val :lambda-list '(m))
(cl:defmethod joints-val ((m <MobileManipulator>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mobile_manipulator_msgs-msg:joints-val is deprecated.  Use mobile_manipulator_msgs-msg:joints instead.")
  (joints m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MobileManipulator>) ostream)
  "Serializes a message object of type '<MobileManipulator>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'position) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'orientation) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'singular) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'torques) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'joints) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MobileManipulator>) istream)
  "Deserializes a message object of type '<MobileManipulator>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'position) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'orientation) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'singular) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'torques) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'joints) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MobileManipulator>)))
  "Returns string type for a message object of type '<MobileManipulator>"
  "mobile_manipulator_msgs/MobileManipulator")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MobileManipulator)))
  "Returns string type for a message object of type 'MobileManipulator"
  "mobile_manipulator_msgs/MobileManipulator")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MobileManipulator>)))
  "Returns md5sum for a message object of type '<MobileManipulator>"
  "b292abda1dc86e0e527bfb472074f00f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MobileManipulator)))
  "Returns md5sum for a message object of type 'MobileManipulator"
  "b292abda1dc86e0e527bfb472074f00f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MobileManipulator>)))
  "Returns full string definition for message of type '<MobileManipulator>"
  (cl:format cl:nil "Header header~%PositionData position~%OrientationData orientation~%SingularValues singular~%Torques torques~%JointData joints~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: mobile_manipulator_msgs/PositionData~%Vector3 current_position~%Vector3 desired_position~%================================================================================~%MSG: mobile_manipulator_msgs/Vector3~%float32 x~%float32 y~%float32 z~%================================================================================~%MSG: mobile_manipulator_msgs/OrientationData~%RPY current_orient~%RPY desired_orient~%================================================================================~%MSG: mobile_manipulator_msgs/RPY~%# Orientation of a reference frame~%~%# Fixed-axis roll, in radians~%float32 roll~%~%# Fixed-axis pitch, in radians~%float32 pitch~%~%# Fixed-axis yaw, in radians~%float32 yaw~%================================================================================~%MSG: mobile_manipulator_msgs/SingularValues~%float32 min_pos_sv~%float32 min_ori_sv~%================================================================================~%MSG: mobile_manipulator_msgs/Torques~%float32 torque1~%float32 torque2~%float32 torque3~%float32 torque4~%float32 torque5~%float32 torque6~%float32 torque7~%float32 torque8~%float32 torque9~%================================================================================~%MSG: mobile_manipulator_msgs/JointData~%Joints actual~%Joints desired~%================================================================================~%MSG: mobile_manipulator_msgs/Joints~%float32 mobjoint1~%float32 mobjoint2~%float32 mobjoint3~%float32 joint1~%float32 joint2~%float32 joint3~%float32 joint4~%float32 joint5~%float32 joint6~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MobileManipulator)))
  "Returns full string definition for message of type 'MobileManipulator"
  (cl:format cl:nil "Header header~%PositionData position~%OrientationData orientation~%SingularValues singular~%Torques torques~%JointData joints~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: mobile_manipulator_msgs/PositionData~%Vector3 current_position~%Vector3 desired_position~%================================================================================~%MSG: mobile_manipulator_msgs/Vector3~%float32 x~%float32 y~%float32 z~%================================================================================~%MSG: mobile_manipulator_msgs/OrientationData~%RPY current_orient~%RPY desired_orient~%================================================================================~%MSG: mobile_manipulator_msgs/RPY~%# Orientation of a reference frame~%~%# Fixed-axis roll, in radians~%float32 roll~%~%# Fixed-axis pitch, in radians~%float32 pitch~%~%# Fixed-axis yaw, in radians~%float32 yaw~%================================================================================~%MSG: mobile_manipulator_msgs/SingularValues~%float32 min_pos_sv~%float32 min_ori_sv~%================================================================================~%MSG: mobile_manipulator_msgs/Torques~%float32 torque1~%float32 torque2~%float32 torque3~%float32 torque4~%float32 torque5~%float32 torque6~%float32 torque7~%float32 torque8~%float32 torque9~%================================================================================~%MSG: mobile_manipulator_msgs/JointData~%Joints actual~%Joints desired~%================================================================================~%MSG: mobile_manipulator_msgs/Joints~%float32 mobjoint1~%float32 mobjoint2~%float32 mobjoint3~%float32 joint1~%float32 joint2~%float32 joint3~%float32 joint4~%float32 joint5~%float32 joint6~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MobileManipulator>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'position))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'orientation))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'singular))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'torques))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'joints))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MobileManipulator>))
  "Converts a ROS message object to a list"
  (cl:list 'MobileManipulator
    (cl:cons ':header (header msg))
    (cl:cons ':position (position msg))
    (cl:cons ':orientation (orientation msg))
    (cl:cons ':singular (singular msg))
    (cl:cons ':torques (torques msg))
    (cl:cons ':joints (joints msg))
))
