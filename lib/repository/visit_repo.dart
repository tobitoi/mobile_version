import 'package:meta/meta.dart';
import 'package:mobile_version/data/class/class.dart';
import 'package:mobile_version/data/config/config.dart';
import 'package:mobile_version/data/response/response..dart';

class VisitRepo {
  final Dashboard _dashboard;

  VisitRepo({@required Dashboard dashboard})
      : assert(dashboard != null),
        _dashboard = dashboard;

  Future<Visit> getVisitRepo() {
    return _dashboard.visit();
  }

  Future<bool> addVisitRepo() {
    return _dashboard.addVisit();
  }

  Future<BongkarMuatResponse> getBongkarMuatRepo() {
    return _dashboard.bongkarMuatParams();
  }

  Future<BongkarMuatResponse> getBongkarMuatRepoFilter(
      String startTime, String endTime) {
    return _dashboard.bongkarMuat(startTime: startTime, endTime: endTime);
  }
}
