import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => [];
}

class Fetch extends HomeEvent {
  @override
  List<Object> get props => [];
}

class AddVisit extends HomeEvent {
  @override
  List<Object> get props => [];
}
