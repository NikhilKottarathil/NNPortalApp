class LeaveModel {
  int? id;
  int? staffId;
  String? staffName;
  String? leaveFrom;
  String? leaveTo;
  String? reason;
  bool? isApproved;
  int? approvedBy;
  String? approvedOn;
  bool? isActive;
  String? submitBy;
  String? submitOn;

  LeaveModel({this.id,
    this.staffId,
    this.staffName,
    this.leaveFrom,
    this.leaveTo,
    this.reason,
    this.isApproved,
    this.approvedBy,
    this.approvedOn,
    this.isActive,
    this.submitBy,
    this.submitOn});

  LeaveModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffId = json['staffId'];
    staffName = json['staffName'];
    leaveFrom = json['leaveFrom'];
    leaveTo = json['leaveTo'];
    reason = json['reason'];
    isApproved = json['isApproved'];
    approvedBy = json['approvedBy'];
    approvedOn = json['approvedOn'];
    isActive = json['isActive'];
    submitBy = json['submitBy'];
    submitOn = json['submitOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['staffId'] = this.staffId;
    data['staffName'] = this.staffName;
    data['leaveFrom'] = this.leaveFrom;
    data['leaveTo'] = this.leaveTo;
    data['reason'] = this.reason;
    data['isApproved'] = this.isApproved;
    data['approvedBy'] = this.approvedBy;
    data['approvedOn'] = this.approvedOn;
    data['isActive'] = this.isActive;
    data['submitBy'] = this.submitBy;
    data['submitOn'] = this.submitOn;
    return data;
  }
}