import 'package:meta/meta.dart';
import 'package:mobile_version/data/class/class.dart';
import 'package:mobile_version/data/config/api/api.dart';

import 'package:mobile_version/data/response/response..dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepo {
  final LoginApi _loginApi;
  final UserApi _userApi;

  UserRepo({@required LoginApi loginApi, @required UserApi userApi})
      : assert(loginApi != null),
        assert(userApi != null),
        _loginApi = loginApi,
        _userApi = userApi;

  LoginResponse _token;
  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    var data = _loginApi.login(username, password);
    await Future.delayed(Duration(seconds: 1));
    _token = await data;
    if (_token.token != null && _token.user.username != null) {
      SharedPreferences.getInstance().then((prefs) {
        var _cacheToken = _token.token;
        var _username = _token.user.email;
        prefs.setString("Authorization", _cacheToken);
        prefs.setString("username", _username);
      });
    }
    return _token.token;
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("Authorization", null);
    });
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));

    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String getToken = preferences.getString("Authorization");
    if (getToken != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<User> getuser() {
    return _userApi.userDetail();
  }

  Future<List<Menu>> getMenusRepos() {
    return _userApi.getMenu();
  }
}
