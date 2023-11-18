import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/src/controllers/flutter_3d_controller.dart';
import 'package:flutter_3d_controller/src/modules/model_viewer/model_viewer.dart';

class Flutter3DViewer extends StatefulWidget {

  final String src;
  final Flutter3DAnimationController? flutter3dAnimationController;
  final Flutter3DCameraController? flutter3dCameraController;

  const Flutter3DViewer({Key? key,required this.src,this.flutter3dCameraController,this.flutter3dAnimationController}) : super(key: key);

  @override
  State<Flutter3DViewer> createState() => _Flutter3DViewerState();

}

class _Flutter3DViewerState extends State<Flutter3DViewer> {

  late Flutter3DController animationController;
  late Flutter3DController cameraController;

  @override
  void initState() {
    super.initState();
    //do something with controllers
    //initial controllers
  }

  @override
  Widget build(BuildContext context) {
    return ModelViewer(
      src: widget.src,

    );
  }
}
