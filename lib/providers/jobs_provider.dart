import 'package:flutter/material.dart';
import 'package:nn_portal/constants/enums.dart';
import 'package:nn_portal/models/job_model.dart';
import 'package:nn_portal/models/job_type_model.dart';
import 'package:nn_portal/presentation/screens/job_list.dart';
import 'package:nn_portal/utils/http_api_calls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobsProvider extends ChangeNotifier {
  PageStatus pageStatus = PageStatus.initialState;
  int totalPages = 0;
  int pageIndex = 1;
  int pageSize = 8;
  String searchString = '';
  List<JobModel> models = [];

  List<JobTypeModel> jobTypeModels = [
    JobTypeModel(displayName: 'All', keyName: 'All', isSelected: true),
    JobTypeModel(displayName: 'Open', keyName: 'Open'),
    JobTypeModel(displayName: 'Pending', keyName: 'Pending'),
    JobTypeModel(displayName: 'Completed', keyName: 'Completed'),
    JobTypeModel(displayName: 'Closed', keyName: 'Closed'),
  ];

  getInitialJob() {
    pageStatus = PageStatus.loading;
    notifyListeners();

    pageIndex = 1;
    models.clear();
    getJobCounts();
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

  changeJobType(JobTypeModel jobTypeModel) {
    for (var element in jobTypeModels) {
      element.isSelected = false;
      if (element.keyName == jobTypeModel.keyName) {
        element.isSelected = true;
      }
    }
    pageStatus = PageStatus.loading;
    notifyListeners();

    pageIndex = 1;
    models.clear();
    getJobs();
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
            'status': jobTypeModels
                .singleWhere((element) => element.isSelected)
                .keyName
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

  Future getJobCounts() async {
    notifyListeners();

    try {
      var response = await getDataRequest(
          urlAddress: 'Reports/GetStaffBasicData', isShowLoader: false);

      jobTypeModels[0].count = response['totalJobs'] ?? 0;
      jobTypeModels[1].count = response['openJobs'] ?? 0;
      jobTypeModels[2].count = response['pendingJobs'] ?? 0;
      jobTypeModels[3].count = response['completedJobs'] ?? 0;
      jobTypeModels[4].count = response['closedJobs'] ?? 0;

      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }
}
