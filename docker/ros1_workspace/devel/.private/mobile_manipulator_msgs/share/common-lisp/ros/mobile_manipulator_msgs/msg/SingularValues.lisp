; Auto-generated. Do not edit!


(cl:in-package mobile_manipulator_msgs-msg)


;//! \htmlinclude SingularValues.msg.html

(cl:defclass <SingularValues> (roslisp-msg-protocol:ros-message)
  ((min_pos_sv
    :reader min_pos_sv
    :initarg :min_pos_sv
    :type cl:float
    :initform 0.0)
   (min_ori_sv
    :reader min_ori_sv
    :initarg :min_ori_sv
    :type cl:float
    :initform 0.0))
)

(cl:defclass SingularValues (<SingularValues>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SingularValues>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SingularValues)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mobile_manipulator_msgs-msg:<SingularValues> is deprecated: use mobile_manipulator_msgs-msg:SingularValues instead.")))

(cl:ensure-generic-function 'min_pos_sv-val :lambda-list '(m))
(cl:defmethod min_pos_sv-val ((m <SingularValues>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mobile_manipulator_msgs-msg:min_pos_sv-val is deprecated.  Use mobile_manipulator_msgs-msg:min_pos_sv instead.")
  (min_pos_sv m))

(cl:ensure-generic-function 'min_ori_sv-val :lambda-list '(m))
(cl:defmethod min_ori_sv-val ((m <SingularValues>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mobile_manipulator_msgs-msg:min_ori_sv-val is deprecated.  Use mobile_manipulator_msgs-msg:min_ori_sv instead.")
  (min_ori_sv m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SingularValues>) ostream)
  "Serializes a message object of type '<SingularValues>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'min_pos_sv))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'min_ori_sv))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SingularValues>) istream)
  "Deserializes a message object of type '<SingularValues>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'min_pos_sv) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'min_ori_sv) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SingularValues>)))
  "Returns string type for a message object of type '<SingularValues>"
  "mobile_manipulator_msgs/SingularValues")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SingularValues)))
  "Returns string type for a message object of type 'SingularValues"
  "mobile_manipulator_msgs/SingularValues")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SingularValues>)))
  "Returns md5sum for a message object of type '<SingularValues>"
  "f9c78d5181449c9ee849e15fab621090")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SingularValues)))
  "Returns md5sum for a message object of type 'SingularValues"
  "f9c78d5181449c9ee849e15fab621090")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SingularValues>)))
  "Returns full string definition for message of type '<SingularValues>"
  (cl:format cl:nil "float32 min_pos_sv~%float32 min_ori_sv~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SingularValues)))
  "Returns full string definition for message of type 'SingularValues"
  (cl:format cl:nil "float32 min_pos_sv~%float32 min_ori_sv~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SingularValues>))
  (cl:+ 0
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SingularValues>))
  "Converts a ROS message object to a list"
  (cl:list 'SingularValues
    (cl:cons ':min_pos_sv (min_pos_sv msg))
    (cl:cons ':min_ori_sv (min_ori_sv msg))
))
