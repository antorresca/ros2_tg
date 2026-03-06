#!/usr/bin/env python3
"""
CoppeliaSim Hardware Bridge - Thread dedicado, odometría desde simulación
"""

import math
import threading
import rclpy
from rclpy.node import Node
from sensor_msgs.msg import JointState
from std_msgs.msg import Float64MultiArray
from geometry_msgs.msg import Twist
from nav_msgs.msg import Odometry
from coppeliasim_zmqremoteapi_client import RemoteAPIClient

ARM_JOINT_NAMES = [
    'mobile_manipulator/waist_joint',
    'mobile_manipulator/shoulder_joint',
    'mobile_manipulator/elbow_joint',
    'mobile_manipulator/upper_forearm_joint',
    'mobile_manipulator/lower_forearm_joint',
    'mobile_manipulator/wrist_joint',
]

WHEEL_RADIUS = 0.06
ROBOT_RADIUS = 0.1825
WHEEL_ANGLES = [math.pi / 2,
                math.pi / 2 + 2 * math.pi / 3,
                math.pi / 2 - 2 * math.pi / 3]


class CoppeliaSimBridge(Node):

    def __init__(self):
        super().__init__('coppeliasim_bridge')

        self.get_logger().info('Conectando a CoppeliaSim...')
        self.client = RemoteAPIClient()
        self.sim = self.client.require('sim')
        self.get_logger().info('Conexión establecida.')

        self.client.setStepping(True)

        script_handle = self.sim.getScript(
            self.sim.scripttype_childscript,
            self.sim.getObject('/mobile_manipulator/mobile_base_link')
        )
        self.script_handle = script_handle
        self.get_logger().info(f'Script Lua: handle={script_handle}')

        self.sim.startSimulation()
        self.get_logger().info('Simulación iniciada.')

        self._lock = threading.Lock()
        self.tau_cmd       = [0.0] * 6
        self.wheel_vel_cmd = [0.0] * 3

        self.js_pub   = self.create_publisher(JointState, '/mobile_manipulator/joint_states', 10)
        self.odom_pub = self.create_publisher(Odometry,   '/mobile_manipulator/odom', 10)

        self.create_subscription(Float64MultiArray,
            '/mobile_manipulator/joint_efforts', self.effort_callback, 10)
        self.create_subscription(Twist,
            '/mobile_manipulator/commands/velocity', self.velocity_callback, 10)

        self._running = True
        self._sim_thread = threading.Thread(target=self._sim_loop, daemon=True)
        self._sim_thread.start()
        self.get_logger().info('Bridge activo en thread dedicado.')

    def effort_callback(self, msg: Float64MultiArray):
        if len(msg.data) == 6:
            with self._lock:
                self.tau_cmd = list(msg.data)

    def velocity_callback(self, msg: Twist):
        vx = msg.linear.x
        vy = msg.linear.y
        wz = msg.angular.z
        wheel_vels = []
        for i in range(3):
            a = WHEEL_ANGLES[i]
            wheel_vels.append((
                -math.sin(a) * vx +
                 math.cos(a) * vy +
                 ROBOT_RADIUS * wz
            ) / WHEEL_RADIUS)
        with self._lock:
            self.wheel_vel_cmd = wheel_vels

    def _sim_loop(self):
        while self._running:
            try:
                with self._lock:
                    tau       = list(self.tau_cmd)
                    wheel_vel = list(self.wheel_vel_cmd)

                self.sim.callScriptFunction(
                    'setCommands', self.script_handle,
                    {'tau': tau, 'wheels': wheel_vel}
                )

                self.client.step()

                state = self.sim.callScriptFunction('getState', self.script_handle, {})

                now = self.get_clock().now().to_msg()

                # JointState
                arm_pos = [((p + math.pi) % (2 * math.pi)) - math.pi for p in state['q']]
                js = JointState()
                js.header.stamp = now
                js.name     = ARM_JOINT_NAMES
                js.position = arm_pos
                js.velocity = state['dq']
                js.effort   = tau
                self.js_pub.publish(js)

                # Odometría directa desde CoppeliaSim
                self._publish_odometry(
                    state['base_pos'],
                    state['base_ori'],
                    state['base_lin_vel'],
                    state['base_ang_vel'],
                    now
                )

            except Exception as e:
                if self._running:
                    self.get_logger().error(f'Error en sim loop: {e}')

    def _publish_odometry(self, pos, ori, lin_vel, ang_vel, stamp):
        """
        Odometría directa desde CoppeliaSim.
        pos, ori: pose del base en frame global.
        lin_vel, ang_vel: velocidades en frame global — rotamos al frame del cuerpo.
        """
        x  = pos[0]; y  = pos[1]; z  = pos[2]
        qx = ori[0]; qy = ori[1]; qz = ori[2]; qw = ori[3]

        yaw = math.atan2(2*(qw*qz + qx*qy), 1 - 2*(qy*qy + qz*qz))

        # Rotar velocidad lineal global → frame del cuerpo
        vx_world = lin_vel[0]
        vy_world = lin_vel[1]
        vx_body =  vx_world * math.cos(yaw) + vy_world * math.sin(yaw)
        vy_body = -vx_world * math.sin(yaw) + vy_world * math.cos(yaw)
        wz_body = ang_vel[2]  # yaw rate es igual en ambos frames

        odom = Odometry()
        odom.header.stamp    = stamp
        odom.header.frame_id = 'odom'
        odom.child_frame_id  = 'mobile_manipulator/mobile_base_link'
        odom.pose.pose.position.x    = x
        odom.pose.pose.position.y    = y
        odom.pose.pose.position.z    = z
        odom.pose.pose.orientation.x = qx
        odom.pose.pose.orientation.y = qy
        odom.pose.pose.orientation.z = qz
        odom.pose.pose.orientation.w = qw
        odom.twist.twist.linear.x  = vx_body
        odom.twist.twist.linear.y  = vy_body
        odom.twist.twist.angular.z = wz_body
        self.odom_pub.publish(odom)


def main(args=None):
    rclpy.init(args=args)
    node = CoppeliaSimBridge()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        node._running = False
        node._sim_thread.join(timeout=2.0)
        try:
            node.sim.stopSimulation()
            node.client.setStepping(False)
        except:
            pass
        node.destroy_node()
        rclpy.shutdown()


if __name__ == '__main__':
    main()