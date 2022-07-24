class JobModel {
  int? id;
  String? code;
  int? clientId;
  String? clientName;
  int? locationId;
  String? locationName;
  String? ticketNo;
  String? ticketCaller;
  String? ticketCreatedOn;
  String? description;
  String? openOn;
  bool? flag;
  String? status;
  String? closedOn;
  bool? isClosed;
  String? imageFile;
  String? imageUrl;
  String? comment;
  bool? prev;
  int? jobsCount;
  bool? isActive;
  String? submitBy;
  String? submitOn;
  // List<String>? jobDescriptions;
  // List<String>? jobAttachments;

  JobModel(
      {this.id,
        this.code,
        this.clientId,
        this.clientName,
        this.locationId,
        this.locationName,
        this.ticketNo,
        this.ticketCaller,
        this.ticketCreatedOn,
        this.description,
        this.openOn,
        this.flag,
        this.status,
        this.closedOn,
        this.isClosed,
        this.imageFile,
        this.imageUrl,
        this.comment,
        this.prev,
        this.jobsCount,
        this.isActive,
        this.submitBy,
        this.submitOn,
        // this.jobDescriptions,
        // this.jobAttachments,
      });

  JobModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    clientId = json['clientId'];
    clientName = json['clientName'];
    locationId = json['locationId'];
    locationName = json['locationName'];
    ticketNo = json['ticketNo'];
    ticketCaller = json['ticketCaller'];
    ticketCreatedOn = json['ticketCreatedOn'];
    description = json['description'];
    openOn = json['openOn'];
    flag = json['flag'];
    status = json['status'];
    closedOn = json['closedOn'];
    isClosed = json['isClosed'];
    imageFile = json['imageFile'];
    imageUrl = json['imageUrl'];
    comment = json['comment'];
    prev = json['prev'];
    jobsCount = json['jobsCount'];
    isActive = json['isActive'];
    submitBy = json['submitBy'];
    submitOn = json['submitOn'];
    // jobDescriptions = json['jobDescriptions'].cast<String>();
    // jobAttachments = json['jobAttachments'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['clientId'] = this.clientId;
    data['clientName'] = this.clientName;
    data['locationId'] = this.locationId;
    data['locationName'] = this.locationName;
    data['ticketNo'] = this.ticketNo;
    data['ticketCaller'] = this.ticketCaller;
    data['ticketCreatedOn'] = this.ticketCreatedOn;
    data['description'] = this.description;
    data['openOn'] = this.openOn;
    data['flag'] = this.flag;
    data['status'] = this.status;
    data['closedOn'] = this.closedOn;
    data['isClosed'] = this.isClosed;
    data['imageFile'] = this.imageFile;
    data['imageUrl'] = this.imageUrl;
    data['comment'] = this.comment;
    data['prev'] = this.prev;
    data['jobsCount'] = this.jobsCount;
    data['isActive'] = this.isActive;
    data['submitBy'] = this.submitBy;
    data['submitOn'] = this.submitOn;
    // data['jobDescriptions'] = this.jobDescriptions;
    // data['jobAttachments'] = this.jobAttachments;
    return data;
  }
}