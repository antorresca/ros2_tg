import os
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument
from launch.substitutions import LaunchConfiguration
from launch_ros.actions import Node


def generate_launch_description():

    robot_name_arg = DeclareLaunchArgument(
        'robot_name',
        default_value='mobile_manipulator',
        description='Robot namespace'
    )

    robot_name = LaunchConfiguration('robot_name')

    config = os.path.join(
        get_package_share_directory('mob_manipulator_controller'),
        'config',
        'config.yaml'
    )

    urdf_model_path = os.path.join(
        get_package_share_directory('mobile_manipulator_description'),
        'urdf',
        'robot_fixed.urdf'
    )

    models_packages = [
        get_package_share_directory('mobile_manipulator_description'),
    ]

    packages_names = [
        'mobile_manipulator_description',
    ]

    osc_controller_node = Node(
        package='mob_manipulator_controller',
        executable='mob_manipulator_controller',
        name='osc_controller',
        namespace=robot_name,
        output='screen',
        parameters=[
            config,
            {
                'odom_topic':       'odom',
                'urdf_model_path':  urdf_model_path,
                'models_packages':  models_packages,
                'packages_names':   packages_names,
            }
        ]
    )

    return LaunchDescription([
        robot_name_arg,
        osc_controller_node,
    ])