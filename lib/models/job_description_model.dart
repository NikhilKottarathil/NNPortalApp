class JobDescriptionModel {
  int? id;
  int? jobId;
  int? staffId;
  String? staffName;
  String? description;
  String? imageFile;
  String? imageUrl;
  String? postedOn;
  bool? isActive;
  String? submitBy;
  String? submitOn;

  JobDescriptionModel(
      {this.id,
        this.jobId,
        this.staffId,
        this.staffName,
        this.description,
        this.imageFile,
        this.imageUrl,
        this.postedOn,
        this.isActive,
        this.submitBy,
        this.submitOn});

  JobDescriptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['jobId'];
    staffId = json['staffId'];
    staffName = json['staffName'];
    description = json['description'];
    imageFile = json['imageFile'];
    imageUrl = json['imageUrl'];
    postedOn = json['postedOn'];
    isActive = json['isActive'];
    submitBy = json['submitBy'];
    submitOn = json['submitOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['jobId'] = this.jobId;
    data['staffId'] = this.staffId;
    data['staffName'] = this.staffName;
    data['description'] = this.description;
    data['imageFile'] = this.imageFile;
    data['imageUrl'] = this.imageUrl;
    data['postedOn'] = this.postedOn;
    data['isActive'] = this.isActive;
    data['submitBy'] = this.submitBy;
    data['submitOn'] = this.submitOn;
    return data;
  }
}
