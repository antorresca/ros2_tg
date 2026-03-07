;; Auto-generated. Do not edit!


(when (boundp 'mobile_manipulator_msgs::PositionData)
  (if (not (find-package "MOBILE_MANIPULATOR_MSGS"))
    (make-package "MOBILE_MANIPULATOR_MSGS"))
  (shadow 'PositionData (find-package "MOBILE_MANIPULATOR_MSGS")))
(unless (find-package "MOBILE_MANIPULATOR_MSGS::POSITIONDATA")
  (make-package "MOBILE_MANIPULATOR_MSGS::POSITIONDATA"))

(in-package "ROS")
;;//! \htmlinclude PositionData.msg.html


(defclass mobile_manipulator_msgs::PositionData
  :super ros::object
  :slots (_current_position _desired_position ))

(defmethod mobile_manipulator_msgs::PositionData
  (:init
   (&key
    ((:current_position __current_position) (instance mobile_manipulator_msgs::Vector3 :init))
    ((:desired_position __desired_position) (instance mobile_manipulator_msgs::Vector3 :init))
    )
   (send-super :init)
   (setq _current_position __current_position)
   (setq _desired_position __desired_position)
   self)
  (:current_position
   (&rest __current_position)
   (if (keywordp (car __current_position))
       (send* _current_position __current_position)
     (progn
       (if __current_position (setq _current_position (car __current_position)))
       _current_position)))
  (:desired_position
   (&rest __desired_position)
   (if (keywordp (car __desired_position))
       (send* _desired_position __desired_position)
     (progn
       (if __desired_position (setq _desired_position (car __desired_position)))
       _desired_position)))
  (:serialization-length
   ()
   (+
    ;; mobile_manipulator_msgs/Vector3 _current_position
    (send _current_position :serialization-length)
    ;; mobile_manipulator_msgs/Vector3 _desired_position
    (send _desired_position :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; mobile_manipulator_msgs/Vector3 _current_position
       (send _current_position :serialize s)
     ;; mobile_manipulator_msgs/Vector3 _desired_position
       (send _desired_position :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; mobile_manipulator_msgs/Vector3 _current_position
     (send _current_position :deserialize buf ptr-) (incf ptr- (send _current_position :serialization-length))
   ;; mobile_manipulator_msgs/Vector3 _desired_position
     (send _desired_position :deserialize buf ptr-) (incf ptr- (send _desired_position :serialization-length))
   ;;
   self)
  )

(setf (get mobile_manipulator_msgs::PositionData :md5sum-) "f6920a2c98186d4bf709632ac111101d")
(setf (get mobile_manipulator_msgs::PositionData :datatype-) "mobile_manipulator_msgs/PositionData")
(setf (get mobile_manipulator_msgs::PositionData :definition-)
      "Vector3 current_position
Vector3 desired_position
================================================================================
MSG: mobile_manipulator_msgs/Vector3
float32 x
float32 y
float32 z
")



(provide :mobile_manipulator_msgs/PositionData "f6920a2c98186d4bf709632ac111101d")


