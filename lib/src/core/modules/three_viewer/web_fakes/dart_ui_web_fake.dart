/// The platform view registry for this app.
final PlatformViewRegistry platformViewRegistry = PlatformViewRegistry();

/// A registry for factories that create platform views.
class PlatformViewRegistry {
  /// Register [viewType] as being created by the given [viewFactory].
  ///
  /// [viewFactory] can be any function that takes an integer and optional
  /// `params` and returns an `HTMLElement` DOM object.
  bool registerViewFactory(
    String viewType,
    Function viewFactory, {
    bool isVisible = true,
  }) =>
      false;
}
