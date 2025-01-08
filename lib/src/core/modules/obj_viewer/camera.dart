import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart';

class Camera {
  Camera({
    Vector3? position,
    Vector3? target,
    Vector3? up,
    this.fov = 60.0,
    this.near = 0.1,
    this.far = 1000,
    this.zoom = 1.0,
    this.viewportWidth = 100.0,
    this.viewportHeight = 100.0,
  }) {
    if (position != null) position.copyInto(this.position);
    if (target != null) target.copyInto(this.target);
    if (up != null) up.copyInto(this.up);
  }

  final Vector3 position = Vector3(0.0, 0.0, -10.0);
  final Vector3 target = Vector3(0.0, 0.0, 0.0);
  Vector3 up = Vector3(0.0, 1.0, 0.0);
  double fov;
  double near;
  double far;
  double zoom;
  double viewportWidth;
  double viewportHeight;

  double get aspectRatio => viewportWidth / viewportHeight;

  Matrix4 get lookAtMatrix {
    return makeViewMatrix(position, target, up);
  }

  Matrix4 get projectionMatrix {
    final double top = near * math.tan(radians(fov) / 2.0) / zoom;
    final double bottom = -top;
    final double right = top * aspectRatio;
    final double left = -right;
    return makeFrustumMatrix(left, right, bottom, top, near, far);
  }

  /*
  * The bug related to unwanted rotation was fixed by M.R.Davari on October 5, 2024.
  * */
  void trackBall(Vector2 from, Vector2 to, [double sensitivity = 1.0]) {
    // Calculate drag deltas (differences) between 'from' and 'to' points
    final double x = -(to.x - from.x) * sensitivity / (viewportWidth * 0.5);
    final double y = (to.y - from.y) * sensitivity / (viewportHeight * 0.5);
    Vector2 delta = Vector2(x, y);

    // Calculate the movement direction and angle based on the drag input
    Vector3 eye = position - target; // Camera view direction
    Vector3 eyeDirection = eye.normalized();
    Vector3 upDirection = up.normalized();

    // Check the vertical rotation and limit it
    // Project the camera's position onto the Y-axis (up vector)
    double verticalDot = eyeDirection.dot(upDirection);

    // Define a limit to prevent vertical flipping (limit how close we can get to directly above or below)
    const double verticalLimit =
        0.99; // Close to 1.0 means close to top or bottom

    // If the camera is near the top or bottom, and trying to rotate further vertically, stop execution
    if ((verticalDot > verticalLimit && delta.y > 0) ||
        (verticalDot < -verticalLimit && delta.y < 0)) {
      return; // Prevent further vertical rotation when near the top or bottom edge
    }

    // Continue normal trackball logic for rotation
    Vector3 sidewaysDirection = upDirection.cross(eyeDirection).normalized();
    upDirection.scale(delta.y);
    sidewaysDirection.scale(delta.x);
    Vector3 moveDirection = upDirection + sidewaysDirection;
    final double angle = moveDirection.length;

    if (angle > 0) {
      Vector3 axis = moveDirection.cross(eye).normalized();
      Quaternion q = Quaternion.axisAngle(axis, angle);
      q.rotate(position);
      q.rotate(up);
    }

    // Stabilize the up vector to prevent unnatural tilting
    stabilizeUpVector();
  }

// Helper function to stabilize the up vector and prevent unnatural tilting
  void stabilizeUpVector() {
    up = Vector3(
        0, 1, 0); // Keep the up vector pointing upwards along the Y-axis
  }
}
