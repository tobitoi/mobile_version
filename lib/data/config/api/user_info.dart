import 'package:flutter/material.dart';
import 'package:mobile_version/data/class/class.dart';
import 'package:mobile_version/ui/widgets/widgets.dart';

import '../config.dart';

class UserApi {
  final BaseApi _baseApi;
  BuildContext context;

  UserApi({@required BaseApi baseApi})
      : assert(baseApi != null),
        _baseApi = baseApi;

  Future<User> userDetail() async {
    final response = await _baseApi.dio.get(userUrl);
    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    } else {
      throw response.statusMessage;
    }
  }

  Future<List<Menu>> getMenu() async {
    final response = await _baseApi.dio.get(menuUrl);
    if (response.statusCode == 200) {
      List responseJson = response.data;
      return responseJson.map((m) => new Menu.fromJson(m)).toList();
    } else {
      throw response.statusMessage;
    }
  }
}
