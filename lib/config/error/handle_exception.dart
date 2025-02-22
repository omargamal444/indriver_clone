import 'package:dio/dio.dart';
import 'package:in_drive_clone/config/error/failure.dart';
class HandleExceptions{
 static void handleExceptions(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw Failure(errorMessage: "connection time out error");
      case DioExceptionType.receiveTimeout:
        throw Failure(errorMessage: "recieve time out error");
      case DioExceptionType.connectionError:
        throw Failure(errorMessage: "connection error");
      case DioExceptionType.sendTimeout:
        throw Failure(errorMessage: "send time out error");
      case DioExceptionType.cancel:
        throw Failure(errorMessage: "cancel error");
      case DioExceptionType.unknown:
        throw Failure(errorMessage: "unknown error");
      case DioExceptionType.badCertificate:
        throw Failure(errorMessage: "bad certificate error");
      case DioExceptionType.badResponse:
        switch (e.response!.statusCode) {
          case 404:
            throw Failure(errorMessage: "not found");
          case 500:
            throw Failure(errorMessage: "not fond");
        }
    }
  }
}
