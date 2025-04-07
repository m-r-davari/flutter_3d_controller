import 'package:flutter/foundation.dart';
import 'package:flutter_3d_controller/src/controllers/i_flutter_3d_controller.dart';
import 'package:flutter_3d_controller/src/data/repositories/i_flutter_3d_repository.dart';
import 'package:flutter_3d_controller/src/core/exception/flutter_3d_controller_exception.dart';

class Flutter3DController extends IFlutter3DController {
  IFlutter3DRepository? _repository;

  Flutter3DController();

  ValueNotifier<bool> onModelLoaded = ValueNotifier<bool>(false);

  void init(IFlutter3DRepository repository) {
    _repository = repository;
  }

  @override
  void playAnimation({String? animationName, int loopCount = 0}) {
    if (onModelLoaded.value) {
      _repository?.playAnimation(
        animationName: animationName,
        loopCount: loopCount,
      );
    } else {
      throw Flutter3dControllerLoadingException();
    }
  }

  @override
  void pauseAnimation() {
    if (onModelLoaded.value) {
      _repository?.pauseAnimation();
    } else {
      throw Flutter3dControllerLoadingException();
    }
  }

  @override
  void resetAnimation() {
    if (onModelLoaded.value) {
      _repository?.resetAnimation();
    } else {
      throw Flutter3dControllerLoadingException();
    }
  }

  @override
  void stopAnimation() {
    if (onModelLoaded.value) {
      _repository?.stopAnimation();
    } else {
      throw Flutter3dControllerLoadingException();
    }
  }

  @override
  Future<List<String>> getAvailableAnimations() async {
    if (onModelLoaded.value) {
      return await _repository?.getAvailableAnimations() ?? [];
    } else {
      throw Flutter3dControllerLoadingException();
    }
  }

  @override
  void setTexture({required String textureName}) {
    if (onModelLoaded.value) {
      _repository?.setTexture(textureName: textureName);
    } else {
      throw Flutter3dControllerLoadingException();
    }
  }

  @override
  Future<List<String>> getAvailableTextures() async {
    if (onModelLoaded.value) {
      return await _repository?.getAvailableTextures() ?? [];
    } else {
      throw Flutter3dControllerLoadingException();
    }
  }

  @override
  void setCameraTarget(double x, double y, double z) {
    if (onModelLoaded.value) {
      _repository?.setCameraTarget(x, y, z);
    } else {
      throw Flutter3dControllerLoadingException();
    }
  }

  @override
  void resetCameraTarget() {
    if (onModelLoaded.value) {
      _repository?.resetCameraTarget();
    } else {
      throw Flutter3dControllerLoadingException();
    }
  }

  @override
  void setCameraOrbit(double theta, double phi, double radius) {
    if (onModelLoaded.value) {
      _repository?.setCameraOrbit(theta, phi, radius);
    } else {
      throw Flutter3dControllerLoadingException();
    }
  }

  @override
  void resetCameraOrbit() {
    if (onModelLoaded.value) {
      _repository?.resetCameraOrbit();
    } else {
      throw Flutter3dControllerLoadingException();
    }
  }
}
