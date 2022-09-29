import 'package:flutter/material.dart';
import 'package:nn_portal/constants/enums.dart';
import 'package:nn_portal/models/job_model.dart';
import 'package:nn_portal/models/job_type_model.dart';
import 'package:nn_portal/presentation/screens/job_list.dart';
import 'package:nn_portal/utils/http_api_calls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminJobsProvider extends ChangeNotifier {
  PageStatus pageStatus = PageStatus.initialState;
  int totalPages = 0;
  int pageIndex = 1;
  int pageSize = 15;
  String searchString = '';
  List<JobModel> models = [];


  getInitialJob() {
    pageStatus = PageStatus.loading;
    notifyListeners();

    pageIndex = 1;
    models.clear();
    getJobs();
  }

  searchJobs(String text) {
    if (searchString != text) {
      searchString = text;
      pageStatus = PageStatus.loading;
      notifyListeners();


      pageIndex = 1;
      models.clear();
      getJobs();
    }
  }



  loadMore() {
    if (totalPages > pageIndex) {
      pageStatus = PageStatus.loadMore;
      notifyListeners();
      pageIndex++;
      getJobs();
    }
  }

  Future getJobs() async {
    notifyListeners();

    try {
      var response = await postDataRequest(
          urlAddress: 'Jobs/GetStaffJobs',
          requestBody: {
            'filterText': searchString,
            'pageIndex': pageIndex.toString(),
            'pageSize': pageSize.toString(),
            // 'status': jobTypeModels
            //     .singleWhere((element) => element.isSelected)
            //     .keyName
          },
          isShowLoader: false);
      totalPages = (response['totalCount'] / pageSize).ceil();
      for (var json in response['items']) {
        models.add(JobModel.fromJson(json));
      }

      pageStatus = PageStatus.loaded;
      notifyListeners();
    } catch (e) {
      print(e);
      pageStatus = PageStatus.failed;
      notifyListeners();
    }
  }
  Future<bool> delete(
      {required JobModel jobModel}) async {
    pageStatus = PageStatus.loading;
    notifyListeners();

    try {

      var response = await deleteDataRequest(
          urlAddress: 'Job/${jobModel.id}',
          isShowLoader: false);
      models.removeAt(models
          .indexWhere((element) => element.id == jobModel.id));

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
  //
  // Future getJobCounts() async {
  //   notifyListeners();
  //
  //   try {
  //     var response = await getDataRequest(
  //         urlAddress: 'Reports/GetStaffBasicData', isShowLoader: false);
  //
  //     jobTypeModels[0].count = response['totalJobs'] ?? 0;
  //     jobTypeModels[1].count = response['openJobs'] ?? 0;
  //     jobTypeModels[2].count = response['pendingJobs'] ?? 0;
  //     jobTypeModels[3].count = response['completedJobs'] ?? 0;
  //     jobTypeModels[4].count = response['closedJobs'] ?? 0;
  //
  //     notifyListeners();
  //   } catch (e) {
  //     notifyListeners();
  //   }
  // }
}
