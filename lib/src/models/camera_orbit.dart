class CameraOrbit {
  double theta;
  double phi;
  double radius;

  CameraOrbit(this.theta, this.phi, this.radius);

  @override
  String toString() => "${theta}deg ${phi}deg ${radius}m";
}
