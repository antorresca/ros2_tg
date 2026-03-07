; Auto-generated. Do not edit!


(cl:in-package mobile_manipulator_msgs-msg)


;//! \htmlinclude Torques.msg.html

(cl:defclass <Torques> (roslisp-msg-protocol:ros-message)
  ((torque1
    :reader torque1
    :initarg :torque1
    :type cl:float
    :initform 0.0)
   (torque2
    :reader torque2
    :initarg :torque2
    :type cl:float
    :initform 0.0)
   (torque3
    :reader torque3
    :initarg :torque3
    :type cl:float
    :initform 0.0)
   (torque4
    :reader torque4
    :initarg :torque4
    :type cl:float
    :initform 0.0)
   (torque5
    :reader torque5
    :initarg :torque5
    :type cl:float
    :initform 0.0)
   (torque6
    :reader torque6
    :initarg :torque6
    :type cl:float
    :initform 0.0)
   (torque7
    :reader torque7
    :initarg :torque7
    :type cl:float
    :initform 0.0)
   (torque8
    :reader torque8
    :initarg :torque8
    :type cl:float
    :initform 0.0)
   (torque9
    :reader torque9
    :initarg :torque9
    :type cl:float
    :initform 0.0))
)

(cl:defclass Torques (<Torques>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Torques>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Torques)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mobile_manipulator_msgs-msg:<Torques> is deprecated: use mobile_manipulator_msgs-msg:Torques instead.")))

(cl:ensure-generic-function 'torque1-val :lambda-list '(m))
(cl:defmethod torque1-val ((m <Torques>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mobile_manipulator_msgs-msg:torque1-val is deprecated.  Use mobile_manipulator_msgs-msg:torque1 instead.")
  (torque1 m))

(cl:ensure-generic-function 'torque2-val :lambda-list '(m))
(cl:defmethod torque2-val ((m <Torques>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mobile_manipulator_msgs-msg:torque2-val is deprecated.  Use mobile_manipulator_msgs-msg:torque2 instead.")
  (torque2 m))

(cl:ensure-generic-function 'torque3-val :lambda-list '(m))
(cl:defmethod torque3-val ((m <Torques>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mobile_manipulator_msgs-msg:torque3-val is deprecated.  Use mobile_manipulator_msgs-msg:torque3 instead.")
  (torque3 m))

(cl:ensure-generic-function 'torque4-val :lambda-list '(m))
(cl:defmethod torque4-val ((m <Torques>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mobile_manipulator_msgs-msg:torque4-val is deprecated.  Use mobile_manipulator_msgs-msg:torque4 instead.")
  (torque4 m))

(cl:ensure-generic-function 'torque5-val :lambda-list '(m))
(cl:defmethod torque5-val ((m <Torques>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mobile_manipulator_msgs-msg:torque5-val is deprecated.  Use mobile_manipulator_msgs-msg:torque5 instead.")
  (torque5 m))

(cl:ensure-generic-function 'torque6-val :lambda-list '(m))
(cl:defmethod torque6-val ((m <Torques>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mobile_manipulator_msgs-msg:torque6-val is deprecated.  Use mobile_manipulator_msgs-msg:torque6 instead.")
  (torque6 m))

(cl:ensure-generic-function 'torque7-val :lambda-list '(m))
(cl:defmethod torque7-val ((m <Torques>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mobile_manipulator_msgs-msg:torque7-val is deprecated.  Use mobile_manipulator_msgs-msg:torque7 instead.")
  (torque7 m))

(cl:ensure-generic-function 'torque8-val :lambda-list '(m))
(cl:defmethod torque8-val ((m <Torques>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mobile_manipulator_msgs-msg:torque8-val is deprecated.  Use mobile_manipulator_msgs-msg:torque8 instead.")
  (torque8 m))

(cl:ensure-generic-function 'torque9-val :lambda-list '(m))
(cl:defmethod torque9-val ((m <Torques>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mobile_manipulator_msgs-msg:torque9-val is deprecated.  Use mobile_manipulator_msgs-msg:torque9 instead.")
  (torque9 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Torques>) ostream)
  "Serializes a message object of type '<Torques>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'torque1))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'torque2))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'torque3))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'torque4))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'torque5))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'torque6))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'torque7))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'torque8))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'torque9))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Torques>) istream)
  "Deserializes a message object of type '<Torques>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'torque1) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'torque2) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'torque3) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'torque4) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'torque5) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'torque6) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'torque7) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'torque8) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'torque9) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Torques>)))
  "Returns string type for a message object of type '<Torques>"
  "mobile_manipulator_msgs/Torques")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Torques)))
  "Returns string type for a message object of type 'Torques"
  "mobile_manipulator_msgs/Torques")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Torques>)))
  "Returns md5sum for a message object of type '<Torques>"
  "51af3a57814ea678a622d88758f096dc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Torques)))
  "Returns md5sum for a message object of type 'Torques"
  "51af3a57814ea678a622d88758f096dc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Torques>)))
  "Returns full string definition for message of type '<Torques>"
  (cl:format cl:nil "float32 torque1~%float32 torque2~%float32 torque3~%float32 torque4~%float32 torque5~%float32 torque6~%float32 torque7~%float32 torque8~%float32 torque9~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Torques)))
  "Returns full string definition for message of type 'Torques"
  (cl:format cl:nil "float32 torque1~%float32 torque2~%float32 torque3~%float32 torque4~%float32 torque5~%float32 torque6~%float32 torque7~%float32 torque8~%float32 torque9~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Torques>))
  (cl:+ 0
     4
     4
     4
     4
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Torques>))
  "Converts a ROS message object to a list"
  (cl:list 'Torques
    (cl:cons ':torque1 (torque1 msg))
    (cl:cons ':torque2 (torque2 msg))
    (cl:cons ':torque3 (torque3 msg))
    (cl:cons ':torque4 (torque4 msg))
    (cl:cons ':torque5 (torque5 msg))
    (cl:cons ':torque6 (torque6 msg))
    (cl:cons ':torque7 (torque7 msg))
    (cl:cons ':torque8 (torque8 msg))
    (cl:cons ':torque9 (torque9 msg))
))
