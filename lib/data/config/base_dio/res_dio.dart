import 'package:dio/dio.dart';

import 'log_dio.dart';

class ResponseInterceptor {
  LoggingInterceptor _loggingInterceptor = LoggingInterceptor() ;


  /// Intercepts the response so that we can validate its integrity
  Response getResponseInterceptor(Response response) {
    _loggingInterceptor.printSuccess(response);
    return response;
  }
}
