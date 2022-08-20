class InHandVehicleModel {
  int? id;
  int? jobId;
  String? jobCode;
  String? clientName;
  String? locationName;
  String? ticketNo;
  String? ticketCaller;
  String? ticketCreatedOn;
  int? staffId;
  String? staffName;
  int? vehicleId;
  String? vehicleNo;
  String? checkIn;
  Null? checkOut;
  int? submitBy;
  String? submitOn;

  InHandVehicleModel(
      {this.id,
        this.jobId,
        this.jobCode,
        this.clientName,
        this.locationName,
        this.ticketNo,
        this.ticketCaller,
        this.ticketCreatedOn,
        this.staffId,
        this.staffName,
        this.vehicleId,
        this.vehicleNo,
        this.checkIn,
        this.checkOut,
        this.submitBy,
        this.submitOn});

  InHandVehicleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['jobId'];
    jobCode = json['jobCode'];
    clientName = json['clientName'];
    locationName = json['locationName'];
    ticketNo = json['ticketNo'];
    ticketCaller = json['ticketCaller'];
    ticketCreatedOn = json['ticketCreatedOn'];
    staffId = json['staffId'];
    staffName = json['staffName'];
    vehicleId = json['vehicleId'];
    vehicleNo = json['vehicleNo'];
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
    submitBy = json['submitBy'];
    submitOn = json['submitOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jobId'] = this.jobId;
    data['jobCode'] = this.jobCode;
    data['clientName'] = this.clientName;
    data['locationName'] = this.locationName;
    data['ticketNo'] = this.ticketNo;
    data['ticketCaller'] = this.ticketCaller;
    data['ticketCreatedOn'] = this.ticketCreatedOn;
    data['staffId'] = this.staffId;
    data['staffName'] = this.staffName;
    data['vehicleId'] = this.vehicleId;
    data['vehicleNo'] = this.vehicleNo;
    data['checkIn'] = this.checkIn;
    data['checkOut'] = this.checkOut;
    data['submitBy'] = this.submitBy;
    data['submitOn'] = this.submitOn;
    return data;
  }
}
