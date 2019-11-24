import 'package:mobile_version/data/response/login_response.dart';
import '../config.dart';
import '../constant.dart';

class LoginApi {
  BaseApi _baseApi = BaseApi();

  Future<LoginResponse> login(String username, String password) async {
    final response = await _baseApi.dio
        .post(loginUrl, data: {"username": username, "password": password});
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(response.data);
    }
     throw response.statusMessage;
  }
}
