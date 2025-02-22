import 'package:dio/dio.dart';
import 'package:in_drive_clone/config/api/api_consumer.dart';
import 'package:in_drive_clone/config/error/handle_exception.dart';

class DioConsumer extends ApiConsumer {
  Dio dio;

  DioConsumer(this.dio) {
    dio.interceptors.add(LogInterceptor(
      error: true,
      responseHeader: true,
      responseBody: true,
      requestHeader: true,
      requestBody: true,
      request: true,
    ));
  }

  @override
  Future delete(
      {required String endPoint,
      Object? data,
      Map<String, dynamic>? queryParameter}) async {
    try {
   await dio.delete(endPoint,
          data: data, queryParameters: queryParameter);
    } on DioException catch (e) {
      HandleExceptions.handleExceptions(e);
    }
  }
  @override
  Future get(
      {required String endPoint,
      Object? data,
      Map<String, dynamic>? queryParameter}) async {
    try {
      return await dio.get(endPoint,
          data: data, queryParameters: queryParameter);
    } on DioException catch (e) {
      HandleExceptions.handleExceptions(e);
    }
  }

  @override
  Future post(
      {required String endPoint,
      Map<String, dynamic>? data,
      Map<String, dynamic>? queryParameter}) async {
    try {
      final response =
          await dio.post(endPoint, data: data, queryParameters: queryParameter);
      return response;
    } on DioException catch (e) {
      HandleExceptions.handleExceptions(e);
    }
  }

  @override
  Future patch(
      {required String endPoint,
      Object? data,
      Map<String, dynamic>? queryParameter}) async {
    try {
       await dio.patch(endPoint,
          data: data, queryParameters: queryParameter);
    } on DioException catch (e) {
      HandleExceptions.handleExceptions(e);
    }
  }
}
