class Flutter3dControllerException implements Exception {
  final String message;

  Flutter3dControllerException([this.message = 'Failure error']);

  @override
  String toString() => 'Flutter3DControllerException: $message';

  static String f3dcLoadingModelError =
      'The 3D model is not loaded or is still loading. All controller functionality, such as playAnimation, camera controls, texture management, etc, should only be executed once the model has fully loaded.';
}
