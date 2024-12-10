import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMsg;

  Failure(this.errorMsg);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMsg);

  factory ServerFailure.fromDioError(DioException dioError)
  {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
            'Connection timeout with ApiServer');

      case DioExceptionType.sendTimeout:
        return ServerFailure(
            'Send timeout with ApiServer');

      case DioExceptionType.receiveTimeout:
        return ServerFailure(
            'Receive timeout with ApiServer');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioError.response!.statusCode!, dioError.response!.data);

      case DioExceptionType.cancel:
        return ServerFailure(
            'Request to ApiServer was canceled');

      case DioExceptionType.unknown:
        if (dioError.message!.contains('SocketException')) {
          return ServerFailure(
              'No internet Connection');
        }
        return ServerFailure('Un expected Error, Please try again!');

        default:
          return ServerFailure(
              'Opps,there was an Error , Please try again');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response)
  {
    if (statusCode == 400 || statusCode == 400 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure('Your Request not Found, please try again later!');
    } else if (statusCode == 500) {
      return ServerFailure('internal server error,please try again later!');
    } else {
      return ServerFailure('Opps,there was an Error , Please try again');
    }
  }
}