import 'package:mobile_version/data/class/class.dart';

class CategoryResponse {
  List<Category> contentCategory;
  int totalElements;

  CategoryResponse({this.contentCategory, this.totalElements});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      contentCategory = new List<Category>();
      json['content'].forEach((v) {
        contentCategory.add(new Category.fromJson(v));
      });
    }
    totalElements = json['totalElements'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contentCategory != null) {
      data['content'] =
          this.contentCategory.map((v) => v.toJson()).toList();
    }
    data['totalElements'] = this.totalElements;
    return data;
  }
}