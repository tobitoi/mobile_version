import 'package:equatable/equatable.dart';
import 'package:mobile_version/data/class/class.dart';
import 'package:mobile_version/data/response/response..dart';


abstract class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object> get props => [];
}

class ItemUninitialized extends ItemState {}

class ItemError extends ItemState {}

class ItemLoaded extends ItemState {
  final List<Item> items;
  final bool hasReachedMax;

  const ItemLoaded({this.items,this.hasReachedMax});

  ItemLoaded copyWith({ItemResponse itemResponse, bool hasReachedMax}){
    return ItemLoaded(
      items: itemResponse.content ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax
    );
  }

  @override
  List<Object> get props => [items, hasReachedMax];

  @override
  String toString() =>
      'PostLoaded { contents: ${items.length}, hasReachedMax: $hasReachedMax }';
}