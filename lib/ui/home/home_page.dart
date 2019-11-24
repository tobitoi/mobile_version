import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:mobile_version/bloc/home/hometobloc.dart';
import 'package:mobile_version/ui/home/chart.dart';

import 'package:mobile_version/ui/widgets/widgets.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mobile_version/utils/utils.dart';

import 'SubscribeSeries.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final format1 = DateFormat("yyyyMMddHHmm");
  final format = DateFormat("yyyy-MM-dd HH:mm:ss");
  var startDate, endDate;
  @override
  Widget build(BuildContext context) {
    _onFilterButtonPressed() {
      BlocProvider.of<HomeBloc>(context).add(FilterBongkarMuat(
          startDate: format1.format(startDate),
          endDate: format1.format(endDate)));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
        ),
        drawer: AppDrawer(),
        body: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Sign in as ${state.username}'),
                ),
              );
            }
            if (state is HomeNotLoaded) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.error.substring(33)}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            if (state is HomeLoaded) {
              final List<SubscriberSeries> data = [
                SubscriberSeries(
                    status: '02',
                    data: state.bongkarMuat.status02,
                    barColor: charts.ColorUtil.fromDartColor(Colors.blue)),
                SubscriberSeries(
                    status: '03',
                    data: state.bongkarMuat.status03,
                    barColor: charts.ColorUtil.fromDartColor(Colors.orange)),
                SubscriberSeries(
                    status: '05',
                    data: state.bongkarMuat.status05,
                    barColor: charts.ColorUtil.fromDartColor(Colors.red)),
                SubscriberSeries(
                    status: '09',
                    data: state.bongkarMuat.status09,
                    barColor:
                        charts.ColorUtil.fromDartColor(Colors.purpleAccent)),
                SubscriberSeries(
                    status: '10',
                    data: state.bongkarMuat.status10,
                    barColor:
                        charts.ColorUtil.fromDartColor(Colors.greenAccent)),
                SubscriberSeries(
                    status: '50',
                    data: state.bongkarMuat.status50,
                    barColor:
                        charts.ColorUtil.fromDartColor(Colors.yellowAccent)),
                SubscriberSeries(
                    status: '51',
                    data: state.bongkarMuat.status51,
                    barColor: charts.ColorUtil.fromDartColor(Colors.cyan)),
                SubscriberSeries(
                    status: '55',
                    data: state.bongkarMuat.status55,
                    barColor:
                        charts.ColorUtil.fromDartColor(Colors.green[900])),
                SubscriberSeries(
                    status: '56',
                    data: state.bongkarMuat.status56,
                    barColor:
                        charts.ColorUtil.fromDartColor(Colors.yellow[700]))
              ];
              return StaggeredGridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                children: <Widget>[
                  _buildTile(
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Material(
                                color: Colors.blue,
                                shape: CircleBorder(),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Icon(Icons.timeline,
                                      color: Colors.white, size: 30.0),
                                )),
                            Padding(padding: EdgeInsets.only(bottom: 16.0)),
                            Text(state.visit.recentVisits.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24.0)),
                            Text('Weekly Visits ',
                                style: TextStyle(color: Colors.black45)),
                          ]),
                    ),
                  ),
                  _buildTile(
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Material(
                                color: Colors.teal,
                                shape: CircleBorder(),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Icon(Icons.settings_applications,
                                      color: Colors.white, size: 30.0),
                                )),
                            Padding(padding: EdgeInsets.only(bottom: 16.0)),
                            Text(state.visit.recentIp.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24.0)),
                            Text('Weekly Ip',
                                style: TextStyle(color: Colors.black45)),
                          ]),
                    ),
                  ),
                  _buildTile(
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Material(
                                color: Colors.amber,
                                shape: CircleBorder(),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Icon(Icons.notifications,
                                      color: Colors.white, size: 30.0),
                                )),
                            Padding(padding: EdgeInsets.only(bottom: 16.0)),
                            Text(state.visit.newVisits.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24.0)),
                            Text('Daily Visits ',
                                style: TextStyle(color: Colors.black45)),
                          ]),
                    ),
                  ),
                  _buildTile(
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Material(
                                color: Colors.red,
                                shape: CircleBorder(),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Icon(Icons.visibility,
                                      color: Colors.white, size: 30.0),
                                )),
                            Padding(padding: EdgeInsets.only(bottom: 16.0)),
                            Text(state.visit.newIp.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24.0)),
                            Text('Daily Ip ',
                                style: TextStyle(color: Colors.black45)),
                          ]),
                    ),
                  ),
                  _buildTile(
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                children: <Widget>[
                                  _buildStartDatePicker(),
                                  _buildEndDatePicker(),
                                  FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(10.0)),
                                      color: Colors.blue,
                                      child: Text("Filter"),
                                      onPressed: _onFilterButtonPressed),
                                ],
                              ),
                            ),
                            Chart(data: data)
                          ]),
                    ),
                  ),
                ],
                staggeredTiles: [
                  StaggeredTile.extent(1, 180.0),
                  StaggeredTile.extent(1, 180.0),
                  StaggeredTile.extent(1, 180.0),
                  StaggeredTile.extent(1, 180.0),
                  StaggeredTile.extent(2, 610.0),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
        ));
  }

  Widget _buildTile(Widget child) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: child);
  }

  Widget _buildStartDatePicker() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 15),
      child: DateTimeField(
        format: format,
        decoration: InputDecoration(
            hintText: "Please input Startdatetime",
            border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(20.0))),
        onShowPicker: (context, currentStardateValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentStardateValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(
                  currentStardateValue ?? DateTime.now()),
            );
            startDate = DateTimeField.combine(date, time);
            return DateTimeField.combine(date, time);
          } else {
            print("current $currentStardateValue");
            return currentStardateValue;
          }
        },
        onSaved: (valueStardate) => startDate = valueStardate,
      ),
    );
  }

  Widget _buildEndDatePicker() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 15),
      child: DateTimeField(
        format: format,
        decoration: InputDecoration(
            hintText: "Please input End Date Time",
            border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(20.0))),
        onShowPicker: (context, currentValueEndDate) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValueEndDate ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValueEndDate ?? DateTime.now()),
            );
            endDate = DateTimeField.combine(date, time);
            return DateTimeField.combine(date, time);
          } else {
            print("current $currentValueEndDate");
            return currentValueEndDate;
          }
        },
        onSaved: (valueEndDate) => endDate = valueEndDate,
      ),
    );
  }
}
