class UserModel {
  int? id;
  String? username;
  String? password;
  int? staffId;
  String? staffName;
  int? roleId;
  String? roleName;
  String? visaExpiry;
  String? token;
  bool? onLeave;
  bool? isActive;
  String? submitBy;
  String? submitOn;
  bool? isGuest;

  UserModel(
      {this.id,
      this.username,
      this.password,
      this.staffId,
      this.staffName,
      this.roleId = 420,
      this.roleName,
      this.visaExpiry,
      this.token,
      this.onLeave,
      this.isActive,
      this.submitBy,
      this.submitOn,
      this.isGuest = true});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    staffId = json['staffId'];
    staffName = json['staffName'];
    roleId = json['roleId'];
    roleName = json['roleName'];
    visaExpiry = json['visaExpiry'];
    token = json['token'];
    onLeave = json['onLeave'];
    isActive = json['isActive'];
    submitBy = json['submitBy'];
    submitOn = json['submitOn'];
    isGuest = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['staffId'] = this.staffId;
    data['staffName'] = this.staffName;
    data['roleId'] = this.roleId;
    data['roleName'] = this.roleName;
    data['visaExpiry'] = this.visaExpiry;
    data['token'] = this.token;
    data['onLeave'] = this.onLeave;
    data['isActive'] = this.isActive;
    data['submitBy'] = this.submitBy;
    data['submitOn'] = this.submitOn;
    return data;
  }
}
