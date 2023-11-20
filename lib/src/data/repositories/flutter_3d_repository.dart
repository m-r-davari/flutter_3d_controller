import 'package:flutter_3d_controller/src/data/repositories/i_flutter_3d_repository.dart';
import 'package:flutter_3d_controller/src/data/datasources/i_flutter_3d_datasource.dart';

class Flutter3DRepository extends IFlutter3DRepository{

  final IFlutter3DDatasource _datasource;
  Flutter3DRepository(this._datasource);


  @override
  void playAnimation({String? animationName}) {
    _datasource.playAnimation(animationName: animationName);
  }


  @override
  void pauseAnimation() {
    _datasource.pauseAnimation();
  }


  @override
  Future<List<String>> getAvailableAnimations()async{
    return await _datasource.getAvailableAnimations();
  }


  @override
  void setCameraOrbit(double theta, double phi, double radius) {
    _datasource.setCameraOrbit(theta,phi,radius);
  }

  @override
  void setCameraTarget(double x, double y, double z) {
    _datasource.setCameraTarget(x,y,z);
  }


}