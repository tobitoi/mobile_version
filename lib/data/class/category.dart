class Category {
  int id;
  String categoryName;
  int createTime;
  String label;

  Category({this.id, this.categoryName, this.createTime, this.label});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['categoryName'];
    createTime = json['createTime'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryName'] = this.categoryName;
    data['createTime'] = this.createTime;
    data['label'] = this.label;
    return data;
  }

  bool operator ==(o) => o is Category && o.categoryName == categoryName;
  int get hashCode => categoryName.hashCode;
}
