import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter/material.dart';

import 'SubscribeSeries.dart';

class Chart extends StatelessWidget {
  final List<SubscriberSeries> data;
  Chart({@required this.data});
  @override
  Widget build(BuildContext context) {
    List<charts.Series<SubscriberSeries, String>> series = [
      charts.Series(
          id: "Subscribers",
          data: data,
          domainFn: (SubscriberSeries series, _) => series.status,
          measureFn: (SubscriberSeries series, _) => series.data,
          colorFn: (SubscriberSeries series, _) => series.barColor,
          labelAccessorFn: (SubscriberSeries row, _) => '${row.data}')
    ];
    return Container(
      height: 400,
      child: Card(
        child: Column(
          children: <Widget>[
            Text(
              "Total Container By Status",
              style: Theme.of(context).textTheme.body2,
            ),
            Expanded(
              child: charts.BarChart(
                series,
                animate: true,  
                barRendererDecorator: new charts.BarLabelDecorator<String>(
                  labelPosition: charts.BarLabelPosition.outside,
                  insideLabelStyleSpec:  new charts.TextStyleSpec(color: charts.MaterialPalette.black.darker)
                ),
                domainAxis: new charts.OrdinalAxisSpec(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
