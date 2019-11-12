class Menu {
  List<MenuChildren> children;

  Menu({this.children});

  Menu.fromJson(Map<String, dynamic> json) {
    if (json['children'] != null) {
      children = new List<MenuChildren>();
      json['children'].forEach((v) {
        children.add(new MenuChildren.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MenuChildren {
  String name;
  String path;
  String component;
  Meta meta;

  MenuChildren({this.name, this.path, this.component, this.meta});

  MenuChildren.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    path = json['path'];
    component = json['component'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['path'] = this.path;
    data['component'] = this.component;
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}

class Meta {
  String title;
  String icon;

  Meta({this.title, this.icon});

  Meta.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['icon'] = this.icon;
    return data;
  }
}