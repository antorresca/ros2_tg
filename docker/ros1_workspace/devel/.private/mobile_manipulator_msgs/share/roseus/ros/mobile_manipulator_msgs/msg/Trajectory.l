;; Auto-generated. Do not edit!


(when (boundp 'mobile_manipulator_msgs::Trajectory)
  (if (not (find-package "MOBILE_MANIPULATOR_MSGS"))
    (make-package "MOBILE_MANIPULATOR_MSGS"))
  (shadow 'Trajectory (find-package "MOBILE_MANIPULATOR_MSGS")))
(unless (find-package "MOBILE_MANIPULATOR_MSGS::TRAJECTORY")
  (make-package "MOBILE_MANIPULATOR_MSGS::TRAJECTORY"))

(in-package "ROS")
;;//! \htmlinclude Trajectory.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass mobile_manipulator_msgs::Trajectory
  :super ros::object
  :slots (_pose _vel _accel _joints ))

(defmethod mobile_manipulator_msgs::Trajectory
  (:init
   (&key
    ((:pose __pose) (instance geometry_msgs::Transform :init))
    ((:vel __vel) (instance geometry_msgs::Twist :init))
    ((:accel __accel) (instance geometry_msgs::Accel :init))
    ((:joints __joints) (instance mobile_manipulator_msgs::Joints :init))
    )
   (send-super :init)
   (setq _pose __pose)
   (setq _vel __vel)
   (setq _accel __accel)
   (setq _joints __joints)
   self)
  (:pose
   (&rest __pose)
   (if (keywordp (car __pose))
       (send* _pose __pose)
     (progn
       (if __pose (setq _pose (car __pose)))
       _pose)))
  (:vel
   (&rest __vel)
   (if (keywordp (car __vel))
       (send* _vel __vel)
     (progn
       (if __vel (setq _vel (car __vel)))
       _vel)))
  (:accel
   (&rest __accel)
   (if (keywordp (car __accel))
       (send* _accel __accel)
     (progn
       (if __accel (setq _accel (car __accel)))
       _accel)))
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
    ;; geometry_msgs/Transform _pose
    (send _pose :serialization-length)
    ;; geometry_msgs/Twist _vel
    (send _vel :serialization-length)
    ;; geometry_msgs/Accel _accel
    (send _accel :serialization-length)
    ;; mobile_manipulator_msgs/Joints _joints
    (send _joints :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Transform _pose
       (send _pose :serialize s)
     ;; geometry_msgs/Twist _vel
       (send _vel :serialize s)
     ;; geometry_msgs/Accel _accel
       (send _accel :serialize s)
     ;; mobile_manipulator_msgs/Joints _joints
       (send _joints :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Transform _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;; geometry_msgs/Twist _vel
     (send _vel :deserialize buf ptr-) (incf ptr- (send _vel :serialization-length))
   ;; geometry_msgs/Accel _accel
     (send _accel :deserialize buf ptr-) (incf ptr- (send _accel :serialization-length))
   ;; mobile_manipulator_msgs/Joints _joints
     (send _joints :deserialize buf ptr-) (incf ptr- (send _joints :serialization-length))
   ;;
   self)
  )

(setf (get mobile_manipulator_msgs::Trajectory :md5sum-) "3d2b7226198a8d6ec3af71882709c30d")
(setf (get mobile_manipulator_msgs::Trajectory :datatype-) "mobile_manipulator_msgs/Trajectory")
(setf (get mobile_manipulator_msgs::Trajectory :definition-)
      "geometry_msgs/Transform pose
geometry_msgs/Twist vel
geometry_msgs/Accel accel
Joints joints
================================================================================
MSG: geometry_msgs/Transform
# This represents the transform between two coordinate frames in free space.

Vector3 translation
Quaternion rotation

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
float64 z
================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: geometry_msgs/Twist
# This expresses velocity in free space broken into its linear and angular parts.
Vector3  linear
Vector3  angular

================================================================================
MSG: geometry_msgs/Accel
# This expresses acceleration in free space broken into its linear and angular parts.
Vector3  linear
Vector3  angular

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



(provide :mobile_manipulator_msgs/Trajectory "3d2b7226198a8d6ec3af71882709c30d")


