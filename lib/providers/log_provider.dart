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
import 'package:nn_portal/models/staff_log_model.dart';
import 'package:nn_portal/models/tool_model.dart';
import 'package:nn_portal/models/vehicle_log_model.dart';
import 'package:nn_portal/models/vehicle_model.dart';

import 'package:nn_portal/utils/http_api_calls.dart';
import 'package:nn_portal/utils/time_utils.dart';
import 'package:provider/provider.dart';

class LogProvider extends ChangeNotifier {
  DateTime selectedDate = DateTime.now();
  PageStatus pageStatus = PageStatus.initialState;

  List<LogModel> models = [];
  List<VehicleModel> vehicleModels = [];
  List<ToolModel> toolModels = [];
  List<JobModel> jobModels = [];

  changSelectedDate(DateTime dateTime) {
    selectedDate = dateTime;
    getLogs();
  }

  initLog() {
    getVehicleList();
    getToolList();
    // getJobList();
  }

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
        isShowLoader: false,
      );

      // print(response);
      for (var json in response['staffLogs']) {
        StaffLogModel contentModel = StaffLogModel.fromJson(json);
        DateTime checkInTime =
            DateFormat('yyyy-MM-dd HH:mm:ss').parse(contentModel.checkIn!);
        DateTime checkOutTime =
            DateFormat('yyyy-MM-dd HH:mm:ss').parse(contentModel.checkOut!);
        models.add(LogModel(
            staffLogModel: contentModel,
            checkIn: checkInTime,
            checkOut: checkOutTime,
            locationName: json['locationName'],
            clientName: json['clientName'],
            logType: LogType.workLog,
            isCompleted: true));
      }
      for (var json in response['vehicleLogs']) {
        VehicleLogModel contentModel = VehicleLogModel.fromJson(json);
        DateTime checkInTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').parse(contentModel.checkIn!);
        DateTime checkOutTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').parse(contentModel.checkOut!);
        models.add(LogModel(
            vehicleLogModel: contentModel,
            checkIn: checkInTime,
            checkOut: checkOutTime,
            locationName: json['locationName'],
            clientName: json['clientName'],
            logType: LogType.vehicleLog,
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

  Future<bool> addWorkLogs(
      {required TimeOfDay checkInTime, required TimeOfDay checkOutTime}) async {
    pageStatus = PageStatus.loading;
    notifyListeners();

    try {
      var format = DateFormat('yyyy-MM-dd HH:mm:ss');
      String checkInDateString = format.format(TimeUtils()
          .dateTimeFromTimeAndDate(checkInTime, dateTime: selectedDate));
      String checkOutDateString = format.format(TimeUtils()
          .dateTimeFromTimeAndDate(checkOutTime, dateTime: selectedDate));

      Map<String, dynamic> requestBody = {
        'jobId': 0,
        'checkIn': checkInDateString,
        'checkout': checkOutDateString,
        'isMain': true
      };
      var response = await postDataRequest(
          urlAddress: 'Staffs/PostStaffLog',
          requestBody: requestBody,
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

  Future<bool> updateWorkLogs(
      {required TimeOfDay checkInTime,
      required TimeOfDay checkOutTime,
      required LogModel logModel}) async {
    pageStatus = PageStatus.loading;
    notifyListeners();

    try {
      var format = DateFormat('yyyy-MM-dd HH:mm:ss');
      String checkInDateString = format.format(TimeUtils()
          .dateTimeFromTimeAndDate(checkInTime, dateTime: selectedDate));
      String checkOutDateString = format.format(TimeUtils()
          .dateTimeFromTimeAndDate(checkOutTime, dateTime: selectedDate));

      Map<String, dynamic> requestBody = {
        'jobId': 0,
        'checkIn': checkInDateString,
        'checkout': checkOutDateString,
        'isMain': true
      };
      var response = await postDataRequest(
          urlAddress: 'Staffs/PutStaffLog/${logModel.staffLogModel!.id}',
          requestBody: requestBody,
          method: 'put',
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

  Future<bool> addVehicleLogs(
      {required TimeOfDay checkInTime,
      required TimeOfDay checkOutTime,
      required String vehicleId,
      required String jobId}) async {
    pageStatus = PageStatus.loading;
    notifyListeners();

    try {
      var format = DateFormat('yyyy-MM-dd HH:mm:ss');
      String checkInDateString = format.format(TimeUtils()
          .dateTimeFromTimeAndDate(checkInTime, dateTime: selectedDate));
      String checkOutDateString = format.format(TimeUtils()
          .dateTimeFromTimeAndDate(checkOutTime, dateTime: selectedDate));

      Map<String, dynamic> requestBody = {
        'jobId': jobId,
        'vehicleId': vehicleId,
        'checkIn': checkInDateString,
        'checkout': checkOutDateString,
      };
      var response = await postDataRequest(
          urlAddress: 'Vehicles/PostVehicleLog',
          requestBody: requestBody,
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

  Future<bool> updateVehicleLogs(
      {required TimeOfDay checkInTime,
      required TimeOfDay checkOutTime,
      required String vehicleId,
      required String jobId,
      required LogModel logModel}) async {
    pageStatus = PageStatus.loading;
    notifyListeners();

    try {
      var format = DateFormat('yyyy-MM-dd HH:mm:ss');
      String checkInDateString = format.format(TimeUtils()
          .dateTimeFromTimeAndDate(checkInTime, dateTime: selectedDate));
      String checkOutDateString = format.format(TimeUtils()
          .dateTimeFromTimeAndDate(checkOutTime, dateTime: selectedDate));

      Map<String, dynamic> requestBody = {
        'jobId': jobId,
        'vehicleId': vehicleId,
        'checkIn': checkInDateString,
        'checkout': checkOutDateString,
      };
      var response = await postDataRequest(
          urlAddress: 'Vehicles/PutVehicleLog/${logModel.vehicleLogModel!.id}',
          requestBody: requestBody,
          method: 'put',
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

  Future getVehicleList() async {
    vehicleModels.clear();
    try {
      var response = await getDataRequest(
        urlAddress: 'Vehicles/GetdlVehicles',
        isShowLoader: false,
      );

      // print(response);
      for (var json in response) {
        vehicleModels.add(VehicleModel.fromJson(json));
      }

      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

  Future getToolList() async {
    toolModels.clear();
    try {
      var response = await getDataRequest(
        urlAddress: 'Tools/GetdlTools',
        isShowLoader: false,
      );

      // print(response);
      for (var json in response) {
        toolModels.add(ToolModel.fromJson(json));
      }

      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

  Future getJobList({String searchString = ''}) async {
    notifyListeners();

    try {
      var response = await postDataRequest(
          urlAddress: 'Jobs/GetStaffJobs',
          requestBody: {
            'filterText': searchString,
            'pageIndex': 0.toString(),
            'pageSize': 100.toString()
          },
          isShowLoader: false);
      for (var json in response['items']) {
        jobModels.add(JobModel.fromJson(json));
      }

      notifyListeners();
    } catch (e) {
      print(e);
      notifyListeners();
    }
  }
}
