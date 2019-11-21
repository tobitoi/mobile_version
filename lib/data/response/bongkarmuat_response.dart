class BongkarMuatResponse {
  int status02;
  int status03;
  int status05;
  int status09;
  int status10;
  int status50;
  int status51;
  int status55;
  int status56;

  BongkarMuatResponse({
    this.status02,
    this.status03,
    this.status05,
    this.status09,
    this.status10,
    this.status50,
    this.status51,
    this.status55,
    this.status56,
  });

  BongkarMuatResponse.fromJson(Map<String, dynamic> json) {
    status02 = json['status02'];
    status03 = json['status03'];
    status05 = json['status05'];
    status09 = json['status09'];
    status10 = json['status10'];
    status50 = json['status50'];
    status51 = json['status51'];
    status55 = json['status55'];
    status56 = json['status56'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status02'] = this.status02;
    data['status03'] = this.status03;
    data['status05'] = this.status05;
    data['status09'] = this.status09;
    data['status10'] = this.status10;
    data['status50'] = this.status50;
    data['status51'] = this.status51;
    data['status55'] = this.status55;
    data['status56'] = this.status56;
    return data;
  }
}
