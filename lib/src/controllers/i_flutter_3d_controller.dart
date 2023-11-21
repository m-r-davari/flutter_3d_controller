
abstract class IFlutter3DController{
  void playAnimation({String? animationName});
  void pauseAnimation();
  Future<List<String>> getAvailableAnimations();
  void setCameraOrbit(double theta, double phi, double radius);
  void setCameraTarget(double x, double y, double z);
}
