
import 'package:flutter_3d_controller/src/data/datasources/flutter_3d_datasource.dart';

abstract class IFlutter3DRepository{
  void playAnimation();
  void pauseAnimation();
  void switchAnimation();
  Future<List<String>> getAvailableAnimations();
  void setCameraOrbit();
  void setCameraTarget();
}


class Flutter3DRepository extends IFlutter3DRepository{

  final IFlutter3DDatasource _datasource;
  Flutter3DRepository(this._datasource);


  @override
  void playAnimation() {
    _datasource.playAnimation();
  }


  @override
  void pauseAnimation() {
    _datasource.pauseAnimation();
  }

  @override
  void switchAnimation() {
    _datasource.switchAnimation();
  }

  @override
  Future<List<String>> getAvailableAnimations() {
    return _datasource.getAvailableAnimations();
  }


  @override
  void setCameraOrbit() {
    _datasource.setCameraOrbit();
  }

  @override
  void setCameraTarget() {
    _datasource.setCameraTarget();
  }


}