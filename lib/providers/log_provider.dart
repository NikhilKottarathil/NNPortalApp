import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nn_portal/constants/enums.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/job_attachment_model.dart';
import 'package:nn_portal/models/job_description_model.dart';
import 'package:nn_portal/models/job_model.dart';
import 'package:nn_portal/models/log_model.dart';
import 'package:nn_portal/models/lool_log_model.dart';
import 'package:nn_portal/models/staff_log_model.dart';
import 'package:nn_portal/models/tool_model.dart';
import 'package:nn_portal/models/vehicle_log_model.dart';
import 'package:nn_portal/models/vehicle_model.dart';

import 'package:nn_portal/utils/http_api_calls.dart';
import 'package:nn_portal/utils/time_utils.dart';
import 'package:provider/provider.dart';

class LogProvider extends ChangeNotifier {
  static DateTime today = DateTime.now();
  DateTime selectedDate = DateTime.now();
  PageStatus pageStatus = PageStatus.initialState;
  List<JobModel> jobSuggestionModels = [];

  List<LogModel> models = [];

  List<JobModel> jobModels = [];
  DateTime yesterday =
      DateTime(today.year, today.month, today.day - 1, 0, 0, 0, 0, 0);

  bool isInTime = true;

  changSelectedDate(DateTime dateTime) {
    selectedDate = dateTime;
    isInTime = !selectedDate.difference(yesterday).isNegative;
    getLogs();
  }

  // initLog() {
  //   getVehicleList();
  //   getToolList();
  //   // getJobList();
  // }

  Future getLogs() async {
    pageStatus = PageStatus.loading;
    notifyListeners();

    models.clear();
    try {
      var response = await postDataRequest(
        requestBody: {
          "jobId": 0,
          "toolId": 0,
          "vehicleId": 0,
          "startdt": DateFormat('yyyy-MM-dd').format(selectedDate),
        },
        urlAddress: 'Staffs/GetStaffFullLogs',
        isShowLoader: true,
      );

      // print(response);
      for (var json in response['staffLogs']) {
        StaffLogModel contentModel = StaffLogModel.fromJson(json);
        DateTime checkInTime =
            DateFormat('yyyy-MM-dd HH:mm:ss').parse(contentModel.checkIn!);
        DateTime? checkOutTime;
        if (contentModel.checkOut != null) {
          checkOutTime =
              DateFormat('yyyy-MM-dd HH:mm:ss').parse(contentModel.checkOut!);
        }
        models.add(LogModel(
            logId: contentModel.id ?? 0,
            staffLogModel: contentModel,
            checkIn: checkInTime,
            checkOut: checkOutTime,
            locationName: json['locationName'],
            clientName: json['clientName'],
            logType: contentModel.isMain! ? LogType.workLog : LogType.siteLog,
            isCompleted: true));
      }
      for (var json in response['vehicleLogs']) {
        VehicleLogModel contentModel = VehicleLogModel.fromJson(json);
        DateTime checkInTime =
            DateFormat('yyyy-MM-dd HH:mm:ss').parse(contentModel.checkIn!);
        DateTime? checkOutTime;
        if (contentModel.checkOut != null) {
          checkOutTime =
              DateFormat('yyyy-MM-dd HH:mm:ss').parse(contentModel.checkOut!);
        }
        models.add(LogModel(
            logId: contentModel.id ?? 0,
            vehicleLogModel: contentModel,
            checkIn: checkInTime,
            checkOut: checkOutTime,
            locationName: json['locationName'],
            clientName: json['clientName'],
            logType: LogType.vehicleLog,
            isCompleted: true));
      }
      for (var json in response['toolLogs']) {
        ToolLogModel contentModel = ToolLogModel.fromJson(json);
        DateTime checkInTime =
            DateFormat('yyyy-MM-dd HH:mm:ss').parse(contentModel.checkIn!);
        DateTime? checkOutTime;
        if (contentModel.checkOut != null) {
          checkOutTime =
              DateFormat('yyyy-MM-dd HH:mm:ss').parse(contentModel.checkOut!);
        }

        models.add(LogModel(
            logId: contentModel.id ?? 0,
            toolLogModel: contentModel,
            checkIn: checkInTime,
            checkOut: checkOutTime,
            locationName: json['locationName'],
            clientName: json['clientName'],
            logType: LogType.toolLog,
            isCompleted: true));
      }

      pageStatus = PageStatus.loaded;
      notifyListeners();
    } catch (e) {
      print(e);
      pageStatus = PageStatus.failed;
      notifyListeners();
    }
  }

  Future<bool> addLog(
      {required LogType logType,
      required TimeOfDay checkInTime,
      TimeOfDay? checkOutTime,
      String? vehicleId,
      String? jobId,
      String? toolId,
      LogModel? logModel}) async {
    pageStatus = PageStatus.loading;
    notifyListeners();

    print('addLog $jobId');
    try {
      var format = DateFormat('yyyy-MM-dd HH:mm:ss');
      String checkInDateString = format.format(TimeUtils()
          .dateTimeFromTimeAndDate(checkInTime, dateTime: selectedDate));

      Map<String, dynamic> requestBody = {
        'jobId': 0,
        'checkIn': checkInDateString,
      };
      if (checkOutTime != null) {
        String checkOutDateString = format.format(TimeUtils()
            .dateTimeFromTimeAndDate(checkOutTime, dateTime: selectedDate));
        requestBody.addAll({
          'checkout': checkOutDateString,
        });
      } else {
        requestBody.addAll({'checkout': ''});
      }
      String apiUrl = 'Staffs/PostStaffLog';
      if (logType == LogType.workLog || logType == LogType.siteLog) {
        if (logType == LogType.workLog) {
          requestBody.addAll({'isMain': true});
        } else {
          requestBody.addAll({
            'jobId': jobId,
            'isMain': false,
          });
        }
        if (logModel == null) {
          apiUrl = 'Staffs/PostStaffLog';
        } else {
          apiUrl = 'Staffs/PutStaffLog/${logModel.staffLogModel!.id}';
        }
      }
      if (logType == LogType.vehicleLog) {
        requestBody.addAll({
          'jobId': jobId,
          'vehicleId': vehicleId,
        });
        if (logModel == null) {
          apiUrl = 'Vehicles/PostVehicleLog';
        } else {
          apiUrl = 'Vehicles/PutVehicleLog/${logModel.vehicleLogModel!.id}';
        }
      }
      if (logType == LogType.toolLog) {
        requestBody.addAll({
          'jobId': jobId,
          'toolId': toolId,
        });
        if (logModel == null) {
          apiUrl = 'Tools/PostToolLog';
        } else {
          apiUrl = 'Tools/PutToolLog/${logModel.toolLogModel!.id}';
        }
      }
      print('addLog 2');

      var response = await postDataRequest(
          urlAddress: apiUrl,
          requestBody: requestBody,
          method: logModel == null ? 'post' : 'put',
          isShowLoader: false);
      getLogs();

      pageStatus = PageStatus.loaded;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      pageStatus = PageStatus.failed;
      notifyListeners();
      return false;
    }
  }

  Future delete(LogModel logModel) async {
    String urlAddress = '';
    if (logModel.logType == LogType.workLog ||
        logModel.logType == LogType.siteLog) {
      urlAddress = 'Staffs/DeleteStaffLog/${logModel.staffLogModel!.id}';
    } else if (logModel.logType == LogType.vehicleLog) {
      urlAddress = 'Vehicles/DeleteVehicleLog/${logModel.vehicleLogModel!.id}';
    } else if (logModel.logType == LogType.toolLog) {
      urlAddress = 'Tools/DeleteToolLog/${logModel.toolLogModel!.id}';
    }
    try {
      var response =
          await deleteDataRequest(urlAddress: urlAddress, isShowLoader: true);

      models.remove(logModel);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future getJobSuggestions() async {
    try {
      jobSuggestionModels.clear();
      var response = await getDataRequest(
          urlAddress: 'Jobs/GetdlJobsforsitelog', isShowLoader: true);

      print('job suggectionCount ${response.length}');
      for (var json in response) {
        jobSuggestionModels.add(JobModel.fromJson(json));
      }
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
