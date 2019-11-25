import 'package:meta/meta.dart';
import 'package:mobile_version/data/class/class.dart';
import 'package:mobile_version/data/config/base_api.dart';
import 'package:mobile_version/data/response/response..dart';

import '../constant.dart';

class Dashboard {
  final BaseApi _baseApi;

  Dashboard({@required BaseApi baseApi})
      : assert(baseApi != null),
        _baseApi = baseApi;

  Future<Visit> visit() async {
    final response = await _baseApi.dio.get(visitsUrl);
    if (response.statusCode == 200) {
      return Visit.fromJson(response.data);
    } else {
      throw response.data;
    }
  }

  Future<bool> addVisit() async {
    final response = await _baseApi.dio.post(visitsUrl);
    if (response.statusCode == 201) {
      return true;
    } else {
      throw response.data;
    }
  }

  Future<BongkarMuatResponse> bongkarMuat(
      {String startTime, String endTime}) async {
    final response = await _baseApi.dio.get(bongkarMuatUrl,
        queryParameters: {"startDateTime": startTime, "endDateTime": endTime});
    if (response.statusCode == 200) {
      return BongkarMuatResponse.fromJson(response.data);
    } else {
      throw response.data;
    }
  }

  Future<BongkarMuatResponse> bongkarMuatParams() async {
    final response = await _baseApi.dio.get(bongkarMuatUrl);
    if (response.statusCode == 200) {
      return BongkarMuatResponse.fromJson(response.data);
    } else {
      throw response.data;
    }
  }
}
