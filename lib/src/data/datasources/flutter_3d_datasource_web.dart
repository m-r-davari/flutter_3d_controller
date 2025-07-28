// ignore_for_file: avoid_web_libraries_in_flutter
import 'package:flutter_3d_controller/src/core/exception/flutter_3d_controller_exception.dart';
import 'package:flutter_3d_controller/src/data/datasources/i_flutter_3d_datasource.dart';
import 'dart:js' as js;

class Flutter3DDatasource implements IFlutter3DDatasource {
  final String _viewerId;
  bool _wasPaused = false; // Track if animation was paused vs stopped

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
    _wasPaused = false; // Reset pause state when starting new animation
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
    _wasPaused = true; // Mark as paused so we can resume later
    executeCustomJsCode(
      "const modelViewer = document.getElementById(\"$_viewerId\");"
      "modelViewer.pause();",
    );
  }

  @override
  void resumeAnimation() {
    if (_wasPaused) {
      // Resume from current position by preserving currentTime
      executeCustomJsCode(
        "const modelViewer = document.getElementById(\"$_viewerId\");"
        "const currentTime = modelViewer.currentTime;"
        "modelViewer.play();"
        "modelViewer.currentTime = currentTime;",
      );
    } else {
      // If not paused, just play from beginning
      executeCustomJsCode(
        "const modelViewer = document.getElementById(\"$_viewerId\");"
        "modelViewer.play();",
      );
    }
  }

  @override
  void resetAnimation() {
    _wasPaused = false; // Reset pause state when resetting
    executeCustomJsCode(
      "const modelViewer = document.getElementById(\"$_viewerId\");"
      "modelViewer.pause();"
      "modelViewer.currentTime = 0;"
      "modelViewer.play();",
    );
  }

  @override
  void stopAnimation() {
    _wasPaused = false; // Reset pause state when stopping
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
  Future<double> getCurrentAnimationTime() async {
    try {
      final result = await executeCustomJsCodeWithResult(
        "document.getElementById(\"$_viewerId\").currentTime;",
      );
      return double.tryParse(result.toString()) ?? 0.0;
    } catch (e) {
      return 0.0;
    }
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
