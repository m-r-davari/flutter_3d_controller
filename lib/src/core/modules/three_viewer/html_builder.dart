import 'dart:convert' show htmlEscape;

abstract class HTMLBuilder {
  HTMLBuilder._();

  static String build({
    // Attributes
    // Loading Attributes
    required final String src,
    String htmlTemplate = '',
  }) {


    final modelViewerHtml = StringBuffer()
      ..write('<three-viewer')
      // Attributes
      // Loading Attributes
      // src
      ..write(' src="${htmlEscape.convert(src)}"');


    // // Styles
    // modelViewerHtml
    //   ..write(' style="')
    //   // CSS Styles
    //   ..write(
    //     'background-color: rgba(${backgroundColor.red}, ${backgroundColor.green}, ${backgroundColor.blue}, ${backgroundColor.alpha}); ',
    //   );
    //
    // //Default Progress bar color
    // if (progressBarColor != null) {
    //   modelViewerHtml.write(
    //       ' --progress-bar-color: rgba(${progressBarColor.red}, ${progressBarColor.green}, ${progressBarColor.blue}, ${progressBarColor.alpha})');
    // }


   // modelViewerHtml.write('"'); // close style



    modelViewerHtml.writeln('>'); // close the previous tag of three-viewer

    modelViewerHtml.writeln('</three-viewer>');

    final html =
        htmlTemplate.replaceFirst('<!-- body -->', modelViewerHtml.toString());

    return html;
  }
}
