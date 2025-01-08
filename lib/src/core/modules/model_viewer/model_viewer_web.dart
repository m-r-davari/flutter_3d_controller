// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'html_builder.dart';
import 'model_viewer.dart';
import 'dart_ui_web_fake.dart' if (dart.library.ui_web) 'dart:ui_web' as ui_web;
import 'dart:html' as html;

class ModelViewerState extends State<ModelViewer> {
  bool _isLoading = true;
  String _uniqueViewType = UniqueKey().toString();
  html.DivElement? htmlWebElement;
  bool firstDomLoad = true;

  @override
  void initState() {
    super.initState();
    unawaited(_generateModelViewerHtml());
  }

  @override
  void dispose() {
    htmlWebElement?.remove();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ModelViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.src != widget.src) {
      setState(() {
        _isLoading = true;
      });
      firstDomLoad = true;
      _uniqueViewType = UniqueKey().toString();
      unawaited(_generateModelViewerHtml());
    }
  }

  @override
  Widget build(final BuildContext context) {
    if (_isLoading) {
      return Container();
    } else {
      return HtmlElementView(
        viewType: 'model-viewer-html-$_uniqueViewType',
        onPlatformViewCreated: (id) async {
          if (firstDomLoad) {
            final event = html.CustomEvent('CustomDOMContentLoaded');
            await Future.delayed(Duration.zero);
            htmlWebElement?.dispatchEvent(event);
          }
        },
      );
    }
  }

  /// To generate the HTML code for using the model viewer.
  Future<void> _generateModelViewerHtml() async {
    final htmlTemplate = await rootBundle.loadString(
        'packages/flutter_3d_controller/assets/model_viewer_template.html');

    final htmlStr = _buildHTML(htmlTemplate);

    ui_web.platformViewRegistry.registerViewFactory(
      'model-viewer-html-$_uniqueViewType',
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
        scriptElement.text = widget.relatedJs;
        element.append(scriptElement);

        element.addEventListener('CustomDOMContentLoaded', (event) {
          final modelViewerElement = element.querySelector('#${widget.id}');
          modelViewerElement?.addEventListener('progress', (dynamic mvEvent) {
            final progress =
                double.tryParse(mvEvent.detail['totalProgress'].toString()) ??
                    0;
            if (progress == 0 || progress == 1.0) {
              return;
            }
            widget.onProgress?.call(progress);
          });
          modelViewerElement?.addEventListener('load', (dynamic mvEvent) {
            widget.onProgress?.call(1.0);
            widget.onLoad?.call(mvEvent.detail['url'].toString());
          });
          modelViewerElement?.addEventListener('error', (dynamic mvEvent) {
            widget.onError?.call(mvEvent.detail['sourceError'].toString());
          });
          firstDomLoad = false;
        });

        htmlWebElement = element;

        return element;
      },
    );

    setState(() => _isLoading = false);
  }

  String _buildHTML(final String htmlTemplate) {
    if (widget.src.startsWith('file://')) {
      // Local file URL can't be used in Flutter web.
      debugPrint("file:// URL scheme can't be used in Flutter web.");
      throw ArgumentError("file:// URL scheme can't be used in Flutter web.");
    }

    return HTMLBuilder.build(
      htmlTemplate: htmlTemplate.replaceFirst(
        '<script type="module" src="model_viewer.min.js" defer></script>',
        '',
      ),
      // Attributes
      src: widget.src,
      alt: widget.alt,
      poster: widget.poster,
      loading: widget.loading,
      reveal: widget.reveal,
      withCredentials: widget.withCredentials,
      // AR Attributes
      ar: widget.ar,
      arModes: widget.arModes,
      // arScale: widget.arScale,
      // arPlacement: widget.arPlacement,
      iosSrc: widget.iosSrc,
      xrEnvironment: widget.xrEnvironment,
      // Staing & Cameras Attributes
      cameraControls: widget.cameraControls,
      disablePan: widget.disablePan,
      disableTap: widget.disableTap,
      touchAction: widget.touchAction,
      disableZoom: widget.disableZoom,
      orbitSensitivity: widget.orbitSensitivity,
      autoRotate: widget.autoRotate,
      autoRotateDelay: widget.autoRotateDelay,
      rotationPerSecond: widget.rotationPerSecond,
      interactionPrompt: widget.interactionPrompt,
      interactionPromptStyle: widget.interactionPromptStyle,
      interactionPromptThreshold: widget.interactionPromptThreshold,
      cameraOrbit: widget.cameraOrbit,
      cameraTarget: widget.cameraTarget,
      fieldOfView: widget.fieldOfView,
      maxCameraOrbit: widget.maxCameraOrbit,
      minCameraOrbit: widget.minCameraOrbit,
      maxFieldOfView: widget.maxFieldOfView,
      minFieldOfView: widget.minFieldOfView,
      interpolationDecay: widget.interpolationDecay,
      // Lighting & Env Attributes
      skyboxImage: widget.skyboxImage,
      environmentImage: widget.environmentImage,
      exposure: widget.exposure,
      shadowIntensity: widget.shadowIntensity,
      shadowSoftness: widget.shadowSoftness,
      // Animation Attributes
      animationName: widget.animationName,
      animationCrossfadeDuration: widget.animationCrossfadeDuration,
      autoPlay: widget.autoPlay,
      // Materials & Scene Attributes
      variantName: widget.variantName,
      orientation: widget.orientation,
      scale: widget.scale,

      // CSS Styles
      backgroundColor: widget.backgroundColor,
      // Default progress bar color
      progressBarColor: widget.progressBarColor,

      // Annotations CSS
      minHotspotOpacity: widget.minHotspotOpacity,
      maxHotspotOpacity: widget.maxHotspotOpacity,

      // Others
      innerModelViewerHtml: widget.innerModelViewerHtml,
      relatedCss: widget.relatedCss,
      //relatedJs: widget.relatedJs,
      id: widget.id,
      debugLogging: widget.debugLogging,
    );
  }
}
