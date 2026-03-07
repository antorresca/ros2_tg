;; Auto-generated. Do not edit!


(when (boundp 'mobile_manipulator_msgs::OrientationData)
  (if (not (find-package "MOBILE_MANIPULATOR_MSGS"))
    (make-package "MOBILE_MANIPULATOR_MSGS"))
  (shadow 'OrientationData (find-package "MOBILE_MANIPULATOR_MSGS")))
(unless (find-package "MOBILE_MANIPULATOR_MSGS::ORIENTATIONDATA")
  (make-package "MOBILE_MANIPULATOR_MSGS::ORIENTATIONDATA"))

(in-package "ROS")
;;//! \htmlinclude OrientationData.msg.html


(defclass mobile_manipulator_msgs::OrientationData
  :super ros::object
  :slots (_current_orient _desired_orient ))

(defmethod mobile_manipulator_msgs::OrientationData
  (:init
   (&key
    ((:current_orient __current_orient) (instance mobile_manipulator_msgs::RPY :init))
    ((:desired_orient __desired_orient) (instance mobile_manipulator_msgs::RPY :init))
    )
   (send-super :init)
   (setq _current_orient __current_orient)
   (setq _desired_orient __desired_orient)
   self)
  (:current_orient
   (&rest __current_orient)
   (if (keywordp (car __current_orient))
       (send* _current_orient __current_orient)
     (progn
       (if __current_orient (setq _current_orient (car __current_orient)))
       _current_orient)))
  (:desired_orient
   (&rest __desired_orient)
   (if (keywordp (car __desired_orient))
       (send* _desired_orient __desired_orient)
     (progn
       (if __desired_orient (setq _desired_orient (car __desired_orient)))
       _desired_orient)))
  (:serialization-length
   ()
   (+
    ;; mobile_manipulator_msgs/RPY _current_orient
    (send _current_orient :serialization-length)
    ;; mobile_manipulator_msgs/RPY _desired_orient
    (send _desired_orient :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; mobile_manipulator_msgs/RPY _current_orient
       (send _current_orient :serialize s)
     ;; mobile_manipulator_msgs/RPY _desired_orient
       (send _desired_orient :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; mobile_manipulator_msgs/RPY _current_orient
     (send _current_orient :deserialize buf ptr-) (incf ptr- (send _current_orient :serialization-length))
   ;; mobile_manipulator_msgs/RPY _desired_orient
     (send _desired_orient :deserialize buf ptr-) (incf ptr- (send _desired_orient :serialization-length))
   ;;
   self)
  )

(setf (get mobile_manipulator_msgs::OrientationData :md5sum-) "0ea91799dc6fd84b700660686d98fd66")
(setf (get mobile_manipulator_msgs::OrientationData :datatype-) "mobile_manipulator_msgs/OrientationData")
(setf (get mobile_manipulator_msgs::OrientationData :definition-)
      "RPY current_orient
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
")



(provide :mobile_manipulator_msgs/OrientationData "0ea91799dc6fd84b700660686d98fd66")


