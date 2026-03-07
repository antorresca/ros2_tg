;; Auto-generated. Do not edit!


(when (boundp 'mobile_manipulator_msgs::MobileManipulator)
  (if (not (find-package "MOBILE_MANIPULATOR_MSGS"))
    (make-package "MOBILE_MANIPULATOR_MSGS"))
  (shadow 'MobileManipulator (find-package "MOBILE_MANIPULATOR_MSGS")))
(unless (find-package "MOBILE_MANIPULATOR_MSGS::MOBILEMANIPULATOR")
  (make-package "MOBILE_MANIPULATOR_MSGS::MOBILEMANIPULATOR"))

(in-package "ROS")
;;//! \htmlinclude MobileManipulator.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass mobile_manipulator_msgs::MobileManipulator
  :super ros::object
  :slots (_header _position _orientation _singular _torques _joints ))

(defmethod mobile_manipulator_msgs::MobileManipulator
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:position __position) (instance mobile_manipulator_msgs::PositionData :init))
    ((:orientation __orientation) (instance mobile_manipulator_msgs::OrientationData :init))
    ((:singular __singular) (instance mobile_manipulator_msgs::SingularValues :init))
    ((:torques __torques) (instance mobile_manipulator_msgs::Torques :init))
    ((:joints __joints) (instance mobile_manipulator_msgs::JointData :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _position __position)
   (setq _orientation __orientation)
   (setq _singular __singular)
   (setq _torques __torques)
   (setq _joints __joints)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:position
   (&rest __position)
   (if (keywordp (car __position))
       (send* _position __position)
     (progn
       (if __position (setq _position (car __position)))
       _position)))
  (:orientation
   (&rest __orientation)
   (if (keywordp (car __orientation))
       (send* _orientation __orientation)
     (progn
       (if __orientation (setq _orientation (car __orientation)))
       _orientation)))
  (:singular
   (&rest __singular)
   (if (keywordp (car __singular))
       (send* _singular __singular)
     (progn
       (if __singular (setq _singular (car __singular)))
       _singular)))
  (:torques
   (&rest __torques)
   (if (keywordp (car __torques))
       (send* _torques __torques)
     (progn
       (if __torques (setq _torques (car __torques)))
       _torques)))
  (:joints
   (&rest __joints)
   (if (keywordp (car __joints))
       (send* _joints __joints)
     (progn
       (if __joints (setq _joints (car __joints)))
       _joints)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; mobile_manipulator_msgs/PositionData _position
    (send _position :serialization-length)
    ;; mobile_manipulator_msgs/OrientationData _orientation
    (send _orientation :serialization-length)
    ;; mobile_manipulator_msgs/SingularValues _singular
    (send _singular :serialization-length)
    ;; mobile_manipulator_msgs/Torques _torques
    (send _torques :serialization-length)
    ;; mobile_manipulator_msgs/JointData _joints
    (send _joints :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; mobile_manipulator_msgs/PositionData _position
       (send _position :serialize s)
     ;; mobile_manipulator_msgs/OrientationData _orientation
       (send _orientation :serialize s)
     ;; mobile_manipulator_msgs/SingularValues _singular
       (send _singular :serialize s)
     ;; mobile_manipulator_msgs/Torques _torques
       (send _torques :serialize s)
     ;; mobile_manipulator_msgs/JointData _joints
       (send _joints :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; mobile_manipulator_msgs/PositionData _position
     (send _position :deserialize buf ptr-) (incf ptr- (send _position :serialization-length))
   ;; mobile_manipulator_msgs/OrientationData _orientation
     (send _orientation :deserialize buf ptr-) (incf ptr- (send _orientation :serialization-length))
   ;; mobile_manipulator_msgs/SingularValues _singular
     (send _singular :deserialize buf ptr-) (incf ptr- (send _singular :serialization-length))
   ;; mobile_manipulator_msgs/Torques _torques
     (send _torques :deserialize buf ptr-) (incf ptr- (send _torques :serialization-length))
   ;; mobile_manipulator_msgs/JointData _joints
     (send _joints :deserialize buf ptr-) (incf ptr- (send _joints :serialization-length))
   ;;
   self)
  )

(setf (get mobile_manipulator_msgs::MobileManipulator :md5sum-) "b292abda1dc86e0e527bfb472074f00f")
(setf (get mobile_manipulator_msgs::MobileManipulator :datatype-) "mobile_manipulator_msgs/MobileManipulator")
(setf (get mobile_manipulator_msgs::MobileManipulator :definition-)
      "Header header
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
")



(provide :mobile_manipulator_msgs/MobileManipulator "b292abda1dc86e0e527bfb472074f00f")


