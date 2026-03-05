#pragma once

#include "hardware_interface/system_interface.hpp"
#include "hardware_interface/types/hardware_interface_return_values.hpp"
#include "rclcpp/rclcpp.hpp"
#include "rclcpp_lifecycle/state.hpp"

// ZMQ Remote API
extern "C" {
#include "remoteApi.h"
}

namespace coppeliasim_ros2_control
{

class CoppeliaSimHardware : public hardware_interface::SystemInterface
{
public:
  hardware_interface::CallbackReturn on_init(
    const hardware_interface::HardwareInfo & info) override;

  hardware_interface::CallbackReturn on_activate(
    const rclcpp_lifecycle::State & previous_state) override;

  hardware_interface::CallbackReturn on_deactivate(
    const rclcpp_lifecycle::State & previous_state) override;

  std::vector<hardware_interface::StateInterface> export_state_interfaces() override;
  std::vector<hardware_interface::CommandInterface> export_command_interfaces() override;

  hardware_interface::return_type read(
    const rclcpp::Time & time,
    const rclcpp::Duration & period) override;

  hardware_interface::return_type write(
    const rclcpp::Time & time,
    const rclcpp::Duration & period) override;

private:
  // Handles de CoppeliaSim (obtenidos por nombre, no hardcodeados)
  std::vector<int> joint_handles_;

  // Buffers de estado
  std::vector<double> pos_;
  std::vector<double> vel_;

  // Buffers de comando
  std::vector<double> effort_cmd_;

  // Conexión ZMQ
  int client_id_{-1};
};

}  // namespace coppeliasim_ros2_control