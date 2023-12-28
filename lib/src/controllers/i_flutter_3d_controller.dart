
abstract class IFlutter3DController{

  /// Causes animations to be played, Can be use to switch animations as well.
  /// If animationName is null and model has at list one animation, it will play first model's animation
  /// If animationName passed and not null it will play specific animation.
  void playAnimation({String? animationName});

  ///Causes animations to be paused.
  void pauseAnimation();

  /// Causes animation to be played from first frame
  void resetAnimation();

  /// It will return available animations list of 3D model as List<String>
  Future<List<String>> getAvailableAnimations();

  /// It will change Texture of 3D model
  /// Can be used to load desire Texture of 3D model
  void setTexture({required String textureName});

  ///It will return available 3D models texture as List<String>
  Future<List<String>> getAvailableTextures();

  ///It will change camera target
  void setCameraTarget(double x, double y, double z);

  /// Causes camera orbit reset to default value
  void resetCameraTarget();

  /// It will change camera orbit
  void setCameraOrbit(double theta, double phi, double radius);

  /// Causes camera target reset to default value
  void resetCameraOrbit();

}
