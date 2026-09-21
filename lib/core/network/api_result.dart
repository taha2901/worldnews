import 'error_model.dart';

class ApiResult<T> {
  const ApiResult._({this.data, this.error, required this.isSuccess});

  factory ApiResult.success(T data) => ApiResult._(data: data, isSuccess: true);

  factory ApiResult.failure(String message) =>
      ApiResult._(error: ErrorModel(message: message), isSuccess: false);

  factory ApiResult.errorModel(ErrorModel errorModel) =>
      ApiResult._(error: errorModel, isSuccess: false);

  final T? data;
  final ErrorModel? error;
  final bool isSuccess;

  String? get errorMessage => error?.message;
}
