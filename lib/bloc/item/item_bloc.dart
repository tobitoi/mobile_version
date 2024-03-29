import 'package:bloc/bloc.dart';
import 'package:mobile_version/data/class/class.dart';
import 'package:mobile_version/repository/repo.dart';

import 'package:rxdart/rxdart.dart';
import 'package:meta/meta.dart';

import 'item_event.dart';
import 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
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
    if (event is ItemLoad && !_hasReachedMax(currentState)) {
      //await itemCategoryRepos.getItemReachableRepo();
      try {
        if (state is ItemUninitialized) {
          final contents = await itemCategoryRepos.getItemRepo(0, 20);
          yield ItemLoaded(items: contents, hasReachedMax: false);
        } else {
          ItemLoaded itemLoaded = state as ItemLoaded;
          int nextPage = itemLoaded.items.length ~/ 20 + 1;
          final contents = await itemCategoryRepos.getItemRepo(nextPage, 20);
          yield (contents.isEmpty && contents == null)
              ? itemLoaded.copyWith(hasReachedMax: true)
              : ItemLoaded(
                  items: itemLoaded.items + contents, hasReachedMax: false);
        }
      } catch (error) {
        yield ItemError(error: error.toString());
      }
    }
    if (event is SearchItem) {
      try {
        final items = await itemCategoryRepos.searhItemRepos(event.itemName);
        yield ItemLoaded(
            items: items, hasReachedMax: items.length < 20 ? true : false);
      } catch (error) {
        ItemError(error: error.toString());
      }
    }
    if (event is ClearItem) {
      try {
        ItemLoaded itemLoaded = state as ItemLoaded;
        int nextPage = itemLoaded.items.length ~/ 20 + 1;
        final contents = await itemCategoryRepos.getItemRepo(0, 20);
        yield ItemLoaded(
            items: contents,
            hasReachedMax: contents.length < nextPage ? true : false);
      } catch (error) {
        yield ItemError(error: error.toString());
      }
    }
    if (event is Delete) {
      final itemState = state;
      try {
        if (itemState is ItemLoaded) {
          List<Item> updateContents =
              List<Item>.from(itemState.items).map((Item content) {
            return content.id == event.id
                ? content.copyWith(isDeleting: true)
                : content;
          }).toList();
          yield ItemLoaded(
              items: updateContents,
              hasReachedMax: updateContents.length < 20 ? true : false);
          itemCategoryRepos.deleteItemRepos(event.id).listen((id) {
            add(Deleted(id: id));
          });
        }
      } catch (error) {
        yield ItemError(error: error.toString());
      }
    }
    if (event is Deleted) {
      final itemState = state;
      try {
        if (itemState is ItemLoaded) {
          final List<Item> updateContents = List<Item>.from(itemState.items)
            ..removeWhere((item) => item.id == event.id);
          yield Success();
          yield ItemLoaded(
              items: updateContents,
              hasReachedMax: updateContents.length < 20 ? true : false);
        }
      } catch (error) {
        ItemError(error: error.toString());
      }
    }
    if (event is AddItem) {
      final addItemState = state;
      try {
        if (addItemState is ItemLoaded) {
          final List<Item> updateContens = List<Item>.from(addItemState.items);
          yield ItemLoaded(
              items: updateContens,
              hasReachedMax: updateContens.length < 20 ? true : false);
          _saveItem(event.request);
        }
      } catch (error) {
        ItemError(error: error.toString());
      }
    }
    if (event is AddItem) {
      final addItemState = state;
      try {
        if (addItemState is ItemLoaded) {
          final List<Item> updateContens = List<Item>.from(addItemState.items)
            ..add(event.request);
          yield Success();
          yield ItemLoaded(
              items: updateContens,
              hasReachedMax: updateContens.length < 20 ? true : false);
        }
      } catch (error) {
        ItemError(error: error.toString());
      }
    }
    if (event is UpdateItem) {
      yield* _mapUpdateItemToState(event);
    }
  }

  Stream<ItemState> _mapUpdateItemToState(UpdateItem event) async* {
    try {
      if (state is ItemLoaded) {
        final List<Item> updateditems = (state as ItemLoaded).items.map((item) {
          return item.id == event.updateItem.id ? event.updateItem : item;
        }).toList();
        yield Success();
        yield ItemLoaded(
            items: updateditems,
            hasReachedMax: updateditems.length < 20 ? true : false);
        _saveEditItem(event.updateItem);
      }
    } catch (error) {
      ItemError(error: error.toString());
    }
  }

  Future _saveItem(Item request) async {
    return await itemCategoryRepos.addItemRepos(request);
  }

  Future _saveEditItem(Item request) async {
    return await itemCategoryRepos.editItemRepos(request);
  }

  bool _hasReachedMax(ItemState state) =>
      state is ItemLoaded && state.hasReachedMax;
}
