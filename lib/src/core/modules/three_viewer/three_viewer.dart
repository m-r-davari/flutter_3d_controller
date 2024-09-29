import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'three_viewer_stub.dart'
if (dart.library.io) 'three_viewer_mobile.dart'
if (dart.library.js_interop) 'three_viewer_web.dart';


class JavascriptChannel {
  const JavascriptChannel(this.name, {required this.onMessageReceived});

  final String name;
  final ValueChanged<JavaScriptMessage> onMessageReceived;
}

/// Flutter widget for rendering interactive 3D models.
class ThreeViewer extends StatefulWidget {
  final String src;

  const ThreeViewer({
    required this.src,
    super.key,
  });


  @override
  State<ThreeViewer> createState() => ThreeViewerState();
}
