cmake_minimum_required(VERSION 3.8)
project(mobile_manipulator_msgs)

find_package(ament_cmake REQUIRED)
find_package(rosidl_default_generators REQUIRED)
find_package(std_msgs REQUIRED)
find_package(geometry_msgs REQUIRED)

rosidl_generate_interfaces(${PROJECT_NAME}
  "msg/RPY.msg"
  "msg/Vector3.msg"
  "msg/Joints.msg"
  "msg/PositionData.msg"
  "msg/OrientationData.msg"
  "msg/SingularValues.msg"
  "msg/JointData.msg"
  "msg/MobileManipulator.msg"
  "msg/Torques.msg"
  "msg/Trajectory.msg"
  DEPENDENCIES std_msgs geometry_msgs
)

ament_export_dependencies(rosidl_default_runtime)
ament_package()
