import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/src/controllers/flutter_3d_controller.dart';
import 'package:flutter_3d_controller/src/data/datasources/i_flutter_3d_datasource.dart';
import 'package:flutter_3d_controller/src/data/repositories/flutter_3d_repository.dart';
import 'package:flutter_3d_controller/src/modules/model_viewer/model_viewer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Flutter3DViewer extends StatefulWidget {

  final String src;
  final Flutter3DController? flutter3dController;

  const Flutter3DViewer({Key? key,required this.src,this.flutter3dController,}) : super(key: key);

  @override
  State<Flutter3DViewer> createState() => _Flutter3DViewerState();

}

class _Flutter3DViewerState extends State<Flutter3DViewer> {

  Flutter3DController? _controller;

  @override
  void initState() {
    super.initState();
    _controller == widget.flutter3dController;
  }

  @override
  Widget build(BuildContext context) {
    return ModelViewer(
      src: widget.src,
      onWebViewCreated: (WebViewController value) {
        _controller?.init(Flutter3DRepository(IFlutter3DDatasource(value)));
      },
    );
  }
}
