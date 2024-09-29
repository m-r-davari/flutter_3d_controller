import 'package:flutter/material.dart';

class ObjViewer extends StatefulWidget {
  const ObjViewer({super.key});

  @override
  State<ObjViewer> createState() => _ObjViewerState();
}

class _ObjViewerState extends State<ObjViewer> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(width: 150,height: 150,color: Colors.green,));
  }
}
