;; Auto-generated. Do not edit!


(when (boundp 'mobile_manipulator_msgs::Torques)
  (if (not (find-package "MOBILE_MANIPULATOR_MSGS"))
    (make-package "MOBILE_MANIPULATOR_MSGS"))
  (shadow 'Torques (find-package "MOBILE_MANIPULATOR_MSGS")))
(unless (find-package "MOBILE_MANIPULATOR_MSGS::TORQUES")
  (make-package "MOBILE_MANIPULATOR_MSGS::TORQUES"))

(in-package "ROS")
;;//! \htmlinclude Torques.msg.html


(defclass mobile_manipulator_msgs::Torques
  :super ros::object
  :slots (_torque1 _torque2 _torque3 _torque4 _torque5 _torque6 _torque7 _torque8 _torque9 ))

(defmethod mobile_manipulator_msgs::Torques
  (:init
   (&key
    ((:torque1 __torque1) 0.0)
    ((:torque2 __torque2) 0.0)
    ((:torque3 __torque3) 0.0)
    ((:torque4 __torque4) 0.0)
    ((:torque5 __torque5) 0.0)
    ((:torque6 __torque6) 0.0)
    ((:torque7 __torque7) 0.0)
    ((:torque8 __torque8) 0.0)
    ((:torque9 __torque9) 0.0)
    )
   (send-super :init)
   (setq _torque1 (float __torque1))
   (setq _torque2 (float __torque2))
   (setq _torque3 (float __torque3))
   (setq _torque4 (float __torque4))
   (setq _torque5 (float __torque5))
   (setq _torque6 (float __torque6))
   (setq _torque7 (float __torque7))
   (setq _torque8 (float __torque8))
   (setq _torque9 (float __torque9))
   self)
  (:torque1
   (&optional __torque1)
   (if __torque1 (setq _torque1 __torque1)) _torque1)
  (:torque2
   (&optional __torque2)
   (if __torque2 (setq _torque2 __torque2)) _torque2)
  (:torque3
   (&optional __torque3)
   (if __torque3 (setq _torque3 __torque3)) _torque3)
  (:torque4
   (&optional __torque4)
   (if __torque4 (setq _torque4 __torque4)) _torque4)
  (:torque5
   (&optional __torque5)
   (if __torque5 (setq _torque5 __torque5)) _torque5)
  (:torque6
   (&optional __torque6)
   (if __torque6 (setq _torque6 __torque6)) _torque6)
  (:torque7
   (&optional __torque7)
   (if __torque7 (setq _torque7 __torque7)) _torque7)
  (:torque8
   (&optional __torque8)
   (if __torque8 (setq _torque8 __torque8)) _torque8)
  (:torque9
   (&optional __torque9)
   (if __torque9 (setq _torque9 __torque9)) _torque9)
  (:serialization-length
   ()
   (+
    ;; float32 _torque1
    4
    ;; float32 _torque2
    4
    ;; float32 _torque3
    4
    ;; float32 _torque4
    4
    ;; float32 _torque5
    4
    ;; float32 _torque6
    4
    ;; float32 _torque7
    4
    ;; float32 _torque8
    4
    ;; float32 _torque9
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _torque1
       (sys::poke _torque1 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _torque2
       (sys::poke _torque2 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _torque3
       (sys::poke _torque3 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _torque4
       (sys::poke _torque4 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _torque5
       (sys::poke _torque5 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _torque6
       (sys::poke _torque6 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _torque7
       (sys::poke _torque7 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _torque8
       (sys::poke _torque8 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _torque9
       (sys::poke _torque9 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _torque1
     (setq _torque1 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _torque2
     (setq _torque2 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _torque3
     (setq _torque3 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _torque4
     (setq _torque4 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _torque5
     (setq _torque5 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _torque6
     (setq _torque6 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _torque7
     (setq _torque7 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _torque8
     (setq _torque8 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _torque9
     (setq _torque9 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get mobile_manipulator_msgs::Torques :md5sum-) "51af3a57814ea678a622d88758f096dc")
(setf (get mobile_manipulator_msgs::Torques :datatype-) "mobile_manipulator_msgs/Torques")
(setf (get mobile_manipulator_msgs::Torques :definition-)
      "float32 torque1
float32 torque2
float32 torque3
float32 torque4
float32 torque5
float32 torque6
float32 torque7
float32 torque8
float32 torque9
")



(provide :mobile_manipulator_msgs/Torques "51af3a57814ea678a622d88758f096dc")


