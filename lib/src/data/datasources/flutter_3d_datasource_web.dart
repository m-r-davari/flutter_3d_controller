// ignore_for_file: avoid_web_libraries_in_flutter
import 'package:flutter_3d_controller/src/core/exception/flutter_3d_controller_exception.dart';
import 'package:flutter_3d_controller/src/data/datasources/i_flutter_3d_datasource.dart';
import 'dart:js' as js;

class Flutter3DDatasource implements IFlutter3DDatasource {
  final String _viewerId;

  Flutter3DDatasource(
    this._viewerId, [
    webViewController,
    activeGestureInterceptor = false,
  ]);

  @override
  void playAnimation({
    String? animationName,
    int loopCount = 0,
  }) {
    String loopValue = loopCount <= 0 ? 'Infinity' : loopCount.toString();
    animationName == null
        ? executeCustomJsCode(
            "const modelViewer = document.getElementById(\"$_viewerId\");"
            "modelViewer.updateComplete.then(() => {"
              "modelViewer.play({repetitions: \"$loopValue\"});"
            "});")
        : executeCustomJsCode(
            "const modelViewer = document.getElementById(\"$_viewerId\");"
            "modelViewer.pause();"
            "modelViewer.animationName = \"\";"
            "modelViewer.animationName = \"$animationName\";"
            "modelViewer.updateComplete.then(() => {"
              "modelViewer.play({repetitions: \"$loopValue\"});"
            "});");
  }

  @override
  void pauseAnimation() {
    executeCustomJsCode(
      "const modelViewer = document.getElementById(\"$_viewerId\");"
      "modelViewer.pause();",
    );
  }

  @override
  void resetAnimation() {
    executeCustomJsCode(
      "const modelViewer = document.getElementById(\"$_viewerId\");"
      "modelViewer.pause();"
      "modelViewer.currentTime = 0;"
      "modelViewer.play();",
    );
  }

  @override
  void stopAnimation() {
    executeCustomJsCode(
      "const modelViewer = document.getElementById(\"$_viewerId\");"
      "modelViewer.pause();"
      "modelViewer.currentTime = 0;",
    );
  }

  @override
  Future<List<String>> getAvailableAnimations() async {
    try {
      final result = await executeCustomJsCodeWithResult(
        "document.getElementById(\"$_viewerId\").availableAnimations;",
      );
      return result.map<String>((e) => e.toString()).toList();
    } catch (e) {
      throw Flutter3dControllerFormatException(
          message: 'Failed to retrieve animation list, ${e.toString()}');
    }
  }

  @override
  void setTexture({required String textureName}) {
    executeCustomJsCode(
      "const modelViewer = document.getElementById(\"$_viewerId\");"
      "modelViewer.variantName = \"$textureName\";",
    );
  }

  @override
  Future<List<String>> getAvailableTextures() async {
    final result = await executeCustomJsCodeWithResult(
      "document.getElementById(\"$_viewerId\").availableVariants;",
    );
    return result.map<String>((e) => e.toString()).toList();
  }

  @override
  void setCameraTarget(double x, double y, double z) {
    executeCustomJsCode(
      "const modelViewer = document.getElementById(\"$_viewerId\");"
      "modelViewer.cameraTarget = \"${x}m ${y}m ${z}m\";",
    );
  }

  @override
  void resetCameraTarget() {
    executeCustomJsCode(
      "const modelViewer = document.getElementById(\"$_viewerId\");"
      "modelViewer.cameraTarget = \"auto auto auto\";",
    );
  }

  @override
  void setCameraOrbit(double theta, double phi, double radius) {
    executeCustomJsCode(
      "const modelViewer = document.getElementById(\"$_viewerId\");"
      "modelViewer.cameraOrbit = \"${theta}deg ${phi}deg $radius%\";",
    );
  }

  @override
  void resetCameraOrbit() {
    executeCustomJsCode(
      "const modelViewer = document.getElementById(\"$_viewerId\");"
      "modelViewer.cameraOrbit = \"0deg 75deg 105%\" ;",
    );
  }

  @override
  void executeCustomJsCode(String code) {
    js.context.callMethod(
      "customEvaluate",
      [code],
    );
  }

  @override
  Future<dynamic> executeCustomJsCodeWithResult(String code) async {
    final js.JsArray<dynamic> result =
        await js.context.callMethod("customEvaluateWithResult", [code]);
    return result.toList();
  }
}
