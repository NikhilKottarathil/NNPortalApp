import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nn_portal/constants/enums.dart';
import 'package:nn_portal/models/job_model.dart';
import 'package:nn_portal/models/job_type_model.dart';
import 'package:nn_portal/models/leave_model.dart';
import 'package:nn_portal/presentation/screens/job_list.dart';
import 'package:nn_portal/utils/http_api_calls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaveProvider extends ChangeNotifier {
  PageStatus pageStatus = PageStatus.initialState;
  int totalPages = 0;
  int pageIndex = 1;
  int pageSize = 8;
  List<LeaveModel> models = [];

  TextEditingController reasonTextEditController = TextEditingController();
  DateTime? fromDate;
  DateTime? tillDate;
  bool isAnnualLeave=false;
  int? selectedLeaveId;

  getInitialData() {
    pageStatus = PageStatus.loading;
    notifyListeners();

    selectedLeaveId = null;
    pageIndex = 1;
    models.clear();
    getData();
  }

  loadMoreMoreDate() {
    if (totalPages > pageIndex) {
      pageStatus = PageStatus.loadMore;
      notifyListeners();
      pageIndex++;
      getData();
    }
  }

  Future getData() async {
    notifyListeners();

    try {
      var response = await postDataRequest(
          urlAddress: 'StaffLeaves/GetStaffLeaves',
          requestBody: {
            'filterText':'',
            'pageIndex': pageIndex.toString(),
            'pageSize': pageSize.toString(),
          },
          isShowLoader: false);
      totalPages = (response['totalCount'] / pageSize).ceil();
      for (var json in response['items']) {
      // for (var json in response) {
        models.add(LeaveModel.fromJson(json));
      }

      pageStatus = PageStatus.loaded;
      notifyListeners();
    } catch (e) {
      print(e);
      pageStatus = PageStatus.failed;
      notifyListeners();
    }
  }

  onAnnualLeaveChanged(value){
    isAnnualLeave=value;
    notifyListeners();
  }
  Future addOrEditData() async {
    notifyListeners();

    try {
      var requestBody = {
        'leaveFrom': DateFormat('yyyy-MM-dd').format(fromDate!),
        'leaveTo': DateFormat('yyyy-MM-dd').format(tillDate!),
        'reason': reasonTextEditController.text,
        'isAnnualLeave':isAnnualLeave
      };
      String url='StaffLeaves';
      if (selectedLeaveId != null) {
        requestBody.addAll({'id': selectedLeaveId!.toString()});
        url='StaffLeaves/$selectedLeaveId';
      }
      var response = await postDataRequest(
          urlAddress: url,
          requestBody: requestBody,
          method: selectedLeaveId != null ? 'put' : 'post',
          isShowLoader: true);
      if (selectedLeaveId != null) {
        models[models.indexWhere((element) => element.id == selectedLeaveId)] =
            LeaveModel.fromJson(response);
      } else {
        models.add(LeaveModel.fromJson(response));
      }
      clearLeaveForm();

      pageStatus = PageStatus.loaded;
      notifyListeners();
    } catch (e) {
      print(e);
      pageStatus = PageStatus.failed;
      notifyListeners();
    }
  }

  selectLeaveTileForEdit(int id) {
    selectedLeaveId = id;
    reasonTextEditController.text =
        models.singleWhere((element) => element.id == id).reason!;
    fromDate = DateFormat('yyyy-MM-dd')
        .parse(models.singleWhere((element) => element.id == id).leaveFrom!);
    tillDate = DateFormat('yyyy-MM-dd')
        .parse(models.singleWhere((element) => element.id == id).leaveTo!);
    notifyListeners();
  }

  deleteLeaveData(int id) async {
    try {
      var response = await deleteDataRequest(
          urlAddress: 'StaffLeaves/$id', isShowLoader: false);

      models.removeWhere((element) => element.id == id);
      if (selectedLeaveId == id) {
        clearLeaveForm();
      }
      notifyListeners();
    } catch (e) {
      print(e);
      pageStatus = PageStatus.failed;
      notifyListeners();
    }
  }

  clearLeaveForm() {
    reasonTextEditController.clear();
    fromDate = null;
    tillDate = null;
    selectedLeaveId = null;
    isAnnualLeave=false;
    FocusManager.instance.primaryFocus?.unfocus();

    notifyListeners();
  }
}
