import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/bloc/auth/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'base_dio/barrel_dio.dart';
import 'constant.dart';

class BaseApi {
  RequestInterceptor _requestInterceptor = RequestInterceptor();
  ResponseInterceptor _responseInterceptor = ResponseInterceptor();
  ErrorInterceptor _errorInterceptor = ErrorInterceptor();

  Dio dio;

  BaseApi() {
    dio = Dio();
    dio.options.baseUrl = BaseUrl;
    dio.interceptors.add(InterceptorsWrapper(onRequest: (Options option) async {
      //to recovery token
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String getToken = preferences.getString("Authorization");
      if (getToken != null) {
        option.headers['Authorization'] = 'Bearer ' + getToken;
        option.headers['Content-Type'] = 'application/json';
        return option;
      }
      return option;
    }, onError: (DioError e) {
      
        if (e.response != null) {
          var errorResponse = e.response.data['message'];
          if (e.response.statusCode == 401) {
            BuildContext context;
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).popAndPushNamed("/");
              BlocProvider<AuthenticationBloc>(
                  builder: (context) => AuthenticationBloc()..add(LoggedOut()));
            });
          }
          return errorResponse;
        }else {
          return e.error;
        }
      }
    ));
    _setupLoggingInterceptor();
  }

  void _setupLoggingInterceptor() {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      return _requestInterceptor.getRequestInterceptor(options);
    }, onResponse: (Response response) async {
      return _responseInterceptor.getResponseInterceptor(response);
    }, onError: (DioError e) async {
      return _errorInterceptor.getErrorInterceptors(e);
    }));
  }
}
