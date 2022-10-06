import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nn_portal/constants/enums.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/job_model.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/file_upload_pop_up.dart';
import 'package:nn_portal/presentation/components/text_fields/mutli_select_list.dart';
import 'package:nn_portal/presentation/screens/admin_jobs/add_job.dart';
import 'package:nn_portal/providers/authentication_provider.dart';
import 'package:nn_portal/utils/http_api_calls.dart';
import 'package:provider/provider.dart';

class AdminJobsProvider extends ChangeNotifier {
  PageStatus pageStatus = PageStatus.initialState;
  int totalPages = 0;
  int pageIndex = 1;
  int pageSize = 15;
  String searchString = '';
  List<JobModel> models = [];

  List<MultiSelectItemModel> clients = [];
  List<MultiSelectItemModel> locations = [];

  getInitialJob() {
    pageStatus = PageStatus.loading;
    notifyListeners();
    getClientAndLocations();

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

  Future<bool> addOrEdit(
      {JobModel? jobModel, required AddJobState state}) async {
    // pageStatus = PageStatus.loading;
    notifyListeners();

    print('inside');
    bool isNew=jobModel==null;
    // try {
    Map<String, String> requestBody = {
      'clientId': clients
          .singleWhere((element) =>
      element.text == state.clientTextEditController.text.trim())
          .id
          .toString(),
      'locationId': locations
          .singleWhere((element) =>
      element.text == state.locationTextEditController.text.trim())
          .id
          .toString(),
      'description': state.ticketCallerTextEditController.text,
      'comment': state.ticketCallerTextEditController.text,
      'ticketNo': state.ticketNoTextEditController.text,
      'ticketCaller': state.ticketCallerTextEditController.text,
      'ticketCreatedOn': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'openOn': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'flag': 'False',
      'status': state.status
          .singleWhere((element) => element.isSelected)
          .id
          .toString(),
      'prev': state.status.last.isSelected ? 'True' : 'False',
      'submitBy': Provider.of<AuthenticationProvider>(
          MyApp.navigatorKey.currentContext!,
          listen: false)
          .userModel!
          .id
          .toString()
    };
    if(!isNew){
      requestBody.addAll({'id':jobModel.id.toString()});
    }
    List<String> fileAddresses = [];
    List<File> files = [];
    if(state.file!=null){
      files.add(state.file!);
      fileAddresses.add('imageFile');
    }
    var response = await showUploadFileAlert(
      urlAddress: isNew?'Jobs':'Jobs/${jobModel.id}',
      requestBody: requestBody,
      files: files,
      fileAddresses: fileAddresses,
      method: isNew?'post':'put',
    );

    if(isNew) {
      models.insert(0, JobModel.fromJson(response));
    }else{
      models[models.indexWhere((element) => element.id==jobModel.id)]=JobModel.fromJson(response);

    }
    // pageStatus = PageStatus.loaded;
    notifyListeners();
    return true;
    // } catch (e) {
    //   debugPrint(e.toString());
    //   // pageStatus = PageStatus.failed;
    //   notifyListeners();
    //   return false;
    // }
  }

  Future<bool> delete({required JobModel jobModel}) async {
    // pageStatus = PageStatus.loading;
    notifyListeners();

    try {
      var response = await deleteDataRequest(
          urlAddress: 'Jobs/${jobModel.id}', isShowLoader: true);
      models
          .removeAt(models.indexWhere((element) => element.id == jobModel.id));

      // pageStatus = PageStatus.loaded;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      // pageStatus = PageStatus.failed;
      notifyListeners();
      return false;
    }
  }

  Future getClientAndLocations() async {
    try {
      var response = await getDataRequest(
          urlAddress: 'Clients/GetdlClients', isShowLoader: false);

      clients.clear();
      response.forEach((element) {
        clients.add(MultiSelectItemModel(
            text: element['clientName'] ?? '',
            id: element['id'].toString(),
            isSelected: false));
      });

      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
    try {
      var response = await getDataRequest(
          urlAddress: 'Locations/GetdlLocations', isShowLoader: false);

      locations.clear();
      response.forEach((element) {
        locations.add(MultiSelectItemModel(
            text: element['locationName'] ?? '',
            id: element['id'].toString(),
            isSelected: false));
      });
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }
}
