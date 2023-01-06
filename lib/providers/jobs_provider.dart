import 'package:flutter/material.dart';
import 'package:nn_portal/constants/enums.dart';
import 'package:nn_portal/models/job_model.dart';
import 'package:nn_portal/models/job_type_model.dart';
import 'package:nn_portal/utils/http_api_calls.dart';

class JobsProvider extends ChangeNotifier {
  PageStatus pageStatus = PageStatus.initialState;
  int totalPages = 0;
  int pageIndex = 1;
  int pageSize = 15;
  String searchString = '';
  List<JobModel> models = [];
  bool isRefresh = false;
  ScrollController scrollController = ScrollController();

  double scrollPosition = 0.0;
  List<JobTypeModel> jobTypeModels = [
    JobTypeModel(displayName: 'All', keyName: 'All', isSelected: true),
    JobTypeModel(displayName: 'Assigned', keyName: 'Assigned'),
    JobTypeModel(displayName: 'Open Ticket', keyName: 'OpenSite'),
    JobTypeModel(displayName: 'Open Project', keyName: 'OpenProject'),
    JobTypeModel(displayName: 'Pend Ticket', keyName: 'PendingSite'),
    JobTypeModel(displayName: 'Pend Project', keyName: 'PendingProject'),
    JobTypeModel(displayName: 'Comp Ticket', keyName: 'CompletedSite'),
    JobTypeModel(displayName: 'Comp Project', keyName: 'CompletedProject'),
    JobTypeModel(displayName: 'Closed Jobs', keyName: 'Closed'),
  ];

  getInitialJob() {
    pageStatus = PageStatus.loading;
    notifyListeners();
    isRefresh = false;
    pageIndex = 1;
    models.clear();
    getJobCounts();
    getJobs();
  }

  resetToAllJobs() {
    changeJobType(jobTypeModels[0]);
  }

  refresh() {
    scrollPosition = scrollController.offset;
    isRefresh = true;
    getJobs();
    getJobCounts();
  }

  searchJobs(String text) {
    if (searchString != text) {
      isRefresh = false;
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
    isRefresh = false;

    pageIndex = 1;
    models.clear();
    getJobs();
  }

  loadMore() {
    if (totalPages > pageIndex) {
      isRefresh = false;
      pageStatus = PageStatus.loadMore;
      notifyListeners();
      pageIndex++;
      getJobs();
    }
  }

  Future getJobs() async {
    notifyListeners();
    if (isRefresh) {
      models.clear();
    }
    try {
      var response = await postDataRequest(
          urlAddress: 'Jobs/GetStaffJobs',
          requestBody: {
            'filterText': searchString,
            'pageIndex': isRefresh ? '1' : pageIndex.toString(),
            'pageSize': isRefresh
                ? ((pageIndex * pageSize).toString())
                : pageSize.toString(),
            'status': jobTypeModels
                .singleWhere((element) => element.isSelected)
                .keyName
          },
          isShowLoader: isRefresh);
      totalPages = (response['totalCount'] / pageSize).ceil();
      for (var json in response['items']) {
        models.add(JobModel.fromJson(json));
      }

      pageStatus = PageStatus.loaded;
      notifyListeners();
      if (isRefresh) {
        await Future.delayed(const Duration(milliseconds: 100));
        scrollController.animateTo(scrollPosition,
            duration: const Duration(milliseconds: 1), curve: Curves.ease);
      }
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
      jobTypeModels[1].count = response['assignedJobs'] ?? 0;
      // jobTypeModels[2].count = response['openJobs'] ?? 0;
      // jobTypeModels[3].count = response['pendingJobs'] ?? 0;
      // jobTypeModels[4].count = response['completedJobs'] ?? 0;
      // jobTypeModels[5].count = response['closedJobs'] ?? 0;
      jobTypeModels[2].count = response['openSites'] ?? 0;
      jobTypeModels[3].count = response['openProjects'] ?? 0;
      jobTypeModels[4].count = response['pendingSites'] ?? 0;
      jobTypeModels[5].count = response['pendingProjects'] ?? 0;
      jobTypeModels[6].count = response['completedSites'] ?? 0;
      jobTypeModels[7].count = response['completedProjects'] ?? 0;
      jobTypeModels[8].count = response['closedJobs'] ?? 0;

      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }
}
