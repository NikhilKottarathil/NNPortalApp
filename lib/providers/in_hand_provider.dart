import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nn_portal/constants/enums.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/in_hand_model.dart';
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

class InHandProvider extends ChangeNotifier {
  PageStatus pageStatus = PageStatus.initialState;

  List<LogModel> models = [];
  LogType? logType;

  setLogType(LogType logType) {
    this.logType = logType;
  }

  Future<bool> getData() async {
    pageStatus = PageStatus.loading;
    notifyListeners();
    models.clear();
    // try {

    String apiUrl = '';

    if (logType == LogType.toolLog) {
      apiUrl = 'Tools/GetInHandTools';
    } else {
      apiUrl = 'Vehicles/GetInHandVehicles';
    }
    var response =
        await getDataRequest(urlAddress: apiUrl, isShowLoader: false);

    // for (var json in response) {
    //   StaffLogModel contentModel = StaffLogModel.fromJson(json);
    //   DateTime checkInTime =
    //   DateFormat('yyyy-MM-dd HH:mm:ss').parse(contentModel.checkIn!);
    //
    //   InHandModel inHandModel=InHandModel.fromJson(json);
    //   inHandModel.checkInTime=checkInTime;
    //
    //   if(json['toolId']!=null){
    //     inHandModel.type=Type.tool;
    //   }else{
    //     inHandModel.type=Type.vehicle;
    //   }
    //   models.add(inHandModel);
    //   models.sort((m1,m2)=>m1.checkInTime!.compareTo(m2.checkInTime!));
    // }
    // pageStatus = PageStatus.loaded;
    if (logType == LogType.vehicleLog) {
      for (var json in response) {
        VehicleLogModel contentModel = VehicleLogModel.fromJson(json);
        DateTime checkInTime = DateTime.now();
        if (contentModel.checkIn != null) {
          checkInTime= DateFormat('yyyy-MM-dd HH:mm:ss').parse(contentModel.checkIn!);
        }
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
            staffName: contentModel.staffName,
            logType: LogType.vehicleLog,
            isCompleted: true));
      }
    }
    if (logType == LogType.toolLog) {
      for (var json in response) {
        ToolLogModel contentModel = ToolLogModel.fromJson(json);
        DateTime checkInTime = DateTime.now();
        if (contentModel.checkIn != null) {
          checkInTime= DateFormat('yyyy-MM-dd HH:mm:ss').parse(contentModel.checkIn!);
        }
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
            staffName: contentModel.staffName,
            logType: LogType.toolLog,
            isCompleted: true));
      }
    }
    pageStatus = PageStatus.loaded;

    notifyListeners();
    return true;
    // } catch (e) {
    //   debugPrint(e.toString());
    //   pageStatus = PageStatus.failed;
    //   notifyListeners();
    //   return false;
    // }
  }

  onTileTap({required int index}) {}
}
