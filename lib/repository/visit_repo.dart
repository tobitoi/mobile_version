import 'package:mobile_version/data/class/class.dart';
import 'package:mobile_version/data/config/config.dart';

class VisitRepo {
  Dashboard _dashboard = Dashboard();

  Future<Visit> getVisitRepo() {
    return _dashboard.visit();
  }

  Future<bool> addVisitRepo() {
    return _dashboard.addVisit();
  }
}
