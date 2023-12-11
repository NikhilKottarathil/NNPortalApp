class AlertModel {
  int? id;
  String? name;
  String? type;
  String? expiry;
  String? sortBy;

  AlertModel(
      {this.id, this.name, this.type, this.expiry, this.sortBy});

  AlertModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    expiry = json['expiry'];
    sortBy = json['sortBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['expiry'] = this.expiry;
    data['sortBy'] = this.sortBy;
    return data;
  }
}