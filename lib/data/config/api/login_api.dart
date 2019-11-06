import 'package:dio/dio.dart';
import 'package:mobile_version/data/response/login_response.dart';

import '../constant.dart';

class LoginApi {
   Dio createDio() {
    return Dio(
      BaseOptions(
        connectTimeout: 5000,
        receiveTimeout: 5000,
        baseUrl: BaseUrl
      )
    );
  }

 
  Future <LoginResponse> login(String username, String password) async {
    final response = await createDio().post(loginUrl,data: {"username": username, "password": password});
    if (response.statusCode == 200){
      return LoginResponse.fromJson(response.data);
    }else{
     throw response.statusMessage;
    }
  }
}