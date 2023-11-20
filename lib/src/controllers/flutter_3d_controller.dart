import 'package:flutter/cupertino.dart';
import 'package:flutter_3d_controller/src/controllers/i_flutter_3d_controller.dart';
import 'package:flutter_3d_controller/src/data/repositories/i_flutter_3d_repository.dart';


class Flutter3DController extends IFlutter3DController with ChangeNotifier {

  late IFlutter3DRepository _repository;
  Flutter3DController();

  void init(IFlutter3DRepository repository){
    _repository = repository;
  }

  @override
  void playAnimation(){
    _repository.playAnimation();
  }

  @override
  void pauseAnimation(){
    _repository.pauseAnimation();
  }

  @override
  Future<List<String>> getAvailableAnimations(){
    return _repository.getAvailableAnimations();
  }

  @override
  void setCameraOrbit(double theta, double phi, double radius){
    _repository.setCameraOrbit(theta,phi,radius);
  }

  @override
  void setCameraTarget(double x, double y, double z){
    _repository.setCameraTarget(x,y,z);
  }

}