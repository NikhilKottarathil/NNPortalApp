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
  bool? isActive;
  String? submitBy;
  String? submitOn;
  List<JobComments>? jobComments;
  List<JobAttachments>? jobAttachments;
  List<JobStaffs>? jobStaffs;
  List<JobVehicle>? jobVehicles;
  String? logs;

  //app side field
  String? assignedStaff;
  String? assignedVehicle;

  JobModel({
    this.id,
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
    this.isActive,
    this.submitBy,
    this.submitOn,
    this.jobComments,
    this.jobAttachments,
    this.jobStaffs,
    this.logs,
    this.jobVehicles,
    this.assignedStaff,
    this.assignedVehicle,
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
    isActive = json['isActive'];
    submitBy = json['submitBy'];
    submitOn = json['submitOn'];
    if (json['jobComments'] != null) {
      jobComments = <JobComments>[];
      json['jobComments'].forEach((v) {
        jobComments!.add(new JobComments.fromJson(v));
      });
    }
    if (json['jobAttachments'] != null) {
      jobAttachments = <JobAttachments>[];
      json['jobAttachments'].forEach((v) {
        jobAttachments!.add(new JobAttachments.fromJson(v));
      });
    }
    if (json['jobStaffs'] != null) {
      jobStaffs = <JobStaffs>[];
      json['jobStaffs'].forEach((v) {
        jobStaffs!.add(new JobStaffs.fromJson(v));
      });
    }
    if (json['jobVehicles'] != null) {
      jobVehicles = <JobVehicle>[];
      json['jobVehicles'].forEach((v) {
        jobVehicles!.add(new JobVehicle.fromJson(v));
      });
    }

    logs = json['logs'];
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
    data['isActive'] = this.isActive;
    data['submitBy'] = this.submitBy;
    data['submitOn'] = this.submitOn;
    if (this.jobComments != null) {
      data['jobComments'] = this.jobComments!.map((v) => v.toJson()).toList();
    }
    if (this.jobAttachments != null) {
      data['jobAttachments'] =
          this.jobAttachments!.map((v) => v.toJson()).toList();
    }
    if (this.jobStaffs != null) {
      data['jobStaffs'] = this.jobStaffs!.map((v) => v.toJson()).toList();
    }
    data['logs'] = this.logs;
    return data;
  }
}

class JobComments {
  int? id;
  int? jobId;
  int? staffId;
  String? staffName;
  String? comment;
  String? status;
  String? commentOn;
  bool? isActive;
  String? submitBy;
  String? submitOn;

  JobComments(
      {this.id,
      this.jobId,
      this.staffId,
      this.staffName,
      this.comment,
      this.status,
      this.commentOn,
      this.isActive,
      this.submitBy,
      this.submitOn});

  JobComments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['jobId'];
    staffId = json['staffId'];
    staffName = json['staffName'];
    comment = json['comment'];
    status = json['status'];
    commentOn = json['commentOn'];
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
    data['isActive'] = this.isActive;
    data['submitBy'] = this.submitBy;
    data['submitOn'] = this.submitOn;
    return data;
  }
}

class JobAttachments {
  int? id;
  int? jobId;
  String? uploadFile;
  String? uploadUrl;
  String? staffName;
  int? staffId;
  String? uploadedOn;
  String? submitBy;
  String? submitOn;

  JobAttachments(
      {this.id,
      this.jobId,
      this.uploadFile,
      this.uploadUrl,
      this.staffName,
      this.staffId,
      this.uploadedOn,
      this.submitBy,
      this.submitOn});

  JobAttachments.fromJson(Map<String, dynamic> json) {
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

class JobStaffs {
  int? jobId;
  int? staffId;
  String? staffName;
  int? teamId;
  String? teamName;
  String? description;
  bool? isTeamLeader;
  bool? isDriver;
  String? assignedOn;
  String? assignedBy;
  String? submitBy;
  String? submitOn;

  JobStaffs(
      {this.jobId,
      this.staffId,
      this.staffName,
      this.teamId,
      this.teamName,
      this.description,
      this.isTeamLeader,
      this.isDriver,
      this.assignedOn,
      this.assignedBy,
      this.submitBy,
      this.submitOn});

  JobStaffs.fromJson(Map<String, dynamic> json) {
    jobId = json['jobId'];
    staffId = json['staffId'];
    staffName = json['staffName'];
    teamId = json['teamId'];
    teamName = json['teamName'];
    description = json['description'];
    isTeamLeader = json['isTeamLeader'];
    isDriver = json['isDriver'];
    assignedOn = json['assignedOn'];
    assignedBy = json['assignedBy'];
    submitBy = json['submitBy'];
    submitOn = json['submitOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jobId'] = this.jobId;
    data['staffId'] = this.staffId;
    data['staffName'] = this.staffName;
    data['teamId'] = this.teamId;
    data['teamName'] = this.teamName;
    data['description'] = this.description;
    data['isTeamLeader'] = this.isTeamLeader;
    data['isDriver'] = this.isDriver;
    data['assignedOn'] = this.assignedOn;
    data['assignedBy'] = this.assignedBy;
    data['submitBy'] = this.submitBy;
    data['submitOn'] = this.submitOn;
    return data;
  }
}

class JobVehicle {
  int? id;
  int? jobId;
  int? vehicleId;
  String? vehicleName;
  int? teamId;
  String? teamName;
  int? staffId;
  String? staffName;
  Null? submitBy;
  Null? submitOn;

  JobVehicle(
      {this.id,
      this.jobId,
      this.vehicleId,
      this.vehicleName,
      this.teamId,
      this.teamName,
      this.staffId,
      this.staffName,
      this.submitBy,
      this.submitOn});

  JobVehicle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['jobId'];
    vehicleId = json['vehicleId'];
    vehicleName = json['vehicleName'];
    teamId = json['teamId'];
    teamName = json['teamName'];
    staffId = json['staffId'];
    staffName = json['staffName'];
    submitBy = json['submitBy'];
    submitOn = json['submitOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jobId'] = this.jobId;
    data['vehicleId'] = this.vehicleId;
    data['vehicleName'] = this.vehicleName;
    data['teamId'] = this.teamId;
    data['teamName'] = this.teamName;
    data['staffId'] = this.staffId;
    data['staffName'] = this.staffName;
    data['submitBy'] = this.submitBy;
    data['submitOn'] = this.submitOn;
    return data;
  }
}
