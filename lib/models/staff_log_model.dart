class StaffLogModel {
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
  String? checkIn;
  String? checkOut;
  bool? isMain;
  int? submitBy;
  String? submitOn;
  String? comment;
  bool? isDailyLog;

  StaffLogModel(
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
        this.checkIn,
        this.checkOut,
        this.isMain,
        this.submitBy,
        this.submitOn,this.comment,this.isDailyLog});

  StaffLogModel.fromJson(Map<String, dynamic> json) {
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
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
    isMain = json['isMain'];
    submitBy = json['submitBy'];
    submitOn = json['submitOn'];
    comment = json['comment']??'';
    isDailyLog = json['isDailyLog']??false;
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
    data['checkIn'] = this.checkIn;
    data['checkOut'] = this.checkOut;
    data['isMain'] = this.isMain;
    data['submitBy'] = this.submitBy;
    data['submitOn'] = this.submitOn;
    data['comment'] = this.comment;
    data['isDailyLog'] = this.isDailyLog;
    return data;
  }
}