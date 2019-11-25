import 'package:meta/meta.dart';
import 'package:mobile_version/data/response/login_response.dart';
import '../config.dart';
import '../constant.dart';

class LoginApi {
  final BaseApi _baseApi;

  LoginApi({@required BaseApi baseApi})
      : assert(baseApi != null),
        _baseApi = baseApi;

  Future<LoginResponse> login(String username, String password) async {
    final response = await _baseApi.dio
        .post(loginUrl, data: {"username": username, "password": password});
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(response.data);
    }
    throw response.statusMessage;
  }
}
