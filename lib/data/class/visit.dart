class Visit {
  int newVisits;
  int newIp;
  int recentVisits;
  int recentIp;

  Visit({this.newVisits, this.newIp, this.recentVisits, this.recentIp});

  Visit.fromJson(Map<String, dynamic> json) {
    newVisits = json['newVisits'];
    newIp = json['newIp'];
    recentVisits = json['recentVisits'];
    recentIp = json['recentIp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['newVisits'] = this.newVisits;
    data['newIp'] = this.newIp;
    data['recentVisits'] = this.recentVisits;
    data['recentIp'] = this.recentIp;
    return data;
  }
}
