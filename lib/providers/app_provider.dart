import 'package:flutter/material.dart';
import 'package:nn_portal/constants/enums.dart';
import 'package:nn_portal/models/job_model.dart';
import 'package:nn_portal/models/job_type_model.dart';
import 'package:nn_portal/models/tool_model.dart';
import 'package:nn_portal/models/vehicle_model.dart';
import 'package:nn_portal/presentation/screens/job_list.dart';
import 'package:nn_portal/utils/http_api_calls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {

  List<JobModel> jobSuggestionModels = [];
  List<VehicleModel> vehicleModels = [];
  List<ToolModel> toolModels = [];


  init(){
    getVehicleList();
    getToolList();
    getJobSuggestions();
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

  Future getJobSuggestions() async {
    try {
      jobSuggestionModels.clear();
      var response = await getDataRequest(
        // requestBody: {
        //   'filterText': '',
        //   'pageIndex':1,
        //   'pageSize': 10,
        //   'status':'All'
        // },
          urlAddress: 'Jobs/GetdlJobs', isShowLoader: false);

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
