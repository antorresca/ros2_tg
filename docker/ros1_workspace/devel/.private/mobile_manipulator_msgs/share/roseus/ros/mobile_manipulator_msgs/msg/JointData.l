;; Auto-generated. Do not edit!


(when (boundp 'mobile_manipulator_msgs::JointData)
  (if (not (find-package "MOBILE_MANIPULATOR_MSGS"))
    (make-package "MOBILE_MANIPULATOR_MSGS"))
  (shadow 'JointData (find-package "MOBILE_MANIPULATOR_MSGS")))
(unless (find-package "MOBILE_MANIPULATOR_MSGS::JOINTDATA")
  (make-package "MOBILE_MANIPULATOR_MSGS::JOINTDATA"))

(in-package "ROS")
;;//! \htmlinclude JointData.msg.html


(defclass mobile_manipulator_msgs::JointData
  :super ros::object
  :slots (_actual _desired ))

(defmethod mobile_manipulator_msgs::JointData
  (:init
   (&key
    ((:actual __actual) (instance mobile_manipulator_msgs::Joints :init))
    ((:desired __desired) (instance mobile_manipulator_msgs::Joints :init))
    )
   (send-super :init)
   (setq _actual __actual)
   (setq _desired __desired)
   self)
  (:actual
   (&rest __actual)
   (if (keywordp (car __actual))
       (send* _actual __actual)
     (progn
       (if __actual (setq _actual (car __actual)))
       _actual)))
  (:desired
   (&rest __desired)
   (if (keywordp (car __desired))
       (send* _desired __desired)
     (progn
       (if __desired (setq _desired (car __desired)))
       _desired)))
  (:serialization-length
   ()
   (+
    ;; mobile_manipulator_msgs/Joints _actual
    (send _actual :serialization-length)
    ;; mobile_manipulator_msgs/Joints _desired
    (send _desired :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; mobile_manipulator_msgs/Joints _actual
       (send _actual :serialize s)
     ;; mobile_manipulator_msgs/Joints _desired
       (send _desired :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; mobile_manipulator_msgs/Joints _actual
     (send _actual :deserialize buf ptr-) (incf ptr- (send _actual :serialization-length))
   ;; mobile_manipulator_msgs/Joints _desired
     (send _desired :deserialize buf ptr-) (incf ptr- (send _desired :serialization-length))
   ;;
   self)
  )

(setf (get mobile_manipulator_msgs::JointData :md5sum-) "b9180821b4f48e275f64a7616084c29b")
(setf (get mobile_manipulator_msgs::JointData :datatype-) "mobile_manipulator_msgs/JointData")
(setf (get mobile_manipulator_msgs::JointData :definition-)
      "Joints actual
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



(provide :mobile_manipulator_msgs/JointData "b9180821b4f48e275f64a7616084c29b")


