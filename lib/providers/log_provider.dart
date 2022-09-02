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
        isShowLoader: true,
      );

      // print(response);
      for (var json in response['staffLogs']) {
        StaffLogModel contentModel = StaffLogModel.fromJson(json);
        DateTime checkInTime =
            DateFormat('yyyy-MM-dd HH:mm:ss').parse(contentModel.checkIn!);
        DateTime?  checkOutTime ;
        if(contentModel.checkOut!=null) {
          checkOutTime =
              DateFormat('yyyy-MM-dd HH:mm:ss').parse(contentModel.checkOut!);
        }
        models.add(LogModel(
            staffLogModel: contentModel,
            checkIn: checkInTime,
            checkOut: checkOutTime,
            locationName: json['locationName'],
            clientName: json['clientName'],
            logType: contentModel.isMain!?LogType.workLog:LogType.siteLog,
            isCompleted: true));
      }
      for (var json in response['vehicleLogs']) {
        VehicleLogModel contentModel = VehicleLogModel.fromJson(json);
        DateTime checkInTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').parse(contentModel.checkIn!);
        DateTime?  checkOutTime ;
        if(contentModel.checkOut!=null) {
          checkOutTime =
              DateFormat('yyyy-MM-dd HH:mm:ss').parse(contentModel.checkOut!);
        }
        models.add(LogModel(
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
        DateTime?  checkOutTime ;
        if(contentModel.checkOut!=null) {
          checkOutTime =
              DateFormat('yyyy-MM-dd HH:mm:ss').parse(contentModel.checkOut!);
        }
        models.add(LogModel(
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
      {required LogType logType,required TimeOfDay checkInTime, TimeOfDay? checkOutTime, String? vehicleId,
         String? jobId,String? toolId,LogModel? logModel}) async {
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
      if(checkOutTime!=null) {
        String checkOutDateString = format.format(TimeUtils()
            .dateTimeFromTimeAndDate(checkOutTime, dateTime: selectedDate));
        requestBody.addAll({'checkout': checkOutDateString,});
      }else{
        requestBody.addAll({'checkout': ''});

      }
      String apiUrl='Staffs/PostStaffLog';
      if(logType==LogType.workLog || logType==LogType.siteLog){
        if(logType==LogType.workLog){
          requestBody.addAll({'isMain':true});
        }else{
          requestBody.addAll({'jobId': jobId,'isMain': false,});
        }
        if(logModel==null){
          apiUrl='Staffs/PostStaffLog';
        }else{
          apiUrl='Staffs/PutStaffLog/${logModel.staffLogModel!.id}';
        }
      }
      if(logType==LogType.vehicleLog){
        requestBody.addAll({'jobId': jobId,'vehicleId': vehicleId,});
        if(logModel==null){
          apiUrl='Vehicles/PostVehicleLog';
        }else{
          apiUrl='Vehicles/PutVehicleLog/${logModel.vehicleLogModel!.id}';
        }
      }
      if(logType==LogType.toolLog){
        requestBody.addAll({'jobId': jobId,
          'toolId': toolId,});
        if(logModel==null){
          apiUrl='Tools/PostToolLog';
        }else{
          apiUrl='Tools/PutToolLog/${logModel.toolLogModel!.id}';
        }
      }
      print('addLog 2');

      var response = await postDataRequest(
          urlAddress: apiUrl,
          requestBody: requestBody,
          method: logModel==null?'post':'put',
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
