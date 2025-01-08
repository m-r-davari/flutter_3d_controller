import 'dart:convert' show htmlEscape;

import 'package:flutter/material.dart';

import 'model_viewer.dart';

abstract class HTMLBuilder {
  HTMLBuilder._();

  static String build({
    // Attributes
    // Loading Attributes
    required final String src,
    String htmlTemplate = '',
    final String? alt,
    final String? poster,
    final Loading? loading,
    final Reveal? reveal,
    final bool? withCredentials,
    // AR Attributes
    final bool? ar,
    final List<String>? arModes,
    final ArScale? arScale,
    final ArPlacement? arPlacement,
    final String? iosSrc,
    final bool? xrEnvironment,
    // Staging & Cameras Attributes
    final bool? cameraControls,
    final bool? disablePan,
    final bool? disableTap,
    final TouchAction? touchAction,
    final bool? disableZoom,
    final int? orbitSensitivity,
    final bool? autoRotate,
    final int? autoRotateDelay,
    final String? rotationPerSecond,
    final InteractionPrompt? interactionPrompt,
    final InteractionPromptStyle? interactionPromptStyle,
    final num? interactionPromptThreshold,
    final String? cameraOrbit,
    final String? cameraTarget,
    final String? fieldOfView,
    final String? maxCameraOrbit,
    final String? minCameraOrbit,
    final String? maxFieldOfView,
    final String? minFieldOfView,
    final num? interpolationDecay,
    // Lighting & Env Attributes
    final String? skyboxImage,
    final String? environmentImage,
    final num? exposure,
    final num? shadowIntensity,
    final num? shadowSoftness,
    // Animation Attributes
    final String? animationName,
    final num? animationCrossfadeDuration,
    final bool? autoPlay,
    // Scene Graph Attributes
    final String? variantName,
    final String? orientation,
    final String? scale,

    // CSS Styles
    final Color backgroundColor = Colors.transparent,
    // default progress bar color
    final Color? progressBarColor,

    // Annotations CSS
    final num? minHotspotOpacity,
    final num? maxHotspotOpacity,

    // Others
    final String? innerModelViewerHtml,
    final String? relatedCss,
    final String? relatedJs,
    final String? id,
    final bool? debugLogging,
  }) {
    if (relatedCss != null) {
      // ignore: parameter_assignments
      htmlTemplate = htmlTemplate.replaceFirst('/* other-css */', relatedCss);
    }

    final modelViewerHtml = StringBuffer()
      ..write('<model-viewer')
      // Attributes
      // Loading Attributes
      // src
      ..write(' src="${htmlEscape.convert(src)}"');
    // alt
    if (alt != null) {
      modelViewerHtml.write(' alt="${htmlEscape.convert(alt)}"');
    }
    // poster
    if (poster != null) {
      modelViewerHtml.write(' poster="${htmlEscape.convert(poster)}"');
    }
    // loading
    if (loading != null) {
      switch (loading) {
        case Loading.auto:
          modelViewerHtml.write(' loading="auto"');
        case Loading.lazy:
          modelViewerHtml.write(' loading="lazy"');
        case Loading.eager:
          modelViewerHtml.write(' loading="eager"');
      }
    }
    // reveal
    if (reveal != null) {
      switch (reveal) {
        case Reveal.auto:
          modelViewerHtml.write(' reveal="auto"');
        case Reveal.interaction:
          modelViewerHtml.write(' reveal="interaction"');
        case Reveal.manual:
          modelViewerHtml.write(' reveal="manual"');
      }
    }
    // with-credentials
    if (withCredentials ?? false) {
      modelViewerHtml.write(' with-credentials');
    }

    // Augmented Reality Attributes
    // ar
    if (ar ?? false) {
      modelViewerHtml.write(' ar');
    }
    // ar-modes
    if (arModes != null) {
      modelViewerHtml
          .write(' ar-modes="${htmlEscape.convert(arModes.join(' '))}"');
    }
    // ar-scale
    if (arScale != null) {
      switch (arScale) {
        case ArScale.auto:
          modelViewerHtml.write(' ar-scale="auto"');
        case ArScale.fixed:
          modelViewerHtml.write(' ar-scale="fixed"');
      }
    }
    // ar-placement
    if (arPlacement != null) {
      switch (arPlacement) {
        case ArPlacement.floor:
          modelViewerHtml.write(' ar-placement="floor"');
        case ArPlacement.wall:
          modelViewerHtml.write(' ar-placement="wall"');
      }
    }
    // ios-src
    if (iosSrc != null) {
      modelViewerHtml.write(' ios-src="${htmlEscape.convert(iosSrc)}"');
    }
    // xr-environment
    if (xrEnvironment ?? false) {
      modelViewerHtml.write(' xr-environment');
    }

    // Staging & Cameras Attributes
    // camera-controls
    if (cameraControls ?? false) {
      modelViewerHtml.write(' camera-controls');
    }
    // disable-pan
    if (disablePan ?? false) {
      modelViewerHtml.write(' disable-pan');
    }
    // disable-tap
    if (disableTap ?? false) {
      modelViewerHtml.write(' disable-tap');
    }
    // touch-action
    if (touchAction != null) {
      switch (touchAction) {
        case TouchAction.none:
          modelViewerHtml.write(' touch-action="none"');
        case TouchAction.panX:
          modelViewerHtml.write(' touch-action="pan-x"');
        case TouchAction.panY:
          modelViewerHtml.write(' touch-action="pan-y"');
      }
    }
    // disable-zoom
    if (disableZoom ?? false) {
      modelViewerHtml.write(' disable-zoom');
    }
    // orbit-sensitivity
    if (orbitSensitivity != null) {
      modelViewerHtml.write(' orbit-sensitivity="$orbitSensitivity"');
    }
    // auto-rotate
    if (autoRotate ?? false) {
      modelViewerHtml.write(' auto-rotate');
    }
    // auto-rotate-delay
    if (autoRotateDelay != null) {
      modelViewerHtml.write(' auto-rotate-delay="$autoRotateDelay"');
    }
    // rotation-per-second
    if (rotationPerSecond != null) {
      modelViewerHtml.write(
        ' rotation-per-second="${htmlEscape.convert(rotationPerSecond)}"',
      );
    }
    // interaction-prompt
    if (interactionPrompt != null) {
      switch (interactionPrompt) {
        case InteractionPrompt.auto:
          modelViewerHtml.write(' interaction-prompt="auto"');
        case InteractionPrompt.none:
          modelViewerHtml.write(' interaction-prompt="none"');
        case InteractionPrompt.whenFocused:
          modelViewerHtml.write(' interaction-prompt="when-focused"');
      }
    }
    // interaction-prompt-style
    if (interactionPromptStyle != null) {
      switch (interactionPromptStyle) {
        case InteractionPromptStyle.basic:
          modelViewerHtml.write(' interaction-prompt-style="basic"');
        case InteractionPromptStyle.wiggle:
          modelViewerHtml.write(' interaction-prompt-style="wiggle"');
      }
    }
    // interaction-prompt-threshold
    if (interactionPromptThreshold != null) {
      if (interactionPromptThreshold < 0) {
        throw RangeError('interaction-prompt-threshold must be >= 0');
      }
      modelViewerHtml
          .write(' interaction-prompt-threshold="$interactionPromptThreshold"');
    }
    // camera-orbit
    if (cameraOrbit != null) {
      modelViewerHtml
          .write(' camera-orbit="${htmlEscape.convert(cameraOrbit)}"');
    }
    // camera-target
    if (cameraTarget != null) {
      modelViewerHtml
          .write(' camera-target="${htmlEscape.convert(cameraTarget)}"');
    }
    // field-of-view
    if (fieldOfView != null) {
      modelViewerHtml
          .write(' field-of-view="${htmlEscape.convert(fieldOfView)}"');
    }
    // max-camera-orbit
    if (maxCameraOrbit != null) {
      modelViewerHtml
          .write(' max-camera-orbit="${htmlEscape.convert(maxCameraOrbit)}"');
    }
    // min-camera-orbit
    if (minCameraOrbit != null) {
      modelViewerHtml
          .write(' min-camera-orbit="${htmlEscape.convert(minCameraOrbit)}"');
    }
    // max-field-of-view
    if (maxFieldOfView != null) {
      modelViewerHtml
          .write(' max-field-of-view="${htmlEscape.convert(maxFieldOfView)}"');
    }
    // min-field-of-view
    if (minFieldOfView != null) {
      modelViewerHtml
          .write(' min-field-of-view="${htmlEscape.convert(minFieldOfView)}"');
    }
    // interpolation-decay
    if (interpolationDecay != null) {
      if (interpolationDecay <= 0) {
        throw RangeError('interaction-decay must be greater than 0');
      }
      modelViewerHtml.write(' interpolation-decay="$interpolationDecay"');
    }

    // Lighting & Env Attributes
    // skybox-image
    if (skyboxImage != null) {
      modelViewerHtml
          .write(' skybox-image="${htmlEscape.convert(skyboxImage)}"');
    }
    // environment-image
    if (environmentImage != null) {
      modelViewerHtml.write(
        ' environment-image="${htmlEscape.convert(environmentImage)}"',
      );
    }
    // exposure
    if (exposure != null) {
      if (exposure < 0) {
        throw RangeError('exposure must be any positive value');
      }
      modelViewerHtml.write(' exposure="$exposure"');
    }
    // shadow-intensity
    if (shadowIntensity != null) {
      if (shadowIntensity < 0 || shadowIntensity > 1) {
        throw RangeError('shadow-intensity must be between 0 and 1');
      }
      modelViewerHtml.write(' shadow-intensity="$shadowIntensity}"');
    }
    // shadow-softness
    if (shadowSoftness != null) {
      if (shadowSoftness < 0 || shadowSoftness > 1) {
        throw RangeError('shadow-softness must be between 0 and 1');
      }
      modelViewerHtml.write(' shadow-softness="$shadowSoftness}"');
    }

    // Animation Attributes
    // animation-name
    if (animationName != null) {
      modelViewerHtml
          .write(' animation-name="${htmlEscape.convert(animationName)}"');
    }
    // animation-crossfade-duration
    if (animationCrossfadeDuration != null) {
      if (animationCrossfadeDuration < 0) {
        throw RangeError('shadow-softness must be any number >= 0');
      }
      modelViewerHtml
          .write(' animation-crossfade-duration="$animationCrossfadeDuration"');
    }
    // autoplay
    if (autoPlay ?? false) {
      modelViewerHtml.write(' autoplay');
    }

    // Scene Graph Attributes
    // variant-name
    if (variantName != null) {
      modelViewerHtml
          .write(' variant-name="${htmlEscape.convert(variantName)}"');
    }
    // orientation
    if (orientation != null) {
      modelViewerHtml
          .write(' orientation="${htmlEscape.convert(orientation)}"');
    }
    // scale
    if (scale != null) {
      modelViewerHtml.write(' scale="${htmlEscape.convert(scale)}"');
    }

    // Styles
    modelViewerHtml
      ..write(' style="')
      // CSS Styles
      ..write(
        'background-color: rgba(${backgroundColor.r * 255}, ${backgroundColor.g * 255}, ${backgroundColor.b * 255}, ${backgroundColor.a * 255}); ',
      );

    //Default Progress bar color
    if (progressBarColor != null) {
      modelViewerHtml.write(
          ' --progress-bar-color: rgba(${progressBarColor.r * 255}, ${progressBarColor.g * 255}, ${progressBarColor.b * 255}, ${progressBarColor.a * 255})');
    }

    // Annotations CSS
    // --min-hotspot-opacity
    if (minHotspotOpacity != null) {
      if (minHotspotOpacity > 1 || minHotspotOpacity < 0) {
        throw RangeError('--min-hotspot-opacity must be between 0 and 1');
      }
      modelViewerHtml.write('min-hotspot-opacity: $minHotspotOpacity; ');
    }
    // --max-hotspot-opacity
    if (maxHotspotOpacity != null) {
      if (maxHotspotOpacity > 1 || maxHotspotOpacity < 0) {
        throw RangeError('--max-hotspot-opacity must be between 0 and 1');
      }
      modelViewerHtml.write('max-hotspot-opacity: $maxHotspotOpacity; ');
    }
    modelViewerHtml.write('"'); // close style

    if (id != null) {
      modelViewerHtml.write(' id="${htmlEscape.convert(id)}"');
    }

    modelViewerHtml.writeln('>'); // close the previous tag of model-viewer
    if (innerModelViewerHtml != null) {
      modelViewerHtml.writeln(innerModelViewerHtml);
    }
    modelViewerHtml.writeln('</model-viewer>');

    if (relatedJs != null) {
      modelViewerHtml
        ..writeln('<script>')
        ..write(relatedJs)
        ..writeln('</script>');
    }

    if (debugLogging ?? false) {
      debugPrint('HTML generated for model_viewer_plus:');
    }
    final html =
        htmlTemplate.replaceFirst('<!-- body -->', modelViewerHtml.toString());

    if (debugLogging ?? false) {
      debugPrint(html);
    }

    return html;
  }
}
