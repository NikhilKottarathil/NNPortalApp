class StaffModel {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? address;
  String? email;
  String? joinedOn;
  String? contactNo;
  String? visaExpiry;
  bool? isActive;
  int? submitBy;
  String? submitOn;

  String? name;
  String? description;
  bool? isDriver;
  bool? isLeader;

  StaffModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.phone,
      this.address,
      this.email,
      this.joinedOn,
      this.contactNo,
      this.visaExpiry,
      this.isActive,
      this.submitBy,
      this.name,
      this.submitOn,
      this.description,
      this.isDriver,
      this.isLeader});

  StaffModel.fromJson(Map<String, dynamic> json) {
    id = json['staffId'] ?? json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    address = json['address'];
    email = json['email'];
    joinedOn = json['joinedOn'];
    contactNo = json['contactNo'];
    visaExpiry = json['visaExpiry'];
    isActive = json['isActive'];
    submitBy = json['submitBy'];
    submitOn = json['submitOn'];
    description = json['description'];
    name = json['staffName'] ??
        '${json['firstName'] ?? "Unknown Staff"} ${json['lastName'] ?? ''}';
    isLeader = json['isTeamLeader'] ?? false;
    isDriver = json['isDriver'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['email'] = this.email;
    data['joinedOn'] = this.joinedOn;
    data['contactNo'] = this.contactNo;
    data['visaExpiry'] = this.visaExpiry;
    data['isActive'] = this.isActive;
    data['submitBy'] = this.submitBy;
    data['submitOn'] = this.submitOn;
    return data;
  }
}
