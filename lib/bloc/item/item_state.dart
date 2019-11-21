import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mobile_version/data/class/class.dart';
import 'package:mobile_version/data/response/response..dart';

abstract class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object> get props => [];
}

class ItemUninitialized extends ItemState {}

class ItemError extends ItemState {
  final String error;

  const ItemError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ItemError { error: $error }';
}

class ItemLoaded extends ItemState {
  final List<Item> items;
  final bool hasReachedMax;

  const ItemLoaded({this.items, this.hasReachedMax});

  ItemLoaded copyWith({ItemResponse itemResponse, bool hasReachedMax}) {
    return ItemLoaded(
        items: itemResponse.content ?? this.items,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  List<Object> get props => [items, hasReachedMax];

  @override
  String toString() =>
      'ItemLoad { contents: ${items.length}, hasReachedMax: $hasReachedMax }';
}

class Success extends ItemState{}
