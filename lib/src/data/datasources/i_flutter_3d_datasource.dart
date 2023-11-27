import 'package:flutter_3d_controller/src/data/datasources/flutter_3d_datasource_mobile.dart' if (dart.library.js) "package:flutter_3d_controller/src/data/datasources/flutter_3d_datasource_web.dart";


abstract class IFlutter3DDatasource{

  /// Causes animations to be played, Can be use to switch animations as well.
  /// If animationName is null and model has at list one animation, it will play first model's animation
  /// If animationName passed and not null it will play specific animation
  void playAnimation({String? animationName});

  ///Causes animations to be paused.
  void pauseAnimation();

  /// It will return available animations list of 3D model as List<String>
  Future<List<String>> getAvailableAnimations();

  /// It will change camera orbit
  void setCameraOrbit(double theta, double phi, double radius);

  ///It will change camera target
  void setCameraTarget(double x, double y, double z);

  ///It will execute custom JS code
  void executeCustomJsCode(String code);

  ///It will execute custom JS code and returns result
  Future<dynamic> executeCustomJsCodeWithResult(String code);

  ///It will make specific instance of datasource per platform
  factory IFlutter3DDatasource(value) => Flutter3DDatasource(value);

}