#!/usr/bin/env python3
"""
CoppeliaSim Hardware Bridge Node
Conecta el controlador WBC con CoppeliaSim via ZMQ Remote API.

Suscribe:  /mobile_manipulator/joint_efforts  (Float64MultiArray) — torques del WBC (6 joints brazo)
           /mobile_manipulator/commands/velocity (Twist)          — velocidad base móvil

Publica:   /mobile_manipulator/joint_states   (JointState)        — q, dq del brazo
           /mobile_manipulator/odom           (Odometry)          — odometría base móvil
"""

import math
import rclpy
from rclpy.node import Node
from sensor_msgs.msg import JointState
from std_msgs.msg import Float64MultiArray
from geometry_msgs.msg import Twist
from nav_msgs.msg import Odometry
from coppeliasim_zmqremoteapi_client import RemoteAPIClient

# ── Nombres de joints en CoppeliaSim ──────────────────────────────────────────
WHEEL_NAMES = [
    'mobile_manipulator/wheel0_joint',
    'mobile_manipulator/wheel1_joint',
    'mobile_manipulator/wheel2_joint',
]

ARM_JOINT_NAMES = [
    'mobile_manipulator/waist_joint',
    'mobile_manipulator/shoulder_joint',
    'mobile_manipulator/elbow_joint',
    'mobile_manipulator/upper_forearm_joint',
    'mobile_manipulator/lower_forearm_joint',
    'mobile_manipulator/wrist_joint',
]

ALL_JOINT_NAMES = WHEEL_NAMES + ARM_JOINT_NAMES

# ── Parámetros cinemáticos del Robotino (del URDF) ────────────────────────────
WHEEL_RADIUS = 0.06      # m — radio de cada rueda
ROBOT_RADIUS = 0.1825    # m — distancia del centro a cada rueda (wheel0 en Y)

# Ángulos de cada rueda respecto al eje X del robot (en radianes)
# wheel0: Y=+0.1825 → 90°
# wheel1: rotación 120°  → 90° + 120° = 210°
# wheel2: rotación -120° → 90° - 120° = -30°
WHEEL_ANGLES = [math.pi / 2,
                math.pi / 2 + 2 * math.pi / 3,
                math.pi / 2 - 2 * math.pi / 3]


class CoppeliaSimBridge(Node):

    def __init__(self):
        super().__init__('coppeliasim_bridge')

        # ── Conectar a CoppeliaSim ─────────────────────────────────────────────
        self.get_logger().info('Conectando a CoppeliaSim...')
        self.sim = RemoteAPIClient().require('sim')
        self.get_logger().info('Conexión establecida.')

        # ── Obtener handles ────────────────────────────────────────────────────
        self.handles = {}
        for name in ALL_JOINT_NAMES:
            h = self.sim.getObject(f'/{name}')
            self.handles[name] = h
            self.get_logger().info(f'  {name} → handle={h}')

        # ── Modo fuerza en joints del brazo ────────────────────────────────────
        for name in ARM_JOINT_NAMES:
            self.sim.setJointMode(self.handles[name], self.sim.jointmode_force, 0)
        self.get_logger().info('Joints del brazo en modo fuerza.')

        # ── Modo velocidad en ruedas ───────────────────────────────────────────
        for name in WHEEL_NAMES:
            h = self.handles[name]
            self.sim.setJointMode(h, self.sim.jointmode_dynamic, 0)
            self.sim.setObjectInt32Param(h, self.sim.jointintparam_motor_enabled, 1)
            self.sim.setObjectInt32Param(h, self.sim.jointintparam_ctrl_enabled, 1)
            self.sim.setJointTargetVelocity(h, 0.0)
            self.sim.setJointMaxForce(h, 100.0)  # prueba alto

        # ── Buffers de comandos ────────────────────────────────────────────────
        self.effort_cmd  = {name: 0.0 for name in ARM_JOINT_NAMES}
        self.wheel_vel_cmd = {name: 0.0 for name in WHEEL_NAMES}  # rad/s

        # ── Odometría ──────────────────────────────────────────────────────────
        self.odom_x   = 0.0
        self.odom_y   = 0.0
        self.odom_yaw = 0.0
        self.prev_wheel_pos = None  # posiciones angulares previas de las ruedas

        # ── Publishers ─────────────────────────────────────────────────────────
        self.js_pub   = self.create_publisher(
            JointState, '/mobile_manipulator/joint_states', 10)
        self.odom_pub = self.create_publisher(
            Odometry, '/mobile_manipulator/odom', 10)

        # ── Subscribers ────────────────────────────────────────────────────────
        self.effort_sub = self.create_subscription(
            Float64MultiArray,
            '/mobile_manipulator/joint_efforts',
            self.effort_callback,
            10)

        self.vel_sub = self.create_subscription(
            Twist,
            '/mobile_manipulator/commands/velocity',
            self.velocity_callback,
            10)

        # ── Timer principal a 200 Hz ───────────────────────────────────────────
        self.dt = 0.005
        self.timer = self.create_timer(self.dt, self.control_loop)
        self.get_logger().info('Bridge activo a 200 Hz.')

    # ── Callbacks ──────────────────────────────────────────────────────────────

    def effort_callback(self, msg: Float64MultiArray):
        """Recibe [tau_waist, tau_shoulder, tau_elbow,
                   tau_upper_forearm, tau_lower_forearm, tau_wrist]"""
        if len(msg.data) != len(ARM_JOINT_NAMES):
            self.get_logger().warn(
                f'Se esperaban {len(ARM_JOINT_NAMES)} torques, '
                f'llegaron {len(msg.data)}')
            return
        for i, name in enumerate(ARM_JOINT_NAMES):
            self.effort_cmd[name] = msg.data[i]

    def velocity_callback(self, msg: Twist):
        """
        Convierte velocidad cartesiana (vx, vy, wz) a velocidades de rueda.
        Cinemática inversa Robotino omnidireccional 3 ruedas.
        """
        vx = msg.linear.x
        vy = msg.linear.y
        wz = msg.angular.z

        for i, name in enumerate(WHEEL_NAMES):
            alpha = WHEEL_ANGLES[i]
            # v_wheel = (-sin(alpha)*vx + cos(alpha)*vy + R*wz) / r
            v_wheel = (-math.sin(alpha) * vx +
                        math.cos(alpha) * vy +
                        ROBOT_RADIUS * wz) / WHEEL_RADIUS
            self.wheel_vel_cmd[name] = v_wheel

    # ── Loop principal ─────────────────────────────────────────────────────────

    def control_loop(self):
        try:
            now = self.get_clock().now().to_msg()

            # 1. Enviar torques al brazo
            for name, tau in self.effort_cmd.items():
                self.sim.setJointTargetForce(self.handles[name], tau)

            # 2. Enviar velocidades a las ruedas
            for name, vel in self.wheel_vel_cmd.items():
                self.sim.setJointTargetVelocity(self.handles[name], vel)

            # 3. Leer posiciones y velocidades de todos los joints
            pos_all = [self.sim.getJointPosition(self.handles[n]) for n in ALL_JOINT_NAMES]
            vel_all = [self.sim.getJointVelocity(self.handles[n]) for n in ALL_JOINT_NAMES]
            eff_all = ([0.0] * len(WHEEL_NAMES) +
                       [self.effort_cmd.get(n, 0.0) for n in ARM_JOINT_NAMES])

            # Normalizar posiciones del brazo a [-pi, pi]
            arm_pos = [((p + math.pi) % (2 * math.pi)) - math.pi
                       for p in pos_all[len(WHEEL_NAMES):]]
            arm_vel = vel_all[len(WHEEL_NAMES):]
            arm_eff = eff_all[len(WHEEL_NAMES):]

            # 4. Publicar JointState (solo brazo, que es lo que usa el WBC)
            js = JointState()
            js.header.stamp = now
            js.name     = ARM_JOINT_NAMES
            js.position = arm_pos
            js.velocity = arm_vel
            js.effort   = arm_eff
            self.js_pub.publish(js)

            # 5. Calcular y publicar odometría desde posición de ruedas
            wheel_pos_now = pos_all[:len(WHEEL_NAMES)]
            self._publish_odometry(wheel_pos_now, now)

        except Exception as e:
            self.get_logger().error(f'Error en control loop: {e}')

    def _publish_odometry(self, wheel_pos_now, stamp):
        """
        Calcula odometría por integración de cinemática directa de ruedas.
        Si CoppeliaSim da la pose del base directamente, se puede simplificar,
        pero este método funciona sin acceso a la pose del cuerpo.
        """
        if self.prev_wheel_pos is None:
            self.prev_wheel_pos = wheel_pos_now
            return

        # Incremento angular de cada rueda
        d_theta = [wheel_pos_now[i] - self.prev_wheel_pos[i]
                   for i in range(len(WHEEL_NAMES))]
        self.prev_wheel_pos = wheel_pos_now

        # Cinemática directa: [vx, vy, wz] = (r/3) * J^T * d_theta
        # J^T para Robotino:
        # | -sin(a0)  -sin(a1)  -sin(a2) |
        # |  cos(a0)   cos(a1)   cos(a2) |
        # | 1/R       1/R       1/R      |
        r = WHEEL_RADIUS
        R = ROBOT_RADIUS
        a = WHEEL_ANGLES

        dx_body = (r / 3.0) * (
            -math.sin(a[0]) * d_theta[0]
            - math.sin(a[1]) * d_theta[1]
            - math.sin(a[2]) * d_theta[2])

        dy_body = (r / 3.0) * (
             math.cos(a[0]) * d_theta[0]
           + math.cos(a[1]) * d_theta[1]
           + math.cos(a[2]) * d_theta[2])

        d_yaw = (r / (3.0 * R)) * (
            d_theta[0] + d_theta[1] + d_theta[2])

        # Rotar al frame global e integrar
        yaw = self.odom_yaw
        self.odom_x   += dx_body * math.cos(yaw) - dy_body * math.sin(yaw)
        self.odom_y   += dx_body * math.sin(yaw) + dy_body * math.cos(yaw)
        self.odom_yaw += d_yaw

        # Velocidades en frame del cuerpo
        vx_body = dx_body / self.dt
        vy_body = dy_body / self.dt
        wz      = d_yaw   / self.dt

        # Quaternion desde yaw
        qz = math.sin(self.odom_yaw / 2.0)
        qw = math.cos(self.odom_yaw / 2.0)

        odom = Odometry()
        odom.header.stamp    = stamp
        odom.header.frame_id = 'odom'
        odom.child_frame_id  = 'mobile_manipulator/mobile_base_link'

        odom.pose.pose.position.x    = self.odom_x
        odom.pose.pose.position.y    = self.odom_y
        odom.pose.pose.position.z    = 0.0
        odom.pose.pose.orientation.x = 0.0
        odom.pose.pose.orientation.y = 0.0
        odom.pose.pose.orientation.z = qz
        odom.pose.pose.orientation.w = qw

        odom.twist.twist.linear.x  = vx_body
        odom.twist.twist.linear.y  = vy_body
        odom.twist.twist.angular.z = wz

        self.odom_pub.publish(odom)


def main(args=None):
    rclpy.init(args=args)
    node = CoppeliaSimBridge()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        for name in ARM_JOINT_NAMES:
            try:
                node.sim.setJointTargetForce(node.handles[name], 0.0)
                node.sim.setJointMode(node.handles[name], node.sim.jointmode_kinematic, 0)
            except:
                pass
        for name in WHEEL_NAMES:
            try:
                node.sim.setJointTargetVelocity(node.handles[name], 0.0)
                node.sim.setJointMode(node.handles[name], node.sim.jointmode_kinematic, 0)
            except:
                pass
        node.destroy_node()
        rclpy.shutdown()


if __name__ == '__main__':
    main()