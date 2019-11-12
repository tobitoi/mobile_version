
import 'package:flutter/material.dart';
import 'package:mobile_version/data/class/class.dart';
import 'package:mobile_version/data/response/response..dart';
import 'package:mobile_version/ui/widgets/widgets.dart';

import '../config.dart';

class UserApi {
  BaseApi _baseApi = BaseApi();
  BuildContext context;
 
  Future<User> userDetail() async {
    final response = await _baseApi.dio.get(userUrl);
    if (response.statusCode == 200){
      return User.fromJson(response.data);
    }else{
      print(response.statusCode);
      print(response.statusMessage);
      showDialogSingleButton(context, response.statusMessage.toString(), "ok");
      throw response.statusMessage;
    }
  }

  Future <List<MenuChildren>> getMenu() async{
    final response = await _baseApi.dio.get(menuUrl);
    if (response.statusCode == 200){
      return Menu.fromJson(response.data[0]).children;
    }else{
      print(response.statusCode);
      print(response.statusMessage);
      showDialogSingleButton(context, response.statusMessage.toString(), "ok");
      throw response.statusMessage;
    }
  }
}