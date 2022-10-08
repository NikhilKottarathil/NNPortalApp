class TeamModel {
  int? id;
  String? teamName;
  bool? isActive;
  int? siNo;

  TeamModel({this.id, this.teamName,this.siNo, this.isActive});

  TeamModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamName = json['teamName'];
    isActive = json['isActive']??false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['teamName'] = this.teamName;
    data['isActive'] = this.isActive;
    return data;
  }
}
