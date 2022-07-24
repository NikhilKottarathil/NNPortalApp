import 'package:flutter/material.dart';
import 'package:nn_portal/constants/enums.dart';
import 'package:nn_portal/models/job_model.dart';
import 'package:nn_portal/utils/http_api_calls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobsProvider extends ChangeNotifier {
  PageStatus pageStatus = PageStatus.initialState;
  int totalPages = 0;
  int pageIndex = 1;
  int pageSize = 8;
  String searchString='';
  List<JobModel> models = [];

  getInitialJob() {
    pageStatus = PageStatus.loading;

    pageIndex = 1;
    models.clear();
    getJobs();
  }

  searchJobs(String text){
    if(searchString!=text) {
      searchString=text;
      pageStatus = PageStatus.loading;

      pageIndex = 1;
      models.clear();
      getJobs();
    }
  }

  loadMore() {
    if(totalPages>pageIndex) {
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
            'pageSize': pageSize.toString()
          },
          isShowLoader: false);
      totalPages=(response['totalCount']/pageSize).ceil();
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
}
