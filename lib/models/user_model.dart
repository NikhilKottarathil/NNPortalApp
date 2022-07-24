class UserModel {
  int? id;
  String? username;
  String? password;
  int? staffId;
  String? staffName;
  int? roleId;
  String? roleName;
  String? token;
  bool? isActive;
  String? submitBy;
  String? submitOn;

  UserModel(
      {this.id,
        this.username,
        this.password,
        this.staffId,
        this.staffName,
        this.roleId,
        this.roleName,
        this.token,
        this.isActive,
        this.submitBy,
        this.submitOn});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    staffId = json['staffId'];
    staffName = json['staffName'];
    roleId = json['roleId'];
    roleName = json['roleName'];
    token = json['token'];
    isActive = json['isActive'];
    submitBy = json['submitBy'];
    submitOn = json['submitOn'];
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
    data['token'] = this.token;
    data['isActive'] = this.isActive;
    data['submitBy'] = this.submitBy;
    data['submitOn'] = this.submitOn;
    return data;
  }
}