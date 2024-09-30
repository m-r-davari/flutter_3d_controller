class Flutter3dControllerException implements Exception {
  final String message;

  Flutter3dControllerException({this.message = 'Failure error'});

  @override
  String toString() => 'Flutter3DControllerException: $message';
}

class Flutter3dControllerLoadingException extends Flutter3dControllerException {
  Flutter3dControllerLoadingException(
      {message = 'The 3D model is not loaded yet or is still loading.'
          ' All controller functionality, such as playAnimation,'
          ' camera controls, texture management, etc, should only be'
          ' executed after the model has fully loaded.'})
      : super(
          message: message,
        );

  @override
  String toString() => 'Flutter3DControllerLoadingException: $message';
}

class Flutter3dControllerFormatException extends Flutter3dControllerException {
  Flutter3dControllerFormatException({
    message = 'Wrong model format has been used.',
  }) : super(
          message: message,
        );

  @override
  String toString() => 'Flutter3DControllerFormatException: $message';
}
