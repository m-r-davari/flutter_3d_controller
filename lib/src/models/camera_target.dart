class CameraTarget {
  double x, y, z;

  /// [CameraTarget] class has 3 parameter
  /// [x] The x attribute receives a double value that indicates the position of the camera at the x position of the meter type.
  /// [y] The y attribute receives a double value that indicates the position of the camera at the y position of the meter type.
  /// [z] The z attribute receives a double value that indicates the position of the camera at the z position of the meter type.
  CameraTarget(this.x, this.y, this.z);

  @override
  String toString() => "${x}m ${y}m ${z}m";
}
