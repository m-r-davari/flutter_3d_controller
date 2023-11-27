// ignore_for_file: avoid_web_libraries_in_flutter
import 'package:flutter_3d_controller/src/data/datasources/i_flutter_3d_datasource.dart';
import 'dart:js' as js;

import 'package:webview_flutter/webview_flutter.dart';

class Flutter3DDatasource implements IFlutter3DDatasource{

  final WebViewController? _webViewController;
  Flutter3DDatasource([this._webViewController]);

  @override
  void playAnimation({String? animationName}) {
    animationName == null ?
    executeCustomJsCode(
        "const modelViewer = document.querySelector(\"model-viewer\");"
            "modelViewer.play();"
    )
        :
    executeCustomJsCode(
        "const modelViewer = document.querySelector(\"model-viewer\");"
            "modelViewer.animationName = \"$animationName\";"
            "modelViewer.play();"
    );
  }

  @override
  void pauseAnimation() {
    executeCustomJsCode(
        "const modelViewer = document.querySelector(\"model-viewer\");"
            "modelViewer.pause();"
    );
  }



  @override
  Future<List<String>> getAvailableAnimations()async{
    final result = await executeCustomJsCodeWithResult(
        "document.querySelector(\"model-viewer\").availableAnimations;"
    );
    return result.map<String>((e) => e.toString()).toList();
  }


  @override
  void setCameraOrbit(double theta, double phi, double radius) {
    executeCustomJsCode(
        "const modelViewer = document.querySelector(\"model-viewer\");"
            "modelViewer.cameraOrbit = \"${theta}deg ${phi}deg $radius%\";"//def orbit = "0deg 75deg 105%"
    );
  }

  @override
  void setCameraTarget(double x, double y, double z) {
    executeCustomJsCode(
        "const modelViewer = document.querySelector(\"model-viewer\");"
            "modelViewer.cameraTarget = \"${x}m ${y}m ${z}m\";"//def target = "auto auto auto"
    );
  }


  @override
  void executeCustomJsCode(String code) {
    js.context.callMethod("customEvaluate", [code]);
  }


  @override
  Future<dynamic> executeCustomJsCodeWithResult(String code) async {
    final js.JsArray<dynamic> result = await js.context.callMethod("customEvaluateWithResult", [code]);
    return result.toList();
  }

}