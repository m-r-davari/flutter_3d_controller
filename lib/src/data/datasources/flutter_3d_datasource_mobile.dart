import 'package:flutter_3d_controller/src/core/exception/flutter_3d_controller_exception.dart';
import 'package:flutter_3d_controller/src/data/datasources/i_flutter_3d_datasource.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Flutter3DDatasource implements IFlutter3DDatasource {
  final InAppWebViewController? _webViewController;
  final bool _activeGestureInterceptor;
  final String _viewerId;

  Flutter3DDatasource(
    this._viewerId, [
    this._webViewController,
    this._activeGestureInterceptor = false,
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
      final List<Object?> rawAnimations = await executeCustomJsCodeWithResult(
        "document.getElementById(\"$_viewerId\").availableAnimations;",
      );
      List<String> animations = [];
      for (final animItem in rawAnimations) {
        if (animItem != null) {
          animations.add(animItem.toString());
        }
      }
      return animations;
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
    try {
      final List<Object?> rawVariants = await executeCustomJsCodeWithResult(
        "document.getElementById(\"$_viewerId\").availableVariants;",
      );
      List<String> variants = [];
      for (final variantItem in rawVariants) {
        if (variantItem != null) {
          variants.add(variantItem.toString());
        }
      }
      return variants;
    } catch (e) {
      throw Flutter3dControllerFormatException(
          message: 'Failed to retrieve texture list, ${e.toString()}');
    }
  }

  @override
  void setCameraTarget(double x, double y, double z) {
    executeCustomJsCode(
      "const modelViewer = document.getElementById(\"$_viewerId\");"
      "modelViewer.cameraTarget = \"${x}m ${y}m ${z}m\";",
      100,
      300,
      _activeGestureInterceptor,
    );
  }

  @override
  void resetCameraTarget() {
    executeCustomJsCode(
      "const modelViewer = document.getElementById(\"$_viewerId\");"
      "modelViewer.cameraTarget = \"auto auto auto\";",
      100,
      300,
      _activeGestureInterceptor,
    );
  }

  @override
  void setCameraOrbit(double theta, double phi, double radius) {
    executeCustomJsCode(
      "const modelViewer = document.getElementById(\"$_viewerId\");"
      "modelViewer.cameraOrbit = \"${theta}deg ${phi}deg $radius%\";",
      100,
      400,
      _activeGestureInterceptor,
    );
  }

  @override
  void resetCameraOrbit() {
    executeCustomJsCode(
      "const modelViewer = document.getElementById(\"$_viewerId\");"
      "modelViewer.cameraOrbit = \"0deg 75deg 105%\" ;",
      100,
      400,
      _activeGestureInterceptor,
    );
  }

  @override
  void executeCustomJsCode(String code,
      [int codeDelay = 0,
      int refresherDelay = 0,
      bool refreshGestureInterceptor = false]) async {
    await Future.delayed(Duration(milliseconds: codeDelay));

    _webViewController?.evaluateJavascript(source: '''
        (() => {
          customEvaluate('$code');
        })();
    ''');

    if (refreshGestureInterceptor) {
      Future.delayed(Duration(milliseconds: refresherDelay), () {
        _webViewController?.evaluateJavascript(source: """
          cloneGestureData(modelViewer, modelViewerInterceptor);
        """);
      });
    }
  }

  @override
  Future<dynamic> executeCustomJsCodeWithResult(String code) async {
    final result = await _webViewController?.evaluateJavascript(source: code);
    return result;
  }
}
