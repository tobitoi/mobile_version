import 'dart:convert';

class Menu {
  String name;
  String path;
  String redirect;
  String component;
  bool alwaysShow;
  Meta meta;
  List<Children> children;

  Menu(
      {this.name,
      this.path,
      this.redirect,
      this.component,
      this.alwaysShow,
      this.meta,
      this.children});

  Menu.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    path = json['path'];
    redirect = json['redirect'];
    component = json['component'];
    alwaysShow = json['alwaysShow'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['children'] != null) {
      children = new List<Children>();
      json['children'].forEach((v) {
        children.add(new Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['path'] = this.path;
    data['redirect'] = this.redirect;
    data['component'] = this.component;
    data['alwaysShow'] = this.alwaysShow;
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
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

class Children {
  String name;
  String path;
  String component;
  Meta meta;

  Children({this.name, this.path, this.component, this.meta});

  Children.fromJson(Map<String, dynamic> json) {
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
