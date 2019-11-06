import 'package:mobile_version/data/class/class.dart';

class ItemResponse {
  List<Item> content;
  int totalElements;

  ItemResponse({this.content, this.totalElements});

  ItemResponse.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = new List<Item>();
      json['content'].forEach((v) {
        content.add(new Item.fromJson(v));
      });
    }
    totalElements = json['totalElements'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content.map((v) => v.toJson()).toList();
    }
    data['totalElements'] = this.totalElements;
    return data;
  }
}