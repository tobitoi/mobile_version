import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'base_dio/barrel_dio.dart';
import 'constant.dart';

class BaseApi{
  RequestInterceptor _requestInterceptor = RequestInterceptor();
  ResponseInterceptor _responseInterceptor = ResponseInterceptor();
  ErrorInterceptor _errorInterceptor = ErrorInterceptor();
  
  
  Dio dio;
  BaseApi(){
    
    dio = Dio();
    dio.options.baseUrl = BaseUrl;
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (Options option) async{
        //to recovery token
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String getToken = preferences.getString("Authorization");
        option.headers = {
          "Authorization": "Bearer $getToken",
          "Content-Type" : "application/json"
        };
      },
      onError: (DioError e){
        if (e.response?.statusCode == 401){
          
         print("eeerrors ${e.response.statusCode}");
         print("eeerrorssss ${e.response.statusMessage}");
        }
      }
    ));
    _setupLoggingInterceptor();
  }

  void _setupLoggingInterceptor() {

    dio.interceptors.add(InterceptorsWrapper(
      onRequest:(RequestOptions options) async {
      return _requestInterceptor.getRequestInterceptor(options);
      },
      onResponse:(Response response) async {
      return _responseInterceptor.getResponseInterceptor(response);
      },
      onError: (DioError e) async {
      return _errorInterceptor.getErrorInterceptors(e);
      }
    ));
  }
}