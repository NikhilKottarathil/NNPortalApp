import 'package:nn_portal/models/lool_log_model.dart';
import 'package:nn_portal/models/staff_log_model.dart';
import 'package:nn_portal/models/vehicle_log_model.dart';

enum LogType { workLog, siteLog, vehicleLog, toolLog }

class LogModel {
  DateTime checkIn;
  DateTime? checkOut;
  LogType logType;
  bool isCompleted;
  StaffLogModel? staffLogModel;
  VehicleLogModel? vehicleLogModel;
  ToolLogModel? toolLogModel;
  String? locationName;
  String? clientName;
  int logId;
  String?staffName;


  LogModel(
      {required this.checkIn,
      this.checkOut,
      required this.logType,
      required this.isCompleted,
      this.staffLogModel,
      this.vehicleLogModel,
        this.toolLogModel,
      this.clientName,
       required this.logId,
        this.staffName,
      this.locationName});
}
