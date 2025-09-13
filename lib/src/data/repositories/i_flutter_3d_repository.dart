abstract class IFlutter3DRepository {
  /// Causes animations to be played, Can be use to switch animations as well.
  /// If animationName is null and model has at list one animation, it will play first model's animation
  /// If animationName passed and not null it will play specific animation.
  ///
  /// If loopCount > 0, the animation will loop for the specified count.
  /// If loopCount == 0, the animation will loop infinitely.
  /// (Default is 0)
  void playAnimation({
    String? animationName,
    int loopCount = 0,
  });

  ///Causes animations to be paused at current frame.
  void pauseAnimation();

  /// Causes animation to be played from first frame
  void resetAnimation();

  /// Causes animation to be stopped
  void stopAnimation();

  /// It will return available animations list of 3D model as [List<String>]
  Future<List<String>> getAvailableAnimations();

  /// It will change Texture of 3D model
  /// Can be used to load desire Texture of 3D model
  void setTexture({required String textureName});

  ///It will return available 3D models texture as [List<String>]
  Future<List<String>> getAvailableTextures();

  ///It will change camera target
  void setCameraTarget(double x, double y, double z);

  /// Causes camera orbit reset to default value
  void resetCameraTarget();

  /// It will change camera orbit
  void setCameraOrbit(double theta, double phi, double radius);

  /// Causes camera target reset to default value
  void resetCameraOrbit();

  /// Starts the rotation of the 3D model.
  /// [rotationSpeed] defines the speed of the rotation in degrees per second.
  /// Defaults to 10 if not provided.
  void startRotation({int rotationSpeed});

  /// Pauses the ongoing rotation, keeping the 3D model at its current orientation.
  /// The rotation can be resumed later without resetting the rotation state.
  void pauseRotation();

  /// Stops the rotation completely and resets the rotation state to the initial position.
  void stopRotation();

}
