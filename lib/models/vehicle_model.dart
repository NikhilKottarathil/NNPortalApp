class VehicleModel {
  int? id;
  String? vehicleNo;
  bool? isActive;
  String? submitBy;
  String? submitOn;

  VehicleModel(
      {this.id, this.vehicleNo, this.isActive, this.submitBy, this.submitOn});

  VehicleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleNo = json['vehicleNo'];
    isActive = json['isActive'];
    submitBy = json['submitBy'];
    submitOn = json['submitOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vehicleNo'] = this.vehicleNo;
    data['isActive'] = this.isActive;
    data['submitBy'] = this.submitBy;
    data['submitOn'] = this.submitOn;
    return data;
  }
}