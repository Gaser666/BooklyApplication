import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;

  const Failure({required this.errMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errMessage});
  factory ServerFailure.fromDioExcepion(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(errMessage: 'Connection Timeout');
      case DioExceptionType.sendTimeout:
        return ServerFailure(errMessage: 'Send Timeout');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errMessage: 'Receive Timeout');
      case DioExceptionType.badCertificate:
        return ServerFailure(errMessage: 'Bad Certificates');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioException.response!.statusCode, dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure(errMessage: 'Request To Api Server Was Canceled');
      case DioExceptionType.connectionError:
        return ServerFailure(errMessage: 'You Have A Connection Error');
      case DioExceptionType.unknown:
        if (dioException.message!.contains('SocketException')) {
          return ServerFailure(errMessage: 'No Internet Connection');
        }
        return ServerFailure(errMessage: 'Unexpected Error, Try Agian Later');
      default:
        return ServerFailure(errMessage: 'Unexpected Error, Try Agian Later');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(errMessage: response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure(errMessage: 'Page Not Found Error 404');
    } else if (statusCode == 500) {
      return ServerFailure(
          errMessage: 'Internal Server Error, Try Again Later');
    } else {
      return ServerFailure(errMessage: 'Opps There Was An Error');
    }
  }
}
