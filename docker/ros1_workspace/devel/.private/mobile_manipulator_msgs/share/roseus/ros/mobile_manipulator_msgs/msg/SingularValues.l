;; Auto-generated. Do not edit!


(when (boundp 'mobile_manipulator_msgs::SingularValues)
  (if (not (find-package "MOBILE_MANIPULATOR_MSGS"))
    (make-package "MOBILE_MANIPULATOR_MSGS"))
  (shadow 'SingularValues (find-package "MOBILE_MANIPULATOR_MSGS")))
(unless (find-package "MOBILE_MANIPULATOR_MSGS::SINGULARVALUES")
  (make-package "MOBILE_MANIPULATOR_MSGS::SINGULARVALUES"))

(in-package "ROS")
;;//! \htmlinclude SingularValues.msg.html


(defclass mobile_manipulator_msgs::SingularValues
  :super ros::object
  :slots (_min_pos_sv _min_ori_sv ))

(defmethod mobile_manipulator_msgs::SingularValues
  (:init
   (&key
    ((:min_pos_sv __min_pos_sv) 0.0)
    ((:min_ori_sv __min_ori_sv) 0.0)
    )
   (send-super :init)
   (setq _min_pos_sv (float __min_pos_sv))
   (setq _min_ori_sv (float __min_ori_sv))
   self)
  (:min_pos_sv
   (&optional __min_pos_sv)
   (if __min_pos_sv (setq _min_pos_sv __min_pos_sv)) _min_pos_sv)
  (:min_ori_sv
   (&optional __min_ori_sv)
   (if __min_ori_sv (setq _min_ori_sv __min_ori_sv)) _min_ori_sv)
  (:serialization-length
   ()
   (+
    ;; float32 _min_pos_sv
    4
    ;; float32 _min_ori_sv
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _min_pos_sv
       (sys::poke _min_pos_sv (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _min_ori_sv
       (sys::poke _min_ori_sv (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _min_pos_sv
     (setq _min_pos_sv (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _min_ori_sv
     (setq _min_ori_sv (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get mobile_manipulator_msgs::SingularValues :md5sum-) "f9c78d5181449c9ee849e15fab621090")
(setf (get mobile_manipulator_msgs::SingularValues :datatype-) "mobile_manipulator_msgs/SingularValues")
(setf (get mobile_manipulator_msgs::SingularValues :definition-)
      "float32 min_pos_sv
float32 min_ori_sv
")



(provide :mobile_manipulator_msgs/SingularValues "f9c78d5181449c9ee849e15fab621090")


