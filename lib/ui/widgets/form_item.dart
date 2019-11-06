import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_version/bloc/item/item.dart';
import 'package:mobile_version/data/class/class.dart';
import 'package:mobile_version/data/config/config.dart';
import 'package:mobile_version/data/response/response..dart';
import 'package:mobile_version/utils/utils.dart';

typedef OnSaveCallback = Function(String itemName,
                        String serialNumber,
                        String ip,
                        String status,
                        Category category,
                        String location,
                        String date,
                        String desc 
                      );
class FormAddItem extends StatefulWidget {

  final bool isEditing;
  final OnSaveCallback onSave;
  final Item item;
  
   FormAddItem({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.item,
  }) : super(key: key ?? ArchSampleKeys.addItemScreen);

  @override
  _FormAddItemScreenState createState() => _FormAddItemScreenState();
  
}

class _FormAddItemScreenState extends State<FormAddItem> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool get isEditing => widget.isEditing;
  Future<CategoryResponse> list = ItemCategoryApi().getCategory();
  // ApiService _apiService = ApiService();
  bool _isFieldNameValid;
  bool _isFieldSnValid;
  bool _isFieldIpValid;
  bool _isFieldLocationValid;
  bool _isFieldDescValid;
  bool _isFieldDateValid;
  var selectedCategory,selectedStatus,datetime;
  final format = DateFormat("yyyy-MM-dd HH:mm:ss");

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerSn = TextEditingController();
  TextEditingController _controllerIp = TextEditingController();
  TextEditingController _controllerLocation = TextEditingController();
  TextEditingController _controllerDesc = TextEditingController();

  @override
  void initState() {
    super.initState();
    categoryBloc.category();
  }

  Widget _buildTextFieldItemName() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child:  TextField(
        controller: _controllerName,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "Item name",
          errorText: _isFieldNameValid == null || _isFieldNameValid
              ? null
              : "Item name is required",
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(20.0)
          ) 
        ),
        onChanged: (value) {
          bool isFieldValid = value.trim().isNotEmpty;
          if (isFieldValid != _isFieldNameValid) {
            setState(() => _isFieldNameValid = isFieldValid);
          }
        },
      ),
    );
  }

  Widget _buildTextFieldSn() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child:  TextField(
        controller: _controllerSn,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "Serial Number",
          errorText: _isFieldSnValid == null || _isFieldSnValid
              ? null
              : "Serial Number is required",
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(20.0)
          ) 
        ),
        onChanged: (value) {
          bool isFieldValid = value.trim().isNotEmpty;
          if (isFieldValid != _isFieldSnValid) {
            setState(() => _isFieldSnValid = isFieldValid);
          }
        },
      ),
    );
  }

  Widget _buildTextFieldIp() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: TextField(
        controller: _controllerIp,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: "Ip Address",
          errorText: _isFieldIpValid == null || _isFieldIpValid
              ? null
              : "Ip Address is required",
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(20.0)
          ) 
        ),
        onChanged: (value) {
          bool isFieldValid = value.trim().isNotEmpty;
          if (isFieldValid != _isFieldIpValid) {
            setState(() => _isFieldIpValid = isFieldValid);
          }
        },
      ),
    );
  }

  Widget _buildTextFieldLocation() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: TextField(
        controller: _controllerLocation,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "Location",
          errorText: _isFieldLocationValid == null || _isFieldLocationValid
              ? null
              : "Location is required",
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(20.0)
          ) 
        ),
        onChanged: (value) {
          bool isFieldValid = value.trim().isNotEmpty;
          if (isFieldValid != _isFieldLocationValid) {
            setState(() => _isFieldLocationValid = isFieldValid);
          }
        },
      ),
    );
  }

  Widget _buildTextAreaDesc() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: TextField(
        maxLines: 8,
        controller: _controllerDesc,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "Description",
          errorText: _isFieldDescValid == null || _isFieldDescValid
              ? null
              : "Description is required",
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(20.0)
          ) 
        ),
        onChanged: (value) {
          bool isFieldValid = value.trim().isNotEmpty;
          if (isFieldValid != _isFieldDescValid) {
            setState(() => _isFieldDescValid = isFieldValid);
          }
        },
      ),
    );
  }

  Widget _buildDropdownCategory( CategoryResponse categoryResponse)  {
    var catContent = categoryResponse.contentCategory;
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
          style: BorderStyle.solid, width: 0.80),
        ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<Category>(
            isDense: true,
            items: catContent
          .map((value) => DropdownMenuItem<Category>(
              child: Text(
              value.categoryName
            ),
            value: value
          )).toList(),
          
          onChanged: (Category selectedCat) {
            setState(() {
              selectedCategory = selectedCat;
            });
          },
          
          isExpanded: false,
          value: selectedCategory,
          hint: Text(
          'Choose Category',
          )),
        ),
      ),
      )
    );           
  }

   Widget _buildDropdownStatus() {
    List<String> _status = <String>[
    'Working',
    'Maintenance',
    'Broken'
  ];
  
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
          style: BorderStyle.solid, width: 0.80),
        ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isDense: true,
            items: _status
            .map((value) => DropdownMenuItem(
              child: Text(
              value
            ),
            value: value,
          )).toList(),
          onChanged: (selectedStatusType) {
          setState(() {
            selectedStatus = selectedStatusType;
           
          });
          },
          value: selectedStatus,
          isExpanded: false,
          hint: Text(
          'Choose Status',
          )),
        ),
      ),
      )
    );           
  }

  Widget _buildDatePicker() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child:DateTimeField(
        format: format,
        decoration: InputDecoration(
          labelText: "Date of Procurement",
          errorText: _isFieldDateValid == null || _isFieldDateValid
              ? null
              : "Date of Procurement is required",
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(20.0)
          ) 
        ),
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            datetime = DateTimeField.combine(date, time);
            return DateTimeField.combine(date, time);
          } else {
            print("current $currentValue");
            return currentValue;
          }
        },
      ),
    );
  }
  
  Widget _getDataDropdown() {
    return StreamBuilder<CategoryResponse>(
      stream: categoryBloc.subjectCategory.stream,
      builder: (context, AsyncSnapshot<CategoryResponse> snapshot) {
        if (!snapshot.hasData)return _bottomLoader(context);
        return _buildDropdownCategory(snapshot.data);
      },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Form Add",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
        child:Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldItemName(),
                _buildTextFieldSn(),
                _buildTextFieldIp(),
                _getDataDropdown(),
                _buildDropdownStatus(),
                _buildTextFieldLocation(),
                _buildDatePicker(),
                _buildTextAreaDesc(),
              ],
            ),
          ),
        ),  
      ),
      floatingActionButton: FloatingActionButton(
        key:
        isEditing ? ArchSampleKeys.saveItemFab : ArchSampleKeys.saveNewItem,
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
  
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(
              _controllerName.text.toString(), 
              _controllerSn.text.toString(),
              _controllerIp.text.toString(),
              selectedStatus,
              selectedCategory,
              _controllerLocation.text.toString(),
              datetime.toString(),
              _controllerDesc.text.toString());
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
