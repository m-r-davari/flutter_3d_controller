import 'package:flutter_3d_controller/src/controllers/i_flutter_3d_controller.dart';
import 'package:flutter_3d_controller/src/data/repositories/i_flutter_3d_repository.dart';


class Flutter3DController extends IFlutter3DController{

  IFlutter3DRepository? _repository;
  Flutter3DController();

  void init(IFlutter3DRepository repository){
    _repository = repository;
  }

  @override
  void playAnimation({String? animationName}){
    _repository?.playAnimation(animationName: animationName);
  }

  @override
  void pauseAnimation(){
    _repository?.pauseAnimation();
  }


  @override
  void resetAnimation() {
    _repository?.resetAnimation();
  }


  @override
  Future<List<String>> getAvailableAnimations()async{
    return await _repository?.getAvailableAnimations() ?? [];
  }


  @override
  void setTexture({required String textureName}) {
    _repository?.setTexture(textureName: textureName);
  }


  @override
  Future<List<String>> getAvailableTextures()async{
    return await _repository?.getAvailableTextures() ?? [];
  }


  @override
  void setCameraTarget(double x, double y, double z){
    _repository?.setCameraTarget(x,y,z);
  }


  @override
  void resetCameraTarget() {
    _repository?.resetCameraTarget();
  }


  @override
  void setCameraOrbit(double theta, double phi, double radius){
    _repository?.setCameraOrbit(theta,phi,radius);
  }


  @override
  void resetCameraOrbit() {
    _repository?.resetCameraOrbit();
  }


}