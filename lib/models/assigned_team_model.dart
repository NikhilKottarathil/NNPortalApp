class AssignedTeamModel {
  int? id;
  int? jobId;
  int? staffId;
  String? staffName;
  int? teamId;
  String? teamName;
  String? description;
  bool? isTeamLeader;
  bool? isDriver;
  String? assignedFor;
  String? assignedBy;
  int? submitBy;
  String? submitOn;
  String? vehicleName;
  List<JobTeamVehicles>? jobVehicles;
  String? vehicles;

  AssignedTeamModel(
      {this.id,
        this.jobId,
        this.staffId,
        this.staffName,
        this.teamId,
        this.teamName,
        this.description,
        this.isTeamLeader,
        this.isDriver,
        this.assignedFor,
        this.assignedBy,
        this.submitBy,
        this.submitOn,
        this.vehicles,
        this.vehicleName,
        this.jobVehicles});

  AssignedTeamModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['jobId'];
    staffId = json['staffId'];
    staffName = json['staffName'];
    teamId = json['teamId'];
    teamName = json['teamName'];
    description = json['description'];
    isTeamLeader = json['isTeamLeader'];
    isDriver = json['isDriver'];
    assignedFor = json['assignedFor'];
    assignedBy = json['assignedBy'];
    submitBy = json['submitBy'];
    submitOn = json['submitOn'];
    vehicleName = json['vehicleName'];
    if (json['jobVehicles'] != null) {
      jobVehicles = <JobTeamVehicles>[];
      vehicles='';
      json['jobVehicles'].forEach((v) {
        JobTeamVehicles teamVehicles= JobTeamVehicles.fromJson(v);
        jobVehicles!.add(teamVehicles);
        vehicles=vehicles!.isEmpty?teamVehicles.vehicleName??'':'$jobVehicles, ${teamVehicles.vehicleName??''}';
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jobId'] = this.jobId;
    data['staffId'] = this.staffId;
    data['staffName'] = this.staffName;
    data['teamId'] = this.teamId;
    data['teamName'] = this.teamName;
    data['description'] = this.description;
    data['isTeamLeader'] = this.isTeamLeader;
    data['isDriver'] = this.isDriver;
    data['assignedFor'] = this.assignedFor;
    data['assignedBy'] = this.assignedBy;
    data['submitBy'] = this.submitBy;
    data['submitOn'] = this.submitOn;
    if (this.jobVehicles != null) {
      data['jobVehicles'] = this.jobVehicles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobTeamVehicles {
  int? id;
  int? vehicleId;
  String? vehicleName;

  JobTeamVehicles({this.id, this.vehicleId, this.vehicleName});

  JobTeamVehicles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleId = json['vehicleId'];
    vehicleName = json['vehicleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vehicleId'] = this.vehicleId;
    data['vehicleName'] = this.vehicleName;
    return data;
  }
}
