import 'package:bloc/bloc.dart';
import 'package:mobile_version/data/class/class.dart';
import 'package:mobile_version/repository/repo.dart';

import 'package:rxdart/rxdart.dart';
import 'package:meta/meta.dart';

import 'item_event.dart';
import 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState>{
  final ItemCategoryRepos itemCategoryRepos;
  
  ItemBloc({@required this.itemCategoryRepos});

  @override
  Stream<ItemState> transformEvents(
    Stream<ItemEvent> events,
    Stream<ItemState> Function(ItemEvent event) next,
  ) {
    return super.transformEvents(
      (events as Observable<ItemEvent>).debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  ItemState get initialState => ItemUninitialized();

  @override
  Stream<ItemState> mapEventToState(ItemEvent event) async* {
  
    final currentState = state;
    if (event is ItemLoad && !_hasReachedMax(currentState)){
      try{
         if(state is ItemUninitialized){
          final contents = await itemCategoryRepos.getItemRepo(0, 20);
          yield ItemLoaded(items: contents, hasReachedMax: false);
        }else{
          ItemLoaded itemLoaded = state as ItemLoaded;
          int nextPage = itemLoaded.items.length ~/ 20 + 1;
          final contents = await itemCategoryRepos.getItemRepo(nextPage, 20);  
          yield(contents.isEmpty && contents == null)
          ? itemLoaded.copyWith(hasReachedMax: true) 
          : ItemLoaded(items: itemLoaded.items + contents, hasReachedMax: false);
        }
      }catch(_){
        yield ItemError();
      }
    }
    if (event is SearchItem){
      ItemLoaded itemLoaded = state as ItemLoaded;
      int nextPage = itemLoaded.items.length ~/ 20 + 1;
      final items = await itemCategoryRepos.searhItemRepos(event.itemName);
      yield ItemLoaded(items: items, hasReachedMax: items.length < nextPage ? true : false);    
    }
    if(event is Delete){
      final itemState = state;
      if (itemState is ItemLoaded){
        List<Item> updateContents = List<Item>.from(itemState.items).map((Item content){
          return content.id == event.id ? content.copyWith(isDeleting: true) : content;
        }).toList();
        yield ItemLoaded(items: updateContents, hasReachedMax: false);
        itemCategoryRepos.deleteItemRepos(event.id).listen((id){
          add(Deleted(id: id));
        });
      }
    }
    if (event is Deleted) {
      final itemState = state;
      if (itemState is ItemLoaded) {
        final List<Item> updateContents = List<Item>.from(itemState.items)
          ..removeWhere((item) => item.id == event.id);
        yield ItemLoaded(items: updateContents, hasReachedMax: false );
      }
    }
    if(event is AddItem){
      final addItemState = state;
      if( addItemState is ItemLoaded){
        final List<Item> updateContens = List<Item>.from(addItemState.items);
         yield ItemLoaded(items: updateContens, hasReachedMax: false);
        _saveItem(event.request);
      }
    }
    if(event is AddItem){
      final addItemState = state;
      if( addItemState is ItemLoaded){
        final List<Item> updateContens = List<Item>.from(addItemState.items)
          ..add(event.request);
         yield ItemLoaded(items: updateContens, hasReachedMax: false);
        
      }
    }
    if (event is UpdateItem){
      yield* _mapUpdateItemToState(event);
    }
  }

  Stream<ItemState> _mapUpdateItemToState(UpdateItem event) async* {
    if (state is ItemLoaded) {
      final List<Item> updateditems = (state as ItemLoaded).items.map((item) {
        return item.id == event.updateItem.id ? event.updateItem : item;
      }).toList();
      yield ItemLoaded(items:updateditems,  hasReachedMax: false );
      _saveEditItem(event.updateItem);
    }
  }

  Future _saveItem(Item request) async{
    return await itemCategoryRepos.addItemRepos(request);
  }

  Future _saveEditItem(Item request) async{
    return await itemCategoryRepos.editItemRepos(request);
  }
  bool _hasReachedMax(ItemState state) =>
      state is ItemLoaded && state.hasReachedMax;
  }



