; Auto-generated. Do not edit!


(cl:in-package mobile_manipulator_msgs-msg)


;//! \htmlinclude PositionData.msg.html

(cl:defclass <PositionData> (roslisp-msg-protocol:ros-message)
  ((current_position
    :reader current_position
    :initarg :current_position
    :type mobile_manipulator_msgs-msg:Vector3
    :initform (cl:make-instance 'mobile_manipulator_msgs-msg:Vector3))
   (desired_position
    :reader desired_position
    :initarg :desired_position
    :type mobile_manipulator_msgs-msg:Vector3
    :initform (cl:make-instance 'mobile_manipulator_msgs-msg:Vector3)))
)

(cl:defclass PositionData (<PositionData>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PositionData>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PositionData)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mobile_manipulator_msgs-msg:<PositionData> is deprecated: use mobile_manipulator_msgs-msg:PositionData instead.")))

(cl:ensure-generic-function 'current_position-val :lambda-list '(m))
(cl:defmethod current_position-val ((m <PositionData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mobile_manipulator_msgs-msg:current_position-val is deprecated.  Use mobile_manipulator_msgs-msg:current_position instead.")
  (current_position m))

(cl:ensure-generic-function 'desired_position-val :lambda-list '(m))
(cl:defmethod desired_position-val ((m <PositionData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mobile_manipulator_msgs-msg:desired_position-val is deprecated.  Use mobile_manipulator_msgs-msg:desired_position instead.")
  (desired_position m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PositionData>) ostream)
  "Serializes a message object of type '<PositionData>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'current_position) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'desired_position) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PositionData>) istream)
  "Deserializes a message object of type '<PositionData>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'current_position) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'desired_position) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PositionData>)))
  "Returns string type for a message object of type '<PositionData>"
  "mobile_manipulator_msgs/PositionData")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PositionData)))
  "Returns string type for a message object of type 'PositionData"
  "mobile_manipulator_msgs/PositionData")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PositionData>)))
  "Returns md5sum for a message object of type '<PositionData>"
  "f6920a2c98186d4bf709632ac111101d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PositionData)))
  "Returns md5sum for a message object of type 'PositionData"
  "f6920a2c98186d4bf709632ac111101d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PositionData>)))
  "Returns full string definition for message of type '<PositionData>"
  (cl:format cl:nil "Vector3 current_position~%Vector3 desired_position~%================================================================================~%MSG: mobile_manipulator_msgs/Vector3~%float32 x~%float32 y~%float32 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PositionData)))
  "Returns full string definition for message of type 'PositionData"
  (cl:format cl:nil "Vector3 current_position~%Vector3 desired_position~%================================================================================~%MSG: mobile_manipulator_msgs/Vector3~%float32 x~%float32 y~%float32 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PositionData>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'current_position))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'desired_position))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PositionData>))
  "Converts a ROS message object to a list"
  (cl:list 'PositionData
    (cl:cons ':current_position (current_position msg))
    (cl:cons ':desired_position (desired_position msg))
))
