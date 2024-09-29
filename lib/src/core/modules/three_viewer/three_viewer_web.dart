// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_3d_controller/src/core/modules/three_viewer/three_viewer.dart';
import 'html_builder.dart';

import 'web_fakes/dart_ui_web_fake.dart' if (dart.library.ui_web) 'dart:ui_web'
    as ui_web;
import 'dart:html' as html;

class ThreeViewerState extends State<ThreeViewer> {
  bool _isLoading = true;
  final String _uniqueViewType = UniqueKey().toString();
  html.DivElement? htmlWebElement;
  bool firstDomLoad = true;

  @override
  void initState() {
    super.initState();
    unawaited(_generateModelViewerHtml());
  }

  /// To generate the HTML code for using the model viewer.
  Future<void> _generateModelViewerHtml() async {
    final htmlTemplate = await rootBundle
        .loadString('packages/flutter_3d_controller/assets/three_viewer_template.html');

    final htmlStr = _buildHTML(htmlTemplate);

    ui_web.platformViewRegistry.registerViewFactory(
      'three-viewer-html-$_uniqueViewType',
      (viewId) {
        // Create a DivElement to hold the content
        final element = html.DivElement()
          ..style.border = 'none'
          ..style.height = '100%'
          ..style.width = '100%';

        element.setInnerHtml(htmlStr,
            treeSanitizer: html.NodeTreeSanitizer.trusted);

        // Create a ScriptElement to add custom JavaScript
        final scriptElement = html.ScriptElement();
        scriptElement.type = 'text/javascript';
        //scriptElement.text = widget.relatedJs;
        element.append(scriptElement);

        // element.addEventListener('CustomDOMContentLoaded', (event) {
        //   final modelViewerElement = element.querySelector('#${widget.id}');
        //   modelViewerElement?.addEventListener('progress', (dynamic mvEvent) {
        //     final progress =
        //         double.tryParse(mvEvent.detail['totalProgress'].toString()) ??
        //             0;
        //     if (progress == 0 || progress == 1.0) {
        //       return;
        //     }
        //     widget.onProgress?.call(progress);
        //   });
        //   modelViewerElement?.addEventListener('load', (dynamic mvEvent) {
        //     widget.onProgress?.call(1.0);
        //     widget.onLoad?.call(mvEvent.detail['url'].toString());
        //   });
        //   modelViewerElement?.addEventListener('error', (dynamic mvEvent) {
        //     widget.onError?.call(mvEvent.detail['sourceError'].toString());
        //   });
        //   firstDomLoad = false;
        // });

        htmlWebElement = element;

        return element;
      },
    );

    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    htmlWebElement?.remove();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    if (_isLoading) {
      return Container();
    } else {
      return HtmlElementView(
        viewType: 'three-viewer-html-$_uniqueViewType',
        onPlatformViewCreated: (id) async {
          // if (firstDomLoad) {
          //   final event = html.CustomEvent('CustomDOMContentLoaded');
          //   await Future.delayed(Duration.zero);
          //   htmlWebElement?.dispatchEvent(event);
          // }
        },
      );
    }
  }

  String _buildHTML(final String htmlTemplate) {
    if (widget.src.startsWith('file://')) {
      // Local file URL can't be used in Flutter web.
      debugPrint("file:// URL scheme can't be used in Flutter web.");
      throw ArgumentError("file:// URL scheme can't be used in Flutter web.");
    }

    return HTMLBuilder.build(
      htmlTemplate: htmlTemplate.replaceFirst(
        '<script type="module" src="three-viewer.min.js" defer></script>',
        '',
      ),
      // Attributes
      src: widget.src,
    );
  }
}
