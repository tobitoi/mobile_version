
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_version/bloc/item/item.dart';
import 'package:mobile_version/data/class/class.dart';
import 'package:mobile_version/ui/widgets/widgets.dart';
import 'package:mobile_version/utils/keys.dart';


class ItemListPage extends StatelessWidget {
  final Item items;
  final Function(int) onDeletePressed;
  
  Icon online(){
    if (items.reachable == 'positive' || items.reachable == null ){
      return Icon(Icons.album, color: Colors.green);
    }else{
     return Icon(Icons.album, color: Colors.red);
    }
  }
  const ItemListPage({
    Key key,
    @required this.items,
    @required this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     
  return Center(
    child: Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: online(),
            title: Text(items.itemName),            
            subtitle: Text(items.ipAddress + "\n"+items.status),
            isThreeLine: true,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed:() => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          print("itm ${items.copyWith()}");
                          return FormAddItem(
                            key: ArchSampleKeys.editItemScreen,
                            onSave: (itemName, serialNumber, ip, status,category, location, date, desc) {
                              BlocProvider.of<ItemBloc>(context).add(
                                UpdateItem(
                                 items.copyWith(
                                   itemName: itemName,
                                   serialNumber: serialNumber,
                                   ipAddress: ip,
                                   status: status,
                                   category: category,
                                   location: location,
                                   dateCreation: date,
                                   description: desc
                                 )
                                ),
                                
                              );
                             
                            },
                            isEditing: true,
                            item: items,
                            
                          );
                        },
                      ),
                    )
                ),
                items.isDeleting
                ? CircularProgressIndicator()
                : IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => onDeletePressed(items.id),
                ),
                
              ],
            )
          ),
          
        ],
      ),
    ),
  );
}

}