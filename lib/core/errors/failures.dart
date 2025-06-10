import 'package:dio/dio.dart';

class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure(
          'Connection timed out. Please try again later.',
        );
      case DioExceptionType.sendTimeout:
        return const ServerFailure(
          'Send timeout. Unable to send data to the server.',
        );
      case DioExceptionType.receiveTimeout:
        return const ServerFailure(
          'Receive timeout. Server took too long to respond.',
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response?.statusCode,
          dioException.response?.data,
        );
      case DioExceptionType.cancel:
        return const ServerFailure('Request was cancelled.');
      case DioExceptionType.connectionError:
        return const ServerFailure(
          'No internet connection. Please check your network.',
        );
      case DioExceptionType.unknown:
      default:
        return const ServerFailure(
          'An unexpected error occurred. Please try again.',
        );
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic responseData) {
    if (statusCode == null) {
      return const ServerFailure('Unknown server error.');
    }

    switch (statusCode) {
      case 400:
        return const ServerFailure('Bad request. Please check your data.');
      case 401:
        return const ServerFailure('Unauthorized. Please log in again.');
      case 403:
        return const ServerFailure('Forbidden. Access denied.');
      case 404:
        return const ServerFailure('Resource not found.');
      case 500:
        return const ServerFailure('Internal server error. Please try later.');
      default:
        return ServerFailure(
          'Unexpected error occurred (status code: $statusCode).',
        );
    }
  }
}
