class Flutter3dControllerException implements Exception {
  final String message;

  Flutter3dControllerException({this.message = 'Failure error'});

  @override
  String toString() => 'Flutter3DControllerException: $message';
}

class Flutter3dControllerLoadingException extends Flutter3dControllerException {
  Flutter3dControllerLoadingException({String? message})
      : super(
          message: message ??
              'The 3D model is not loaded yet or is still loading.'
                  ' All controller functionality, such as playAnimation,'
                  ' camera controls, texture management, etc, should only be'
                  ' executed after the model has fully loaded.',
        );

  @override
  String toString() => 'Flutter3DControllerLoadingException: $message';
}

class Flutter3dControllerFormatException extends Flutter3dControllerException {
  Flutter3dControllerFormatException({String? message})
      : super(
          message: message ?? 'Wrong model format has been used.',
        );

  @override
  String toString() => 'Flutter3DControllerFormatException: $message';
}
