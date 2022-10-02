// class JobModel {
//   int? id;
//   String? code;
//   int? clientId;
//   String? clientName;
//   int? locationId;
//   String? locationName;
//   String? ticketNo;
//   String? ticketCaller;
//   String? ticketCreatedOn;
//   String? description;
//   String? openOn;
//   bool? flag;
//   String? status;
//   String? closedOn;
//   bool? isClosed;
//   String? imageFile;
//   String? imageUrl;
//   String? comment;
//   bool? prev;
//   String? assignedFor;
//   int? staffId;
//   String? staffName;
//   int? vehicleId;
//   String? vehicleNo;
//   int? toolId;
//   String? toolNo;
//   String? checkIn;
//   String? checkOut;
//   bool? isReOpen;
//   bool? isActive;
//   int? submitBy;
//   String? submitOn;
//   List<JobComments>? jobComments;
//   List<JobAttachments>? jobAttachments;
//   List<JobStaffs>? jobStaffs;
//   List<JobVehicles>? jobVehicles;
//   Logs? logs;
//
//   JobModel(
//       {this.id,
//         this.code,
//         this.clientId,
//         this.clientName,
//         this.locationId,
//         this.locationName,
//         this.ticketNo,
//         this.ticketCaller,
//         this.ticketCreatedOn,
//         this.description,
//         this.openOn,
//         this.flag,
//         this.status,
//         this.closedOn,
//         this.isClosed,
//         this.imageFile,
//         this.imageUrl,
//         this.comment,
//         this.prev,
//         this.assignedFor,
//         this.staffId,
//         this.staffName,
//         this.vehicleId,
//         this.vehicleNo,
//         this.toolId,
//         this.toolNo,
//         this.checkIn,
//         this.checkOut,
//         this.isReOpen,
//         this.isActive,
//         this.submitBy,
//         this.submitOn,
//         this.jobComments,
//         this.jobAttachments,
//         this.jobStaffs,
//         this.jobVehicles,
//         this.logs});
//
//   JobModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     code = json['code'];
//     clientId = json['clientId'];
//     clientName = json['clientName'];
//     locationId = json['locationId'];
//     locationName = json['locationName'];
//     ticketNo = json['ticketNo'];
//     ticketCaller = json['ticketCaller'];
//     ticketCreatedOn = json['ticketCreatedOn'];
//     description = json['description'];
//     openOn = json['openOn'];
//     flag = json['flag'];
//     status = json['status'];
//     closedOn = json['closedOn'];
//     isClosed = json['isClosed'];
//     imageFile = json['imageFile'];
//     imageUrl = json['imageUrl'];
//     comment = json['comment'];
//     prev = json['prev'];
//     assignedFor = json['assignedFor'];
//     staffId = json['staffId'];
//     staffName = json['staffName'];
//     vehicleId = json['vehicleId'];
//     vehicleNo = json['vehicleNo'];
//     toolId = json['toolId'];
//     toolNo = json['toolNo'];
//     checkIn = json['checkIn'];
//     checkOut = json['checkOut'];
//     isReOpen = json['isReOpen'];
//     isActive = json['isActive'];
//     submitBy = json['submitBy'];
//     submitOn = json['submitOn'];
//     if (json['jobComments'] != null) {
//       jobComments = <JobComments>[];
//       json['jobComments'].forEach((v) {
//         jobComments!.add(new JobComments.fromJson(v));
//       });
//     }
//     if (json['jobAttachments'] != null) {
//       jobAttachments = <JobAttachments>[];
//       json['jobAttachments'].forEach((v) {
//         jobAttachments!.add(new JobAttachments.fromJson(v));
//       });
//     }
//     if (json['jobStaffs'] != null) {
//       jobStaffs = <JobStaffs>[];
//       json['jobStaffs'].forEach((v) {
//         jobStaffs!.add(new JobStaffs.fromJson(v));
//       });
//     }
//     if (json['jobVehicles'] != null) {
//       jobVehicles = <JobVehicles>[];
//       json['jobVehicles'].forEach((v) {
//         jobVehicles!.add(new JobVehicles.fromJson(v));
//       });
//     }
//     logs = json['logs'] != null ? new Logs.fromJson(json['logs']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['code'] = this.code;
//     data['clientId'] = this.clientId;
//     data['clientName'] = this.clientName;
//     data['locationId'] = this.locationId;
//     data['locationName'] = this.locationName;
//     data['ticketNo'] = this.ticketNo;
//     data['ticketCaller'] = this.ticketCaller;
//     data['ticketCreatedOn'] = this.ticketCreatedOn;
//     data['description'] = this.description;
//     data['openOn'] = this.openOn;
//     data['flag'] = this.flag;
//     data['status'] = this.status;
//     data['closedOn'] = this.closedOn;
//     data['isClosed'] = this.isClosed;
//     data['imageFile'] = this.imageFile;
//     data['imageUrl'] = this.imageUrl;
//     data['comment'] = this.comment;
//     data['prev'] = this.prev;
//     data['assignedFor'] = this.assignedFor;
//     data['staffId'] = this.staffId;
//     data['staffName'] = this.staffName;
//     data['vehicleId'] = this.vehicleId;
//     data['vehicleNo'] = this.vehicleNo;
//     data['toolId'] = this.toolId;
//     data['toolNo'] = this.toolNo;
//     data['checkIn'] = this.checkIn;
//     data['checkOut'] = this.checkOut;
//     data['isReOpen'] = this.isReOpen;
//     data['isActive'] = this.isActive;
//     data['submitBy'] = this.submitBy;
//     data['submitOn'] = this.submitOn;
//     if (this.jobComments != null) {
//       data['jobComments'] = this.jobComments!.map((v) => v.toJson()).toList();
//     }
//     if (this.jobAttachments != null) {
//       data['jobAttachments'] =
//           this.jobAttachments!.map((v) => v.toJson()).toList();
//     }
//     if (this.jobStaffs != null) {
//       data['jobStaffs'] = this.jobStaffs!.map((v) => v.toJson()).toList();
//     }
//     if (this.jobVehicles != null) {
//       data['jobVehicles'] = this.jobVehicles!.map((v) => v.toJson()).toList();
//     }
//     if (this.logs != null) {
//       data['logs'] = this.logs!.toJson();
//     }
//     return data;
//   }
// }
//
// class JobComments {
//   int? id;
//   int? jobId;
//   int? staffId;
//   String? staffName;
//   String? comment;
//   String? status;
//   String? commentOn;
//   bool? isActive;
//   int? submitBy;
//   String? submitOn;
//
//   JobComments(
//       {this.id,
//         this.jobId,
//         this.staffId,
//         this.staffName,
//         this.comment,
//         this.status,
//         this.commentOn,
//         this.isActive,
//         this.submitBy,
//         this.submitOn});
//
//   JobComments.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     jobId = json['jobId'];
//     staffId = json['staffId'];
//     staffName = json['staffName'];
//     comment = json['comment'];
//     status = json['status'];
//     commentOn = json['commentOn'];
//     isActive = json['isActive'];
//     submitBy = json['submitBy'];
//     submitOn = json['submitOn'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['jobId'] = this.jobId;
//     data['staffId'] = this.staffId;
//     data['staffName'] = this.staffName;
//     data['comment'] = this.comment;
//     data['status'] = this.status;
//     data['commentOn'] = this.commentOn;
//     data['isActive'] = this.isActive;
//     data['submitBy'] = this.submitBy;
//     data['submitOn'] = this.submitOn;
//     return data;
//   }
// }
//
// class JobAttachments {
//   int? id;
//   int? jobId;
//   String? uploadFile;
//   String? uploadUrl;
//   String? staffName;
//   int? staffId;
//   String? uploadedOn;
//   int? submitBy;
//   String? submitOn;
//
//   JobAttachments(
//       {this.id,
//         this.jobId,
//         this.uploadFile,
//         this.uploadUrl,
//         this.staffName,
//         this.staffId,
//         this.uploadedOn,
//         this.submitBy,
//         this.submitOn});
//
//   JobAttachments.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     jobId = json['jobId'];
//     uploadFile = json['uploadFile'];
//     uploadUrl = json['uploadUrl'];
//     staffName = json['staffName'];
//     staffId = json['staffId'];
//     uploadedOn = json['uploadedOn'];
//     submitBy = json['submitBy'];
//     submitOn = json['submitOn'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['jobId'] = this.jobId;
//     data['uploadFile'] = this.uploadFile;
//     data['uploadUrl'] = this.uploadUrl;
//     data['staffName'] = this.staffName;
//     data['staffId'] = this.staffId;
//     data['uploadedOn'] = this.uploadedOn;
//     data['submitBy'] = this.submitBy;
//     data['submitOn'] = this.submitOn;
//     return data;
//   }
// }
//
// class JobStaffs {
//   int? id;
//   int? jobId;
//   int? staffId;
//   String? staffName;
//   int? teamId;
//   String? teamName;
//   String? description;
//   bool? isTeamLeader;
//   bool? isDriver;
//   String? assignedFor;
//   String? assignedBy;
//   int? submitBy;
//   String? submitOn;
//
//   JobStaffs(
//       {this.id,
//         this.jobId,
//         this.staffId,
//         this.staffName,
//         this.teamId,
//         this.teamName,
//         this.description,
//         this.isTeamLeader,
//         this.isDriver,
//         this.assignedFor,
//         this.assignedBy,
//         this.submitBy,
//         this.submitOn,
//      });
//
//   JobStaffs.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     jobId = json['jobId'];
//     staffId = json['staffId'];
//     staffName = json['staffName'];
//     teamId = json['teamId'];
//     teamName = json['teamName'];
//     description = json['description'];
//     isTeamLeader = json['isTeamLeader'];
//     isDriver = json['isDriver'];
//     assignedFor = json['assignedFor'];
//     assignedBy = json['assignedBy'];
//     submitBy = json['submitBy'];
//     submitOn = json['submitOn'];
//
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['jobId'] = this.jobId;
//     data['staffId'] = this.staffId;
//     data['staffName'] = this.staffName;
//     data['teamId'] = this.teamId;
//     data['teamName'] = this.teamName;
//     data['description'] = this.description;
//     data['isTeamLeader'] = this.isTeamLeader;
//     data['isDriver'] = this.isDriver;
//     data['assignedFor'] = this.assignedFor;
//     data['assignedBy'] = this.assignedBy;
//     data['submitBy'] = this.submitBy;
//     data['submitOn'] = this.submitOn;
//
//     return data;
//   }
// }
//
//
//
// class JobVehicles {
//   int? id;
//   int? jobId;
//   int? vehicleId;
//   String? vehicleName;
//   int? teamId;
//   String? teamName;
//   int? staffId;
//   String? staffName;
//   String? assignedFor;
//   String? assignedBy;
//   int? submitBy;
//   String? submitOn;
//
//   JobVehicles(
//       {this.id,
//         this.jobId,
//         this.vehicleId,
//         this.vehicleName,
//         this.teamId,
//         this.teamName,
//         this.staffId,
//         this.staffName,
//         this.assignedFor,
//         this.assignedBy,
//         this.submitBy,
//         this.submitOn});
//
//   JobVehicles.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     jobId = json['jobId'];
//     vehicleId = json['vehicleId'];
//     vehicleName = json['vehicleName'];
//     teamId = json['teamId'];
//     teamName = json['teamName'];
//     staffId = json['staffId'];
//     staffName = json['staffName'];
//     assignedFor = json['assignedFor'];
//     assignedBy = json['assignedBy'];
//     submitBy = json['submitBy'];
//     submitOn = json['submitOn'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['jobId'] = this.jobId;
//     data['vehicleId'] = this.vehicleId;
//     data['vehicleName'] = this.vehicleName;
//     data['teamId'] = this.teamId;
//     data['teamName'] = this.teamName;
//     data['staffId'] = this.staffId;
//     data['staffName'] = this.staffName;
//     data['assignedFor'] = this.assignedFor;
//     data['assignedBy'] = this.assignedBy;
//     data['submitBy'] = this.submitBy;
//     data['submitOn'] = this.submitOn;
//     return data;
//   }
// }
//
// class Logs {
//   List<StaffLogs>? staffLogs;
//   List<VehicleLogs>? vehicleLogs;
//   List<ToolLogs>? toolLogs;
//
//   Logs({this.staffLogs, this.vehicleLogs, this.toolLogs});
//
//   Logs.fromJson(Map<String, dynamic> json) {
//     if (json['staffLogs'] != null) {
//       staffLogs = <StaffLogs>[];
//       json['staffLogs'].forEach((v) {
//         staffLogs!.add(new StaffLogs.fromJson(v));
//       });
//     }
//     if (json['vehicleLogs'] != null) {
//       vehicleLogs = <VehicleLogs>[];
//       json['vehicleLogs'].forEach((v) {
//         vehicleLogs!.add(new VehicleLogs.fromJson(v));
//       });
//     }
//     if (json['toolLogs'] != null) {
//       toolLogs = <ToolLogs>[];
//       json['toolLogs'].forEach((v) {
//         toolLogs!.add(new ToolLogs.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.staffLogs != null) {
//       data['staffLogs'] = this.staffLogs!.map((v) => v.toJson()).toList();
//     }
//     if (this.vehicleLogs != null) {
//       data['vehicleLogs'] = this.vehicleLogs!.map((v) => v.toJson()).toList();
//     }
//     if (this.toolLogs != null) {
//       data['toolLogs'] = this.toolLogs!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class StaffLogs {
//   int? id;
//   int? jobId;
//   String? jobCode;
//   String? clientName;
//   String? locationName;
//   String? ticketNo;
//   String? ticketCaller;
//   String? ticketCreatedOn;
//   int? staffId;
//   String? staffName;
//   String? checkIn;
//   String? checkOut;
//   String? totalHours;
//   bool? isMain;
//   bool? isApproved;
//   int? approvedBy;
//   String? approvedOn;
//   int? submitBy;
//   String? submitOn;
//
//   StaffLogs(
//       {this.id,
//         this.jobId,
//         this.jobCode,
//         this.clientName,
//         this.locationName,
//         this.ticketNo,
//         this.ticketCaller,
//         this.ticketCreatedOn,
//         this.staffId,
//         this.staffName,
//         this.checkIn,
//         this.checkOut,
//         this.totalHours,
//         this.isMain,
//         this.isApproved,
//         this.approvedBy,
//         this.approvedOn,
//         this.submitBy,
//         this.submitOn});
//
//   StaffLogs.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     jobId = json['jobId'];
//     jobCode = json['jobCode'];
//     clientName = json['clientName'];
//     locationName = json['locationName'];
//     ticketNo = json['ticketNo'];
//     ticketCaller = json['ticketCaller'];
//     ticketCreatedOn = json['ticketCreatedOn'];
//     staffId = json['staffId'];
//     staffName = json['staffName'];
//     checkIn = json['checkIn'];
//     checkOut = json['checkOut'];
//     totalHours = json['totalHours'];
//     isMain = json['isMain'];
//     isApproved = json['isApproved'];
//     approvedBy = json['approvedBy'];
//     approvedOn = json['approvedOn'];
//     submitBy = json['submitBy'];
//     submitOn = json['submitOn'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['jobId'] = this.jobId;
//     data['jobCode'] = this.jobCode;
//     data['clientName'] = this.clientName;
//     data['locationName'] = this.locationName;
//     data['ticketNo'] = this.ticketNo;
//     data['ticketCaller'] = this.ticketCaller;
//     data['ticketCreatedOn'] = this.ticketCreatedOn;
//     data['staffId'] = this.staffId;
//     data['staffName'] = this.staffName;
//     data['checkIn'] = this.checkIn;
//     data['checkOut'] = this.checkOut;
//     data['totalHours'] = this.totalHours;
//     data['isMain'] = this.isMain;
//     data['isApproved'] = this.isApproved;
//     data['approvedBy'] = this.approvedBy;
//     data['approvedOn'] = this.approvedOn;
//     data['submitBy'] = this.submitBy;
//     data['submitOn'] = this.submitOn;
//     return data;
//   }
// }
//
// class VehicleLogs {
//   int? id;
//   int? jobId;
//   String? jobCode;
//   String? clientName;
//   String? locationName;
//   String? ticketNo;
//   String? ticketCaller;
//   String? ticketCreatedOn;
//   int? staffId;
//   String? staffName;
//   int? vehicleId;
//   String? vehicleNo;
//   String? checkIn;
//   String? checkOut;
//   int? submitBy;
//   String? submitOn;
//
//   VehicleLogs(
//       {this.id,
//         this.jobId,
//         this.jobCode,
//         this.clientName,
//         this.locationName,
//         this.ticketNo,
//         this.ticketCaller,
//         this.ticketCreatedOn,
//         this.staffId,
//         this.staffName,
//         this.vehicleId,
//         this.vehicleNo,
//         this.checkIn,
//         this.checkOut,
//         this.submitBy,
//         this.submitOn});
//
//   VehicleLogs.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     jobId = json['jobId'];
//     jobCode = json['jobCode'];
//     clientName = json['clientName'];
//     locationName = json['locationName'];
//     ticketNo = json['ticketNo'];
//     ticketCaller = json['ticketCaller'];
//     ticketCreatedOn = json['ticketCreatedOn'];
//     staffId = json['staffId'];
//     staffName = json['staffName'];
//     vehicleId = json['vehicleId'];
//     vehicleNo = json['vehicleNo'];
//     checkIn = json['checkIn'];
//     checkOut = json['checkOut'];
//     submitBy = json['submitBy'];
//     submitOn = json['submitOn'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['jobId'] = this.jobId;
//     data['jobCode'] = this.jobCode;
//     data['clientName'] = this.clientName;
//     data['locationName'] = this.locationName;
//     data['ticketNo'] = this.ticketNo;
//     data['ticketCaller'] = this.ticketCaller;
//     data['ticketCreatedOn'] = this.ticketCreatedOn;
//     data['staffId'] = this.staffId;
//     data['staffName'] = this.staffName;
//     data['vehicleId'] = this.vehicleId;
//     data['vehicleNo'] = this.vehicleNo;
//     data['checkIn'] = this.checkIn;
//     data['checkOut'] = this.checkOut;
//     data['submitBy'] = this.submitBy;
//     data['submitOn'] = this.submitOn;
//     return data;
//   }
// }
//
// class ToolLogs {
//   int? id;
//   int? jobId;
//   String? jobCode;
//   String? clientName;
//   String? locationName;
//   String? ticketNo;
//   String? ticketCaller;
//   String? ticketCreatedOn;
//   int? staffId;
//   String? staffName;
//   int? toolId;
//   String? toolName;
//   String? checkIn;
//   String? checkOut;
//   int? submitBy;
//   String? submitOn;
//
//   ToolLogs(
//       {this.id,
//         this.jobId,
//         this.jobCode,
//         this.clientName,
//         this.locationName,
//         this.ticketNo,
//         this.ticketCaller,
//         this.ticketCreatedOn,
//         this.staffId,
//         this.staffName,
//         this.toolId,
//         this.toolName,
//         this.checkIn,
//         this.checkOut,
//         this.submitBy,
//         this.submitOn});
//
//   ToolLogs.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     jobId = json['jobId'];
//     jobCode = json['jobCode'];
//     clientName = json['clientName'];
//     locationName = json['locationName'];
//     ticketNo = json['ticketNo'];
//     ticketCaller = json['ticketCaller'];
//     ticketCreatedOn = json['ticketCreatedOn'];
//     staffId = json['staffId'];
//     staffName = json['staffName'];
//     toolId = json['toolId'];
//     toolName = json['toolName'];
//     checkIn = json['checkIn'];
//     checkOut = json['checkOut'];
//     submitBy = json['submitBy'];
//     submitOn = json['submitOn'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['jobId'] = this.jobId;
//     data['jobCode'] = this.jobCode;
//     data['clientName'] = this.clientName;
//     data['locationName'] = this.locationName;
//     data['ticketNo'] = this.ticketNo;
//     data['ticketCaller'] = this.ticketCaller;
//     data['ticketCreatedOn'] = this.ticketCreatedOn;
//     data['staffId'] = this.staffId;
//     data['staffName'] = this.staffName;
//     data['toolId'] = this.toolId;
//     data['toolName'] = this.toolName;
//     data['checkIn'] = this.checkIn;
//     data['checkOut'] = this.checkOut;
//     data['submitBy'] = this.submitBy;
//     data['submitOn'] = this.submitOn;
//     return data;
//   }
// }
