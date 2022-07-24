class ToolModel {
  int? id;
  String? toolName;
  bool? isActive;
  String? submitBy;
  String? submitOn;

  ToolModel(
      {this.id, this.toolName, this.isActive, this.submitBy, this.submitOn});

  ToolModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    toolName = json['toolName'];
    isActive = json['isActive'];
    submitBy = json['submitBy'];
    submitOn = json['submitOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['toolName'] = this.toolName;
    data['isActive'] = this.isActive;
    data['submitBy'] = this.submitBy;
    data['submitOn'] = this.submitOn;
    return data;
  }
}