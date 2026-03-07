; Auto-generated. Do not edit!


(cl:in-package mobile_manipulator_msgs-msg)


;//! \htmlinclude JointData.msg.html

(cl:defclass <JointData> (roslisp-msg-protocol:ros-message)
  ((actual
    :reader actual
    :initarg :actual
    :type mobile_manipulator_msgs-msg:Joints
    :initform (cl:make-instance 'mobile_manipulator_msgs-msg:Joints))
   (desired
    :reader desired
    :initarg :desired
    :type mobile_manipulator_msgs-msg:Joints
    :initform (cl:make-instance 'mobile_manipulator_msgs-msg:Joints)))
)

(cl:defclass JointData (<JointData>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <JointData>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'JointData)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mobile_manipulator_msgs-msg:<JointData> is deprecated: use mobile_manipulator_msgs-msg:JointData instead.")))

(cl:ensure-generic-function 'actual-val :lambda-list '(m))
(cl:defmethod actual-val ((m <JointData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mobile_manipulator_msgs-msg:actual-val is deprecated.  Use mobile_manipulator_msgs-msg:actual instead.")
  (actual m))

(cl:ensure-generic-function 'desired-val :lambda-list '(m))
(cl:defmethod desired-val ((m <JointData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mobile_manipulator_msgs-msg:desired-val is deprecated.  Use mobile_manipulator_msgs-msg:desired instead.")
  (desired m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <JointData>) ostream)
  "Serializes a message object of type '<JointData>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'actual) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'desired) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <JointData>) istream)
  "Deserializes a message object of type '<JointData>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'actual) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'desired) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<JointData>)))
  "Returns string type for a message object of type '<JointData>"
  "mobile_manipulator_msgs/JointData")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'JointData)))
  "Returns string type for a message object of type 'JointData"
  "mobile_manipulator_msgs/JointData")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<JointData>)))
  "Returns md5sum for a message object of type '<JointData>"
  "b9180821b4f48e275f64a7616084c29b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'JointData)))
  "Returns md5sum for a message object of type 'JointData"
  "b9180821b4f48e275f64a7616084c29b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<JointData>)))
  "Returns full string definition for message of type '<JointData>"
  (cl:format cl:nil "Joints actual~%Joints desired~%================================================================================~%MSG: mobile_manipulator_msgs/Joints~%float32 mobjoint1~%float32 mobjoint2~%float32 mobjoint3~%float32 joint1~%float32 joint2~%float32 joint3~%float32 joint4~%float32 joint5~%float32 joint6~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'JointData)))
  "Returns full string definition for message of type 'JointData"
  (cl:format cl:nil "Joints actual~%Joints desired~%================================================================================~%MSG: mobile_manipulator_msgs/Joints~%float32 mobjoint1~%float32 mobjoint2~%float32 mobjoint3~%float32 joint1~%float32 joint2~%float32 joint3~%float32 joint4~%float32 joint5~%float32 joint6~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <JointData>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'actual))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'desired))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <JointData>))
  "Converts a ROS message object to a list"
  (cl:list 'JointData
    (cl:cons ':actual (actual msg))
    (cl:cons ':desired (desired msg))
))
