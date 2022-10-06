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

class AssignedTeamProvider extends ChangeNotifier {
  PageStatus pageStatus = PageStatus.initialState;

  List<AssignedTeamModel> models = [];





  String? jobId;


  Future getData({required String jobId}) async {
    this.jobId=jobId;
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
  Future<bool> addOrEdit({ JobModel? jobModel,required AddJobState state}) async {
    pageStatus = PageStatus.loading;
    notifyListeners();

    print('stateeee ${state.clientTextEditController.text}');

    Map<String,String> requestBody={
     'ticketCaller': state.ticketCallerTextEditController.text,
      'ticketCreatedOn':DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'description': state.ticketCallerTextEditController.text,
      'openOn': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'flag': 'False',
      'status': state.status.singleWhere((element) => element.isSelected).id.toString(),
      'comment': state.ticketCallerTextEditController.text,
      'prev': 'False',
      'submitBy': Provider.of<AuthenticationProvider>(MyApp.navigatorKey.currentContext!,listen: false).userModel!.id.toString()
    };
    List<String> fileAddresses=[];
    List<File> files=[];
    CancelToken cancelToken = CancelToken();
    // try {
    var response=await showUploadFileAlert(
      urlAddress: 'Jobs',
      requestBody: requestBody,
      files: files,
      fileAddresses: fileAddresses,
      // cancelToken: cancelToken,
      method: 'post',

    );

    models.insert(0,AssignedTeamModel.fromJson(response));
    //
    // var response = await fileUploadWithDio(
    //   showUploadBytes: true,
    //     urlAddress: 'Jobs', fileAddresses: fileAddresses,files: files, requestBody: requestBody );



    pageStatus = PageStatus.loaded;
    notifyListeners();
    return true;
    // } catch (e) {
    //   print(e);
    //   pageStatus = PageStatus.failed;
    //   notifyListeners();
    //   return false;
    // }
  }
  Future<bool> delete({required AssignedTeamModel model}) async {
    pageStatus = PageStatus.loading;
    notifyListeners();

    try {
      var response = await postDataRequest(
        method: 'post',
          urlAddress: 'JobStaffMappings/DeleteAssignedTeam', isShowLoader: false, requestBody: {
        "jobId": jobId,
        "teamId": model.teamId.toString(),
        'assignedFor':model.assignedFor
      });
      models
          .removeAt(models.indexWhere((element) => element.id == model.id));

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
