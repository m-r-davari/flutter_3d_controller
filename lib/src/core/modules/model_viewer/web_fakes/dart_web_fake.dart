// ignore_for_file: avoid_setters_without_getters
class HTMLHtmlElement {
  CSSStyleDeclarationX get style => CSSStyleDeclarationX._(Object);

  set innerHTML(Object html) {}
}

extension type CSSStyleDeclarationX._(Object _) implements Object {
  set width(String width) {}

  set height(String height) {}

  set border(String border) {}
}

extension ToJSX on String {
  String get toJS => '';
}
