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
  String? locationName;
  String? clientName;

  LogModel(
      {required this.checkIn,
      this.checkOut,
      required this.logType,
      required this.isCompleted,
      this.staffLogModel,
      this.vehicleLogModel,
      this.clientName,
      this.locationName});
}
