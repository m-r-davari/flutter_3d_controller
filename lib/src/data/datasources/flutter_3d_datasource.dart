
abstract class IFlutter3DDatasource{
  void playAnimation();
  void pauseAnimation();
  void switchAnimation();
  Future<List<String>> getAvailableAnimations();
  void setCameraOrbit();
  void setCameraTarget();
}


class Flutter3DDatasource extends IFlutter3DDatasource{

  @override
  void playAnimation() {
    // TODO: implement playAnimation
  }

  @override
  void pauseAnimation() {
    // TODO: implement pauseAnimation
  }

  @override
  void switchAnimation() {
    // TODO: implement switchAnimation
  }

  @override
  Future<List<String>> getAvailableAnimations() {
    // TODO: implement getAvailableAnimations
    throw UnimplementedError();
  }


  @override
  void setCameraOrbit() {
    // TODO: implement setCameraOrbit
  }

  @override
  void setCameraTarget() {
    // TODO: implement setCameraTarget
  }


}