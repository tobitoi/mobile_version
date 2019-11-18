import 'package:mobile_version/data/class/class.dart';
import 'package:mobile_version/data/config/base_api.dart';

import '../constant.dart';

class Dashboard {
  BaseApi _baseApi = BaseApi();

  Future<Visit> visit() async {
    final response = await _baseApi.dio.get(visitsUrl);
    if (response.statusCode == 200) {
      return Visit.fromJson(response.data);
    } else {
      throw response.statusMessage;
    }
  }

  Future<bool> addVisit() async {
    final response = await _baseApi.dio.post(visitsUrl);
    if (response.statusCode == 201) {
      return true;
    } else {
      throw response.statusMessage;
    }
  }
}
