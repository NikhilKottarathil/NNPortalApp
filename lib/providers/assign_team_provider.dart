import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nn_portal/constants/enums.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/admin_job_model.dart';
import 'package:nn_portal/models/assigned_team_model.dart';
import 'package:nn_portal/models/job_model.dart';
import 'package:nn_portal/models/job_type_model.dart';
import 'package:nn_portal/models/staff_model.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/file_upload_pop_up.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/show_snack_bar.dart';
import 'package:nn_portal/presentation/components/text_fields/mutli_select_list.dart';
import 'package:nn_portal/presentation/screens/admin_jobs/add_job.dart';
import 'package:nn_portal/presentation/screens/job_list.dart';
import 'package:nn_portal/providers/authentication_provider.dart';
import 'package:nn_portal/utils/dio_api_calls.dart';
import 'package:nn_portal/utils/http_api_calls.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssignTeamProvider extends ChangeNotifier {
  PageStatus pageStatus = PageStatus.initialState;

  List<AssignedTeamModel> models = [];

  String? jobId;

  Future getData({required String jobId}) async {
    this.jobId = jobId;
    pageStatus = PageStatus.loading;

    notifyListeners();

    try {
      models.clear();
      var response = await getDataRequest(
          urlAddress: 'JobStaffMappings/GetAssignedTeams/$jobId',
          isShowLoader: false);
      for (var json in response) {
        models.add(AssignedTeamModel.fromJson(json));
      }

      pageStatus = PageStatus.loaded;
      notifyListeners();
    } catch (e) {
      print(e);
      pageStatus = PageStatus.failed;
      notifyListeners();
    }
  }

  Future<bool> add({required List<StaffModel> staffModels,required int teamId,required int jobId,required DateTime dateTime,required String description }) async {
    try {
      List<Map<String,dynamic>> requestBody=[];

      for (var element in staffModels) {
        requestBody.add(
            {
              "teamId": teamId,
              "jobId": jobId,
              "staffId": element.id,
              "description": description,
              "isTeamLeader": element.isLeader,
              "isDriver": element.isDriver,
              "vehicleId": element.vehicleId,
              "assignedFor": DateFormat('yyyy-MM-dd').format(dateTime),
            }
        );
      }


      var response = await postDataRequest(
        urlAddress: 'Teams/TeamStaffMapping',
        requestBody: requestBody,
        isShowLoader: true,
        method: 'post',
      );

      return true;
    } catch (e) {
      debugPrint(e.toString());
      // pageStatus = PageStatus.failed;
      notifyListeners();
      return false;
    }
  }

  Future<bool> delete({required AssignedTeamModel model}) async {
    pageStatus = PageStatus.loading;
    notifyListeners();

    try {
      var response = await postDataRequest(
          method: 'post',
          urlAddress: 'JobStaffMappings/DeleteAssignedTeam',
          isShowLoader: false,
          requestBody: {
            "jobId": jobId,
            "teamId": model.teamId.toString(),
            'assignedFor': model.assignedFor
          });
      models.removeAt(models.indexWhere((element) => element.id == model.id));

      pageStatus = PageStatus.loaded;
      showSnackBar(message: 'Team removed successfully');

      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      pageStatus = PageStatus.failed;
      notifyListeners();
      return false;
    }
  }
}
