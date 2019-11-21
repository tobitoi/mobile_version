import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class SubscriberSeries {
  final String status;
  final int data;
  final charts.Color barColor;

  SubscriberSeries(
      {@required this.status,
      @required this.data,
      @required this.barColor});
}