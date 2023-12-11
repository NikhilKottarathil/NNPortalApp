class JobDescriptionModel {
  int? id;
  int? jobId;
  int? staffId;
  String? staffName;
  String? comment;
  String? status;
  String? commentOn;
  String? adminComment;
  bool? isActive;
  Null? submitBy;
  Null? submitOn;

  JobDescriptionModel(
      {this.id,
        this.jobId,
        this.staffId,
        this.staffName,
        this.comment,
        this.status,
        this.commentOn,
        this.adminComment,
        this.isActive,
        this.submitBy,
        this.submitOn});

  JobDescriptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['jobId'];
    staffId = json['staffId'];
    staffName = json['staffName'];
    comment = json['comment'];
    status = json['status'];
    commentOn = json['commentOn'];
    adminComment = json['adminComment'];
    isActive = json['isActive'];
    submitBy = json['submitBy'];
    submitOn = json['submitOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jobId'] = this.jobId;
    data['staffId'] = this.staffId;
    data['staffName'] = this.staffName;
    data['comment'] = this.comment;
    data['status'] = this.status;
    data['commentOn'] = this.commentOn;
    data['adminComment'] = this.adminComment;
    data['isActive'] = this.isActive;
    data['submitBy'] = this.submitBy;
    data['submitOn'] = this.submitOn;
    return data;
  }
}