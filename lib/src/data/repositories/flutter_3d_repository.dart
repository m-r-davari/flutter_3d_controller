import 'package:flutter_3d_controller/src/data/repositories/i_flutter_3d_repository.dart';
import 'package:flutter_3d_controller/src/data/datasources/i_flutter_3d_datasource.dart';

class Flutter3DRepository extends IFlutter3DRepository {
  final IFlutter3DDatasource _datasource;

  Flutter3DRepository(this._datasource);

  @override
  void playAnimation({String? animationName, int loopCount = 0}) {
    _datasource.playAnimation(
      animationName: animationName,
      loopCount: loopCount,
    );
  }

  @override
  void pauseAnimation() {
    _datasource.pauseAnimation();
  }

  @override
  void resetAnimation() {
    _datasource.resetAnimation();
  }

  @override
  void stopAnimation() {
    _datasource.stopAnimation();
  }

  @override
  Future<List<String>> getAvailableAnimations() async {
    return await _datasource.getAvailableAnimations();
  }

  @override
  void setTexture({required String textureName}) {
    _datasource.setTexture(textureName: textureName);
  }

  @override
  Future<List<String>> getAvailableTextures() async {
    return await _datasource.getAvailableTextures();
  }

  @override
  void setCameraTarget(double x, double y, double z) {
    _datasource.setCameraTarget(x, y, z);
  }

  @override
  void resetCameraTarget() {
    _datasource.resetCameraTarget();
  }

  @override
  void setCameraOrbit(double theta, double phi, double radius, bool isAnimate) {
    _datasource.setCameraOrbit(theta, phi, radius, isAnimate);
  }

  @override
  void resetCameraOrbit() {
    _datasource.resetCameraOrbit();
  }
}
