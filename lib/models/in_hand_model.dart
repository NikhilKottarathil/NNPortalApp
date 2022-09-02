// enum Type { work, site, vehicle, tool }
//
// class InHandModel {
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
//   int? submitBy;
//   String? submitOn;
//
//   int? vehicleId;
//   String? vehicleNo;
//   int? toolId;
//   String? toolName;
//
//   DateTime?  checkInTime;
//   Type? type;
//   InHandModel(
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
//         this.submitBy,
//         this.submitOn,
//         this.checkInTime,
//
//
//          this.type,
//         this.vehicleId,
//         this.vehicleNo,
//         this.toolId,
//         this.toolName,
//       });
//
//   InHandModel.fromJson(Map<String, dynamic> json) {
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
//     submitBy = json['submitBy'];
//     submitOn = json['submitOn'];
//
//     toolId = json['toolId'];
//     toolName = json['toolName'];
//     vehicleId = json['vehicleId'];
//     vehicleNo = json['vehicleNo'];
//   }
//
// }
