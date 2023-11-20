import 'package:flutter_3d_controller/src/data/datasources/flutter_3d_datasource_mobile.dart' if (dart.library.js) "package:flutter_3d_controller/src/data/datasources/flutter_3d_datasource_web.dart";


abstract class IFlutter3DDatasource{
  void playAnimation({String? animationName});
  void pauseAnimation();
  Future<List<String>> getAvailableAnimations();
  void setCameraOrbit(double theta, double phi, double radius);
  void setCameraTarget(double x, double y, double z);


  // static IFlutter3DDatasource generate (value){
  //   return Flutter3DDatasource(value);
  // }

  factory IFlutter3DDatasource(value) => Flutter3DDatasource(value);


}