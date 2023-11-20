import 'package:flutter_3d_controller/src/data/datasources/i_flutter_3d_datasource.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:js';

class Flutter3DDatasource implements IFlutter3DDatasource{

  final WebViewController? _webViewController;
  Flutter3DDatasource([this._webViewController]);

  @override
  void playAnimation({String? animationName}) {
    throw UnimplementedError();
  }

  @override
  void pauseAnimation() {
    throw UnimplementedError();
  }



  @override
  Future<List<String>> getAvailableAnimations() {
    throw UnimplementedError();
  }


  @override
  void setCameraOrbit(double theta, double phi, double radius) {
    context.callMethod("cameraOrbit", [theta, phi, radius]);
  }

  @override
  void setCameraTarget(double x, double y, double z) {
    context.callMethod("cameraTarget", [x, y, z]);
  }


  void executeCustomJsCode(String code) {
    context.callMethod("customEvaluate", [code]);
  }


}