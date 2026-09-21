import 'package:dio/dio.dart';

class ErrorModel {
  const ErrorModel({
    required this.message,
    this.statusCode,
    this.errors,
    this.responseData,
  });

  final String message;
  final int? statusCode;
  final Map<String, dynamic>? errors;
  final dynamic responseData;

  factory ErrorModel.fromJson(
    Map<String, dynamic> json, {
    int? statusCode,
  }) {
    final message = json['message'] ??
        json['error'] ??
        json['detail'] ??
        'Something went wrong';

    final rawErrors = json['errors'];
    final errors = rawErrors is Map<String, dynamic>
        ? rawErrors
        : rawErrors is Map
            ? Map<String, dynamic>.from(rawErrors)
            : null;

    return ErrorModel(
      message: message.toString(),
      statusCode: statusCode,
      errors: errors,
      responseData: json,
    );
  }

  factory ErrorModel.fromDio(DioException error) {
    final data = error.response?.data;

    if (data is Map<String, dynamic>) {
      return ErrorModel.fromJson(data,
          statusCode: error.response?.statusCode);
    }

    if (data is Map) {
      return ErrorModel.fromJson(
        Map<String, dynamic>.from(data),
        statusCode: error.response?.statusCode,
      );
    }

    return ErrorModel(
      message: error.message ?? 'Something went wrong',
      statusCode: error.response?.statusCode,
      responseData: data,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      if (statusCode != null) 'statusCode': statusCode,
      if (errors != null) 'errors': errors,
    };
  }

  @override
  String toString() => message;
}
