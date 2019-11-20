import 'dart:async';

import 'package:dio/dio.dart';

import 'log_dio.dart';

class RequestInterceptor {
  LoggingInterceptor _loggingInterceptor = LoggingInterceptor();

  /// Generates the Request Interceptor
  ///
  /// [requestOptions] request options
  Future<Options> getRequestInterceptor(Options requestOptions) async {
    _loggingInterceptor.printRequest(requestOptions);
    return requestOptions;
  }
}
