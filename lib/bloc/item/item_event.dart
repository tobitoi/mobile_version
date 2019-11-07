import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mobile_version/data/class/class.dart';

abstract class ItemEvent extends Equatable {
  const ItemEvent() ;
  @override
  List<Object> get props => [];
}

class ClearItem extends ItemEvent {}

class ItemLoad extends ItemEvent {}

class Delete extends ItemEvent {
  final int id;

  const Delete({@required this.id});

  @override
  List<Object> get props => [id];

}

class Deleted extends ItemEvent {
  final int id;

  const Deleted({@required this.id});

  @override
  List<Object> get props => [id];

}

class AddItem extends ItemEvent {
  final Item request;

  const AddItem(this.request);

  @override
  List<Object> get props => [request];

  @override
  String toString() => 'AddReq { req: $request }';
}

class UpdateItem extends ItemEvent {
  final Item updateItem;

  const UpdateItem(this.updateItem);

  @override
  List<Object> get props => [updateItem];

  @override
  String toString() => 'updateItem { updateItem: $updateItem }';
}

class SearchItem extends ItemEvent {
  final String itemName;

  const SearchItem({@required this.itemName}) : assert(itemName != null);
  
  @override
  List<Object> get props => [itemName];
}