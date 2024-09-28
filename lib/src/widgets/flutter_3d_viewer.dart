import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/src/controllers/flutter_3d_controller.dart';
import 'package:flutter_3d_controller/src/data/datasources/i_flutter_3d_datasource.dart';
import 'package:flutter_3d_controller/src/data/repositories/flutter_3d_repository.dart';
import 'package:flutter_3d_controller/src/core/modules/model_viewer/model_viewer.dart';
import 'package:flutter_3d_controller/src/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Flutter3DViewer extends StatefulWidget {
  /// Src address of 3d model, could be asset address, url or file address.
  final String src;

  /// Default progressBar color, use [Colors.transparent] to hide progress bar.
  final Color? progressBarColor;

  /// If true the flutter_3d_controller will add gesture interceptor layer
  /// to prevent breaking gesture detection in iOS and some of android devices.
  /// default = true.
  final bool activeGestureInterceptor;

  /// This controller will provide full control of 3d model animations, camera,
  /// variants, etc.
  final Flutter3DController? controller;

  /// This callBack will call at every step of loading progress
  /// and will return double progress value between 0 and 1.0
  final Function(double progressValue)? onProgress;

  /// This callBack will call when model loaded successfully
  /// and will return string model address
  final Function(String modelAddress)? onLoad;

  /// This callBack will call when model failed to load
  /// and will return string error
  final Function(String error)? onError;

  /// If set to false, the model cannot be controlled by touch,
  /// the default value is true.
  final bool enableTouch;

  const Flutter3DViewer({
    Key? key,
    required this.src,
    this.controller,
    this.progressBarColor,
    this.activeGestureInterceptor = true,
    this.enableTouch = true,
    this.onProgress,
    this.onLoad,
    this.onError,
  }) : super(key: key);

  @override
  State<Flutter3DViewer> createState() => _Flutter3DViewerState();
}

class _Flutter3DViewerState extends State<Flutter3DViewer> {
  late Flutter3DController _controller;
  late String _id;
  final Utils _utils = Utils();

  @override
  void initState() {
    _id = _utils.generateId();
    _controller = widget.controller ?? Flutter3DController();
    if (kIsWeb) {
      _controller.init(Flutter3DRepository(IFlutter3DDatasource(null)));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModelViewer(
      id: _id,
      src: widget.src,
      progressBarColor: widget.progressBarColor,
      relatedJs: _utils.injectedJS(_id,'flutter-3d-controller'),
      interactionPrompt: InteractionPrompt.none,
      activeGestureInterceptor: widget.activeGestureInterceptor,
      cameraControls: widget.enableTouch,
      ar: false,
      autoPlay: false,
      autoRotate: false,
      debugLogging: false,
      disableTap: true,
      onProgress: widget.onProgress,
      onLoad: (modelAddress){
        _controller.onModelLoaded.value = true;
        widget.onLoad?.call(modelAddress);
      },
      onError: (error){
        _controller.onModelLoaded.value = false;
        widget.onError?.call(error);
      },
      onWebViewCreated: kIsWeb
          ? null
          : (WebViewController value) {
              _controller
                  .init(Flutter3DRepository(IFlutter3DDatasource(value)));
            },
    );
  }
}
