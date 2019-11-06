
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/bloc/auth/auth.dart';
import 'package:mobile_version/bloc/item/item.dart';
import 'package:mobile_version/data/class/class.dart';
import 'package:mobile_version/data/config/config.dart';
import 'package:mobile_version/ui/widgets/widgets.dart';
import 'package:mobile_version/utils/utils.dart';
import 'item_list.dart';


class ItemPage extends StatefulWidget {
  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemPage> {
  ScrollController controller = ScrollController();
  final _scrollThreshold = 200.0;

  ItemBloc bloc;

  void onScroll(){
    double maxScroll = controller.position.maxScrollExtent;
    double currentScroll = controller.position.pixels;
    if( currentScroll - maxScroll <=_scrollThreshold){
      bloc.add(ItemLoad());
    } 
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ItemBloc>(context);
    controller.addListener(onScroll);
    return Scaffold(
       appBar: AppBar
      (
        elevation: 2.0,
        title: Text( "Item",textScaleFactor: textScaleFactor), 
      ),
      drawer: AppDrawer(),
      body: BlocBuilder<ItemBloc, ItemState>(
          builder: (context, state){
            if (state is ItemError) {
              return Center(
                child: Text('Oops something went wrong!'),
              );
            }
            if (state is ItemLoaded){
              if(state.items.isEmpty){
                return Center(
                  child: Text('no posts'),
                );
              }
              return ListView.builder(
                itemBuilder: (BuildContext context, int index){
                  return index >= state.items.length
                  ? _bottomLoader(context)
                  : ItemListPage(
                    items: state.items[index],
                     onDeletePressed: (id){
                       BlocProvider.of<ItemBloc>(context).add(Delete(id: id));
                     } 
                    );
                },
                itemCount: state.hasReachedMax
                ? state.items.length
                : state.items.length + 1,
                controller: controller
              ); 
            }
            return Center(
              child: CircularProgressIndicator(),
            );      
          }
        ),
      floatingActionButton: FloatingActionButton(
      onPressed: () =>  Navigator.push(context,
        MaterialPageRoute(builder: (context) {
          return 
          FormAddItem(
            key: ArchSampleKeys.addItemScreen,
            onSave: (itemName, serialNumber, ip, status,category, location, date, desc ) {
              bloc.add(AddItem(
                Item(
                  itemName: itemName, 
                  serialNumber: serialNumber,
                  ipAddress: ip,
                  status: status,
                  category: category ,
                  location: location,
                  dateCreation: date,
                  description: desc
                )
              ),
            );
          },
          isEditing: false,
          );
        })
      ),
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
