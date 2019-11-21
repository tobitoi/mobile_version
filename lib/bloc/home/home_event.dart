import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => [];
}

class Fetch extends HomeEvent {
  final String startDate;
  final String endDate;

  const Fetch({this.startDate, this.endDate});

  @override
  List<Object> get props => [startDate, endDate];
}

class AddVisit extends HomeEvent {
  @override
  List<Object> get props => [];
}
