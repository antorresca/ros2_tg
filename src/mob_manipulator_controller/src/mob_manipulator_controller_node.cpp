#include "rclcpp/rclcpp.hpp"
#include "mob_manipulator_controller/Mob_Manipulator_Controller.hpp"

int main(int argc, char** argv)
{
    rclcpp::init(argc, argv);
    auto node = std::make_shared<mob_manipulator_controller::MobManipulatorController>();
    rclcpp::spin(node);
    rclcpp::shutdown();
    return 0;
}
