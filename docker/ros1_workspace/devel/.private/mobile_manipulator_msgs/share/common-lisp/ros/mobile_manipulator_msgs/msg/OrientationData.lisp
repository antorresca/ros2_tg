; Auto-generated. Do not edit!


(cl:in-package mobile_manipulator_msgs-msg)


;//! \htmlinclude OrientationData.msg.html

(cl:defclass <OrientationData> (roslisp-msg-protocol:ros-message)
  ((current_orient
    :reader current_orient
    :initarg :current_orient
    :type mobile_manipulator_msgs-msg:RPY
    :initform (cl:make-instance 'mobile_manipulator_msgs-msg:RPY))
   (desired_orient
    :reader desired_orient
    :initarg :desired_orient
    :type mobile_manipulator_msgs-msg:RPY
    :initform (cl:make-instance 'mobile_manipulator_msgs-msg:RPY)))
)

(cl:defclass OrientationData (<OrientationData>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <OrientationData>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'OrientationData)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mobile_manipulator_msgs-msg:<OrientationData> is deprecated: use mobile_manipulator_msgs-msg:OrientationData instead.")))

(cl:ensure-generic-function 'current_orient-val :lambda-list '(m))
(cl:defmethod current_orient-val ((m <OrientationData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mobile_manipulator_msgs-msg:current_orient-val is deprecated.  Use mobile_manipulator_msgs-msg:current_orient instead.")
  (current_orient m))

(cl:ensure-generic-function 'desired_orient-val :lambda-list '(m))
(cl:defmethod desired_orient-val ((m <OrientationData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mobile_manipulator_msgs-msg:desired_orient-val is deprecated.  Use mobile_manipulator_msgs-msg:desired_orient instead.")
  (desired_orient m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <OrientationData>) ostream)
  "Serializes a message object of type '<OrientationData>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'current_orient) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'desired_orient) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <OrientationData>) istream)
  "Deserializes a message object of type '<OrientationData>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'current_orient) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'desired_orient) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<OrientationData>)))
  "Returns string type for a message object of type '<OrientationData>"
  "mobile_manipulator_msgs/OrientationData")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'OrientationData)))
  "Returns string type for a message object of type 'OrientationData"
  "mobile_manipulator_msgs/OrientationData")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<OrientationData>)))
  "Returns md5sum for a message object of type '<OrientationData>"
  "0ea91799dc6fd84b700660686d98fd66")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'OrientationData)))
  "Returns md5sum for a message object of type 'OrientationData"
  "0ea91799dc6fd84b700660686d98fd66")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<OrientationData>)))
  "Returns full string definition for message of type '<OrientationData>"
  (cl:format cl:nil "RPY current_orient~%RPY desired_orient~%================================================================================~%MSG: mobile_manipulator_msgs/RPY~%# Orientation of a reference frame~%~%# Fixed-axis roll, in radians~%float32 roll~%~%# Fixed-axis pitch, in radians~%float32 pitch~%~%# Fixed-axis yaw, in radians~%float32 yaw~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'OrientationData)))
  "Returns full string definition for message of type 'OrientationData"
  (cl:format cl:nil "RPY current_orient~%RPY desired_orient~%================================================================================~%MSG: mobile_manipulator_msgs/RPY~%# Orientation of a reference frame~%~%# Fixed-axis roll, in radians~%float32 roll~%~%# Fixed-axis pitch, in radians~%float32 pitch~%~%# Fixed-axis yaw, in radians~%float32 yaw~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <OrientationData>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'current_orient))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'desired_orient))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <OrientationData>))
  "Converts a ROS message object to a list"
  (cl:list 'OrientationData
    (cl:cons ':current_orient (current_orient msg))
    (cl:cons ':desired_orient (desired_orient msg))
))
