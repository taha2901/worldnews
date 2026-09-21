import 'package:dio/dio.dart';

import 'api_constants.dart';
import 'api_result.dart';
import 'dio_factory.dart';
import 'error_model.dart';

class ApiService {
  ApiService({Dio? dio}) : _dio = dio ?? DioFactory.create();

  final Dio _dio;

  Future<ApiResult<Map<String, dynamic>>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: {
          'apiKey': ApiConstants.apiKey,
          ...?queryParameters,
        },
      );

      if (response.statusCode == 200 && response.data is Map) {
        return ApiResult.success(Map<String, dynamic>.from(response.data as Map));
      }

      return ApiResult.failure('Request failed with status ${response.statusCode}');
    } on DioException catch (error) {
      final errorModel = ErrorModel.fromDio(error);
      return ApiResult.errorModel(errorModel);
    } catch (_) {
      return ApiResult.failure('Unexpected error occurred');
    }
  }

  Future<ApiResult<Map<String, dynamic>>> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: {
          'apiKey': ApiConstants.apiKey,
          ...?queryParameters,
        },
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return ApiResult.success(
          response.data is Map ? Map<String, dynamic>.from(response.data as Map) : {},
        );
      }

      return ApiResult.failure('Request failed with status ${response.statusCode}');
    } on DioException catch (error) {
      final errorModel = ErrorModel.fromDio(error);
      return ApiResult.errorModel(errorModel);
    } catch (_) {
      return ApiResult.failure('Unexpected error occurred');
    }
  }
}
