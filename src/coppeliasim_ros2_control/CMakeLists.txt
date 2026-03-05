cmake_minimum_required(VERSION 3.8)
project(coppeliasim_ros2_control)

find_package(ament_cmake REQUIRED)
find_package(rclpy REQUIRED)
find_package(sensor_msgs REQUIRED)
find_package(std_msgs REQUIRED)

install(PROGRAMS
  scripts/coppeliasim_bridge.py
  DESTINATION lib/${PROJECT_NAME}
)

ament_package()
