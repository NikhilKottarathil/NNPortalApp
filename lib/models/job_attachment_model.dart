class JobAttachmentModel {
  int? id;
  int? jobId;
  String? uploadFile;
  String? uploadUrl;
  String? staffName;
  int? staffId;
  String? uploadedOn;
  String? submitBy;
  String? submitOn;

  JobAttachmentModel(
      {this.id,
        this.jobId,
        this.uploadFile,
        this.uploadUrl,
        this.staffName,
        this.staffId,
        this.uploadedOn,
        this.submitBy,
        this.submitOn});

  JobAttachmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['jobId'];
    uploadFile = json['uploadFile'];
    uploadUrl = json['uploadUrl'];
    staffName = json['staffName'];
    staffId = json['staffId'];
    uploadedOn = json['uploadedOn'];
    submitBy = json['submitBy'];
    submitOn = json['submitOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jobId'] = this.jobId;
    data['uploadFile'] = this.uploadFile;
    data['uploadUrl'] = this.uploadUrl;
    data['staffName'] = this.staffName;
    data['staffId'] = this.staffId;
    data['uploadedOn'] = this.uploadedOn;
    data['submitBy'] = this.submitBy;
    data['submitOn'] = this.submitOn;
    return data;
  }
}