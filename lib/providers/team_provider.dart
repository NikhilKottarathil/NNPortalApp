import 'package:flutter/material.dart';
import 'package:nn_portal/constants/enums.dart';
import 'package:nn_portal/models/staff_model.dart';
import 'package:nn_portal/models/team_model.dart';
import 'package:nn_portal/utils/http_api_calls.dart';

class TeamProvider extends ChangeNotifier {
  PageStatus pageStatus = PageStatus.initialState;

  List<TeamModel> displayModel = [];
  List<TeamModel> teamModels = [];
  List<StaffModel> staffsModels = [];

  // apiReduce
  getInitialData() async {
    pageStatus = PageStatus.loading;
    notifyListeners();
    teamModels.clear();
    displayModel.clear();
    await getAllStaffs();

    getTeams();
  }

  searchTeams(String text) {
    displayModel.clear();
    if (text.trim().isNotEmpty) {
      for (var element in teamModels) {
        if (element.teamName!.toLowerCase().contains(text.toLowerCase())) {
          displayModel.add(element);
        }
      }
    } else {
      displayModel.addAll(teamModels);
    }
    notifyListeners();
  }

  Future getTeams() async {
    notifyListeners();
    try {
      var response =
          await getDataRequest(urlAddress: 'Teams', isShowLoader: false);
      for (var json in response) {
        teamModels.add(TeamModel.fromJson(json));
      }
      displayModel.addAll(teamModels);
      pageStatus = PageStatus.loaded;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      pageStatus = PageStatus.failed;
      notifyListeners();
    }
  }

  Future getAllStaffs() async {
    staffsModels.clear();
    try {
      var response = await getDataRequest(
          urlAddress: 'Staffs/GetdlStaffs', isShowLoader: false);
      for (var json in response) {
        print(
            'staffModel ${StaffModel.fromJson(json).isLeader} ${StaffModel.fromJson(json).isDriver}');
        staffsModels.add(StaffModel.fromJson(json));
      }
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      notifyListeners();
    }
  }

  Future<List<StaffModel>> getStaffInTeam(int teamId) async {
    var response = await getDataRequest(
        urlAddress: 'Teams/GetTeamStaffs/$teamId', isShowLoader: false);
    List<StaffModel> tempStaffModel=[];
    for (var json in response) {
      print(
          'staffModel ${StaffModel.fromJson(json).isLeader} ${StaffModel.fromJson(json).isDriver}');
      tempStaffModel.add(StaffModel.fromJson(json));
    }
    return tempStaffModel;
  }

  Future<bool> addStaffToTeam({
    required List<StaffModel> assignedStaffModels,
    required  TeamModel teamModel,
  }) async {
    // pageStatus = PageStatus.loading;
    // notifyListeners();

    try {
      List<Map<String,dynamic>> requestBody=[];

      if(assignedStaffModels.isEmpty){
        requestBody.add({
        "teamId": teamModel.id,
        "staffId":0,
        });
      }
      for (var element in assignedStaffModels) {
        requestBody.add(
          {
            "teamId": teamModel.id,
            "staffId": element.id,
            "description": element.description,
            "isTeamLeader": element.isLeader,
            "isDriver": element.isDriver
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
    return true;
  }

  Future<bool> addOrEdit(
      {required String text,
      TeamModel? teamModel,
      required bool isActive}) async {
    // pageStatus = PageStatus.loading;
    notifyListeners();
    bool isNew = teamModel == null;
    try {
      Map<String, dynamic> requestBody = {
        "teamName": text,
        "isActive": isActive,
      };
      if (!isNew) {
        requestBody.addAll({'id': teamModel.id});
      }

      var response = await postDataRequest(
        urlAddress: isNew ? 'Teams' : 'Teams/${teamModel.id}',
        requestBody: requestBody,
        isShowLoader: true,
        method: isNew ? 'post' : 'put',
      );

      if (isNew) {
        displayModel.insert(0, TeamModel.fromJson(response));
        teamModels.insert(0, TeamModel.fromJson(response));
      } else {
        displayModel[displayModel
                .indexWhere((element) => element.id == teamModel.id)] =
            TeamModel.fromJson(response);
        teamModels[displayModel
                .indexWhere((element) => element.id == teamModel.id)] =
            TeamModel.fromJson(response);
      }
      // pageStatus = PageStatus.loaded;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      // pageStatus = PageStatus.failed;
      notifyListeners();
      return false;
    }
  }

  Future<bool> delete({required TeamModel teamModel}) async {
    try {
      await deleteDataRequest(
          urlAddress: 'Teams/${teamModel.id}', isShowLoader: true);
      displayModel.removeAt(
          displayModel.indexWhere((element) => element.id == teamModel.id));
      teamModels.removeAt(
          teamModels.indexWhere((element) => element.id == teamModel.id));
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future changeStatus({required TeamModel teamModel}) async {
    bool currentStatus = teamModel.isActive ?? false;
    displayModel[
            displayModel.indexWhere((element) => element.id == teamModel.id)]
        .isActive = !currentStatus;
    teamModels[
            teamModels.indexWhere((element) => element.id == teamModel.id)]
        .isActive = !currentStatus;
    notifyListeners();

    try {
      await postDataRequest(
          urlAddress: 'Teams/DisableTeam/${teamModel.id}',
          isShowLoader: false,
          method: 'put',
          requestBody: {
            "id": teamModel.id,
            "teamName": teamModel.teamName,
            "isActive": !currentStatus
          });
    } catch (e) {
      debugPrint(e.toString());
      displayModel[
              displayModel.indexWhere((element) => element.id == teamModel.id)]
          .isActive = currentStatus;
      teamModels[
              teamModels.indexWhere((element) => element.id == teamModel.id)]
          .isActive = currentStatus;
      notifyListeners();
    }
  }
}
