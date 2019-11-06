import 'category.dart';

class Item{
  int id;
  String itemName;
  String ipAddress;
  String location;
  String status;
  String serialNumber;
  String description;
  String dateCreation;
  String reachable;
  int createTime;
  Category category;
  String categoryName;
  String label;
  bool isDeleting; // add manually not get from response

  Item(
      {this.id,
      this.itemName,
      this.ipAddress,
      this.location,
      this.status,
      this.serialNumber,
      this.description,
      this.dateCreation,
      this.reachable,
      this.createTime,
      this.category,
      this.categoryName,
      this.label,
      this.isDeleting = false});// add manually not get from response

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['itemName'];
    ipAddress = json['ipAddress'];
    location = json['location'];
    status = json['status'];
    serialNumber = json['serialNumber'];
    description = json['description'];
    dateCreation = json['dateCreation'];
    reachable = json['reachable'];
    createTime = json['createTime'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    categoryName = json['categoryName'];
    label = json['label'];
    isDeleting = false;// add manually not get from response
  }

 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['itemName'] = this.itemName;
    data['ipAddress'] = this.ipAddress;
    data['location'] = this.location;
    data['status'] = this.status;
    data['serialNumber'] = this.serialNumber;
    data['description'] = this.description;
    data['dateCreation'] = this.dateCreation;
    data['reachable'] = this.reachable;
    data['createTime'] = this.createTime;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['categoryName'] = this.categoryName;
    data['label'] = this.label;
    return data;
  }

    Item copyWith({
    String id,
    String itemName,
    String ipAddress,
    String location,
    String status,
    String serialNumber,
    String description,
    String dateCretion,
    String reachable,
    String dateCreation,
    int createTime,
    Category category,
    String categoryName,
    String label,
    bool isDeleting,// add manually not get from response
  }) {
    return Item(
      id: id ?? this.id,
      itemName: itemName ?? this.itemName,
      ipAddress: ipAddress ?? this.ipAddress,
      location: location ?? this.location,
      status: status ?? this.status,
      serialNumber: serialNumber ?? this.serialNumber,
      description: description ?? this.description,
      dateCreation: dateCreation ?? this.dateCreation,
      reachable: reachable ?? this.reachable,
      createTime: createTime ?? this.createTime,
      category: category ?? this.category,
      categoryName: categoryName ?? this.categoryName,
      label: label ?? this.label,
      isDeleting: isDeleting ?? this.isDeleting// add manually not get from response

    );
  }
}