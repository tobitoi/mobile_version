import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/bloc/auth/auth.dart';
import 'package:mobile_version/bloc/item/item.dart';
import 'package:mobile_version/data/class/class.dart';
import 'package:mobile_version/ui/widgets/widgets.dart';
import 'package:mobile_version/utils/utils.dart';
import 'item_list.dart';

class ItemPage extends StatefulWidget {
  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemPage> {
  ScrollController controller = ScrollController();
  final _searchController = new TextEditingController();
  bool _isSearching = false;
  final _scrollThreshold = 200.0;
  List<Item> displayedList;
  ItemBloc bloc;

  void onScroll() {
    double maxScroll = controller.position.maxScrollExtent;
    double currentScroll = controller.position.pixels;
    if (currentScroll - maxScroll <= _scrollThreshold) {
      bloc.add(ItemLoad());
    }
  }

  void onSearch(String newText) {
    if (newText.isEmpty) {
      bloc.add(ClearItem());
    } else {
      bloc.add(SearchItem(itemName: newText));
    }
  }

  @override
  void dispose() {
    controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ItemBloc>(context);
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    controller.addListener(onScroll);
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Cari Item",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: onSearch,
              )
            : Text('Item', style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          _isSearching
              ? IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _isSearching = false;
                      _searchController.text = "";
                      onSearch("");
                    });
                  })
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _isSearching = true;
                    });
                  }),
        ],
      ),
      drawer: AppDrawer(),
      body: BlocListener<ItemBloc, ItemState>(
        listener: (context, state) {
          if (state is ItemError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error.substring(33)}'),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is Success) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Success'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        child: BlocBuilder<ItemBloc, ItemState>(builder: (context, state) {
          if (state is ItemLoaded) {
            if (state.items.isEmpty) {
              return Center(
                child: Text('No Items'),
              );
            }
            ItemLoaded itemloaded = state;
            return ListView.builder(
                itemCount: (itemloaded.hasReachedMax)
                    ? itemloaded.items.length
                    : itemloaded.items.length + 1,
                itemBuilder: (context, index) =>
                    (index < itemloaded.items.length)
                        ? ItemListPage(
                            items: state.items[index],
                            onDeletePressed: (id) =>
                                BlocProvider.of<ItemBloc>(context)
                                    .add(Delete(id: id)))
                        : _bottomLoader(context),
                controller: controller);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FormAddItem(
                  key: ArchSampleKeys.addItemScreen,
                  onSave: (itemName, serialNumber, ip, status, category,
                      location, date, desc, reachable) {
                    bloc.add(
                      AddItem(Item(
                          itemName: itemName,
                          serialNumber: serialNumber,
                          ipAddress: ip,
                          status: status,
                          category: category,
                          location: location,
                          dateCreation: date,
                          description: desc,
                          reachable: reachable)),
                    );
                  },
                  isEditing: false,
                );
              })),
          tooltip: 'Increment Counter',
          child: Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _bottomLoader(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}
