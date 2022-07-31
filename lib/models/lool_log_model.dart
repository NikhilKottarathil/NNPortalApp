class ToolLogModel {
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
  int? toolId;
  String? toolName;
  String? checkIn;
  String? checkOut;
  int? submitBy;
  String? submitOn;

  ToolLogModel(
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
        this.toolId,
        this.toolName,
        this.checkIn,
        this.checkOut,
        this.submitBy,
        this.submitOn});

  ToolLogModel.fromJson(Map<String, dynamic> json) {
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
    toolId = json['toolId'];
    toolName = json['toolName'];
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
    data['toolId'] = this.toolId;
    data['toolName'] = this.toolName;
    data['checkIn'] = this.checkIn;
    data['checkOut'] = this.checkOut;
    data['submitBy'] = this.submitBy;
    data['submitOn'] = this.submitOn;
    return data;
  }
}