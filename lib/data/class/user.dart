class User {
  String username;
  String avatar;
  String email;
  String phone;
  String dept;
  String job;
  bool enabled;
  int createTime;
  List<String> roles;

  User(
      {this.username,
      this.avatar,
      this.email,
      this.phone,
      this.dept,
      this.job,
      this.enabled,
      this.createTime,
      this.roles});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    avatar = json['avatar'];
    email = json['email'];
    phone = json['phone'];
    dept = json['dept'];
    job = json['job'];
    enabled = json['enabled'];
    createTime = json['createTime'];
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['dept'] = this.dept;
    data['job'] = this.job;
    data['enabled'] = this.enabled;
    data['createTime'] = this.createTime;
    data['roles'] = this.roles;
    return data;
  }
}
