import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_version/bloc/item/item.dart';
import 'package:mobile_version/data/class/class.dart';
import 'package:mobile_version/data/config/config.dart';
import 'package:mobile_version/data/response/response..dart';
import 'package:mobile_version/utils/utils.dart';

typedef OnSaveCallback = Function(
    String itemName,
    String serialNumber,
    String ip,
    String status,
    Category category,
    String location,
    String date,
    String desc);

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
  String _itemName;
  String _serialNumber;
  String _isFieldIpValid;
  String _isFieldLocationValid;
  String _isFieldDescValid;

  var selectedCategory, selectedStatus, datetime;
  final format = DateFormat("yyyy-MM-dd HH:mm:ss.000");

  @override
  void initState() {
    super.initState();
    categoryBloc.category();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = ArchSampleLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            isEditing ? localizations.editItem : localizations.addItems,
          )),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
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
        tooltip: isEditing ? localizations.saveChanges : localizations.addItems,
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(
                _itemName,
                _serialNumber,
                _isFieldIpValid,
                selectedStatus,
                selectedCategory,
                _isFieldLocationValid,
                datetime.toString(),
                _isFieldDescValid);
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  Widget _buildTextFieldItemName() {
    final localizations = ArchSampleLocalizations.of(context);
    return Container(
      padding: EdgeInsets.all(10.0),
      child: TextFormField(
        initialValue: isEditing ? widget.item.itemName : '',
        key: ArchSampleKeys.itemFieldName,
        autofocus: !isEditing,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: localizations.newItemNameHint,
            border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(20.0))),
        validator: (val) {
          return val.trim().isEmpty ? localizations.emptyItemNameError : null;
        },
        onSaved: (value) => _itemName = value,
      ),
    );
  }

  Widget _buildTextFieldSn() {
    final localizations = ArchSampleLocalizations.of(context);
    return Container(
      padding: EdgeInsets.all(10.0),
      child: TextFormField(
        initialValue: isEditing ? widget.item.serialNumber : '',
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: localizations.newSerialNumberHint,
            border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(20.0))),
        validator: (val) {
          return val.trim().isEmpty ? localizations.emptySerialError : null;
        },
        onSaved: (value) => _serialNumber = value,
      ),
    );
  }

  Widget _buildTextFieldIp() {
    final localizations = ArchSampleLocalizations.of(context);
    return Container(
      padding: EdgeInsets.all(10.0),
      child: TextFormField(
        initialValue: isEditing ? widget.item.ipAddress : '',
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: localizations.newIpAddressHint,
            border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(20.0))),
        onSaved: (value) => _isFieldIpValid = value,
      ),
    );
  }

  Widget _buildTextFieldLocation() {
    final localizations = ArchSampleLocalizations.of(context);
    return Container(
      padding: EdgeInsets.all(10.0),
      child: TextFormField(
        initialValue: isEditing ? widget.item.location : '',
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: localizations.newLocationHint,
            border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(20.0))),
        onSaved: (value) => _isFieldLocationValid = value,
      ),
    );
  }

  Widget _buildTextAreaDesc() {
    final localizations = ArchSampleLocalizations.of(context);
    return Container(
      padding: EdgeInsets.all(10.0),
      child: TextFormField(
        maxLines: 8,
        initialValue: isEditing ? widget.item.description : '',
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: localizations.newDescHint,
            border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(20.0))),
        onSaved: (value) => _isFieldDescValid = value,
      ),
    );
  }

  Widget _buildDropdownCategory(CategoryResponse categoryResponse) {
    var catContent = categoryResponse.contentCategory;
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(style: BorderStyle.solid, width: 0.80),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Category>(
                  isDense: true,
                  items: catContent?.isNotEmpty == true
                      ? catContent
                          .map((value) => DropdownMenuItem<Category>(
                              child: Text(value.categoryName), value: value))
                          .toList()
                      : const [],
                  onChanged: (Category selectedCat) {
                    setState(() {
                      selectedCategory = selectedCat;
                      print("selected ${selectedCategory.toString()}");
                    });
                  },
                  isExpanded: false,
                  value: isEditing ? widget.item.category : selectedCategory,
                  hint: Text(
                    'Choose Category',
                  )),
            ),
          ),
        ));
  }

  Widget _buildDropdownStatus() {
    List<String> _initStatus = <String>['Working', 'Maintenance', 'Broken'];
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(style: BorderStyle.solid, width: 0.80),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  isDense: true,
                  items: _initStatus
                      .map((value) => DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          ))
                      .toList(),
                  onChanged: (selectedStatusType) {
                    setState(() {
                      selectedStatus = selectedStatusType;
                    });
                  },
                  value: isEditing ? widget.item.status : selectedStatus,
                  isExpanded: false,
                  hint: Text(
                    'Choose Status',
                  )),
            ),
          ),
        ));
  }

  Widget _buildDatePicker() {
    final localizations = ArchSampleLocalizations.of(context);
    return Container(
      padding: EdgeInsets.all(10.0),
      child: DateTimeField(
        format: format,
        decoration: InputDecoration(
            hintText: localizations.newDOPHint,
            border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(20.0))),
        initialValue:
            isEditing ? convertStringToDate(widget.item.dateCreation) : null,
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
            print("current $datetime");

            return DateTimeField.combine(date, time);
          } else {
            print("current $currentValue");
            return currentValue;
          }
        },
        onSaved: (value) => datetime = value,
      ),
    );
  }

  Widget _getDataDropdown() {
    return StreamBuilder<CategoryResponse>(
      stream: categoryBloc.subjectCategory.stream,
      builder: (context, AsyncSnapshot<CategoryResponse> snapshot) {
        if (!snapshot.hasData) return _bottomLoader(context);
        return _buildDropdownCategory(snapshot.data);
      },
    );
  }

  DateTime convertStringToDate(String date) {
    DateTime toDateTime;
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss.000");
    if (date != null) {
      toDateTime = dateFormat.parse(date);
    } else {
      return null;
    }
    return toDateTime;
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
