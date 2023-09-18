class LeaveModel {
  int? id;
  int? staffId;
  String? staffName;
  String? leaveFrom;
  String? leaveTo;
  String? joiningDate;
  String? reason;
  bool? isApproved;
  bool? isAnnualLeave;
  int? approvedBy;
  String? approvedOn;
  bool? isActive;
  String? submitBy;
  String? submitOn;
  String? note;
  String? attachmentUrl;

  LeaveModel({this.id,
    this.staffId,
    this.staffName,
    this.leaveFrom,
    this.leaveTo,
    this.joiningDate,
    this.reason,
    this.isApproved,
    this.isAnnualLeave,
    this.approvedBy,
    this.approvedOn,
    this.isActive,
    this.submitBy,
    this.submitOn,this.note,this.attachmentUrl});

  LeaveModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffId = json['staffId'];
    staffName = json['staffName'];
    leaveFrom = json['leaveFrom'];
    leaveTo = json['leaveTo'];
    joiningDate = json['joiningDate'];
    reason = json['reason'];
    isApproved = json['isApproved'];
    isAnnualLeave = json['isAnnualLeave'];
    approvedBy = json['approvedBy'];
    approvedOn = json['approvedOn'];
    isActive = json['isActive'];
    submitBy = json['submitBy'];
    submitOn = json['submitOn'];
    note = json['note'];
    attachmentUrl = json['attachmentUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['staffId'] = this.staffId;
    data['staffName'] = this.staffName;
    data['leaveFrom'] = this.leaveFrom;
    data['leaveTo'] = this.leaveTo;
    data['joiningDate'] = this.joiningDate;
    data['reason'] = this.reason;
    data['isApproved'] = this.isApproved;
    data['isAnnualLeave'] = this.isAnnualLeave;
    data['approvedBy'] = this.approvedBy;
    data['approvedOn'] = this.approvedOn;
    data['isActive'] = this.isActive;
    data['submitBy'] = this.submitBy;
    data['submitOn'] = this.submitOn;
    data['note'] = this.note;
    data['attachmentUrl'] = this.attachmentUrl;
    return data;
  }
}