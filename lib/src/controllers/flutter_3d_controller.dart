
import 'package:flutter_3d_controller/src/data/repositories/flutter_3d_repository.dart';

abstract class Flutter3DController{
  void executeCustomJsCode(String code){
    UnimplementedError();
  }
}

abstract class ControllerAnimationInterface {
  void playAnimation();
  void pauseAnimation();
  void switchAnimation();
  Future<List<String>> getAvailableAnimations();
}

abstract class ControllerCameraInterface {
  void setCameraOrbit();
  void setCameraTarget();
}

class Flutter3DAnimationController extends Flutter3DController implements ControllerAnimationInterface{

  final IFlutter3DRepository _repository;
  Flutter3DAnimationController(this._repository);

  @override
  void playAnimation(){
    _repository.playAnimation();
  }

  @override
  void pauseAnimation(){
    _repository.pauseAnimation();
  }

  @override
  void switchAnimation(){
    _repository.switchAnimation();
  }

  @override
  Future<List<String>> getAvailableAnimations(){
    return _repository.getAvailableAnimations();
  }

}


class Flutter3DCameraController extends Flutter3DController implements ControllerCameraInterface{

  final IFlutter3DRepository _repository;
  Flutter3DCameraController(this._repository);

  @override
  void setCameraOrbit(){
    _repository.setCameraOrbit();
  }

  @override
  void setCameraTarget(){
    _repository.setCameraTarget();
  }

}