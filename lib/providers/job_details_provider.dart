import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nn_portal/constants/enums.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/job_description_model.dart';
import 'package:nn_portal/models/job_model.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/file_upload_pop_up.dart';
import 'package:nn_portal/providers/authentication_provider.dart';
import 'package:nn_portal/utils/dio_api_calls.dart';
import 'package:nn_portal/utils/http_api_calls.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/job_attachment_model.dart';

class JobsDetailsProvider extends ChangeNotifier {
  JobModel? jobModel;

  List<JobDescriptionModel> jobDescriptionModels=[];
  List<JobAttachmentModel> jobAttachmentModels=[];
  PageStatus pageStatus = PageStatus.initialState;

  setJobModel({required JobModel jobModel}) {
    this.jobModel = jobModel;
    jobDescriptionModels.clear();
    jobAttachmentModels.clear();
    getDescriptions();
    getAttachments();
  }

  Future getAttachments() async {
    pageStatus = PageStatus.loading;
    notifyListeners();

    try {

      var response = await getDataRequest(
          urlAddress: 'JobAttachments/GetJobAttachments/${jobModel!.id}',
          isShowLoader: false,
          );

      print(response);
      for(var json in response){
        jobAttachmentModels.add(JobAttachmentModel.fromJson(json));
        print('length ${jobAttachmentModels.length}');
      }

      pageStatus = PageStatus.loaded;
      notifyListeners();

    } catch (e) {
      print(e);
      pageStatus = PageStatus.failed;
      notifyListeners();
    }
  }
  Future getDescriptions() async {
    pageStatus = PageStatus.loading;
    notifyListeners();


    try {

      var response = await getDataRequest(
          urlAddress: 'JobComments/GetJobComments/${jobModel!.id}',
          isShowLoader: false,
          );

      for(var json in response){
        jobDescriptionModels.add(JobDescriptionModel.fromJson(json));
      }

      pageStatus = PageStatus.loaded;
      notifyListeners();

    } catch (e) {
      print(e);
      pageStatus = PageStatus.failed;
      notifyListeners();
    }
  }
  Future<bool> addDescription(String description,bool isCompleted) async {
    pageStatus = PageStatus.loading;
    notifyListeners();

    try {
      var format = DateFormat('yyyy-MM-dd HH:mm:ss');
      String dateString = format.format(DateTime.now());

      Map<String,String> requestBody= {
        'jobId': jobModel!.id.toString(),
        // 'staffId': Provider.of<AuthenticationProvider>(
        //     MyApp.navigatorKey.currentContext!,
        //     listen: false)
        //     .userModel!
        //     .id.toString(),
        'comment': description,
        'status': isCompleted?'Completed':'Pending',
        'commentOn':dateString
      };
      var response = await postDataRequest(
          urlAddress: 'JobComments',
          requestBody:requestBody,isShowLoader: false);
      jobDescriptionModels.insert(0,JobDescriptionModel.fromJson(response));

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
  Future<bool> updateDescription({required String description,required JobDescriptionModel jobDescriptionModel,required bool isCompleted}) async {
    pageStatus = PageStatus.loading;
    notifyListeners();

    try {
      var format = DateFormat('yyyy-MM-dd HH:mm:ss');
      var dateString = format.format(DateTime.now());
      // CancelToken cancelToken = CancelToken();

      Map<String,String> requestBody= {
        'id': jobDescriptionModel.id.toString(),
        'jobId': jobModel!.id.toString(),
        'staffId': Provider.of<AuthenticationProvider>(
            MyApp.navigatorKey.currentContext!,
            listen: false)
            .userModel!
            .id.toString(),
        'comment': description,
        'status': isCompleted?'Completed':'Pending',
        'commentOn':dateString
      };
      var response = await postDataRequest(
          urlAddress: 'JobComments/${jobDescriptionModel.id}',
          method: 'put',
          requestBody:requestBody,isShowLoader: false);
      jobDescriptionModels[jobDescriptionModels.indexWhere((element) => element.id==jobDescriptionModel.id)]=JobDescriptionModel.fromJson(response);

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
  Future<bool> deleteDescription({required JobDescriptionModel jobDescriptionModel}) async {
    pageStatus = PageStatus.loading;
    notifyListeners();

    try {
      var format = DateFormat.yMd();
      var dateString = format.format(DateTime.now());


      var response = await deleteDataRequest(
          urlAddress: 'JobComments/${jobDescriptionModel.id}',isShowLoader: false);
      jobDescriptionModels.removeAt(jobDescriptionModels.indexWhere((element) => element.id==jobDescriptionModel.id));

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

  Future<bool> addAttachment(File file) async {
    pageStatus = PageStatus.loading;
    notifyListeners();

    try {
      var format = DateFormat.yMd();
      var dateString = format.format(DateTime.now());

      Map<String,String> requestBody= {
        'jobId': jobModel!.id.toString(),
        'staffId': Provider.of<AuthenticationProvider>(
            MyApp.navigatorKey.currentContext!,
            listen: false)
            .userModel!
            .id.toString(),
        'uploadedOn':dateString
      };
      var response = await showUploadFileAlert(
          urlAddress: 'JobAttachments',
          requestBody:requestBody, files: [file], fileAddresses: ['uploadFile'],showUploadBytes: true);
      jobAttachmentModels.insert(0,JobAttachmentModel.fromJson(response));

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
  Future<bool> deleteAttachment({required JobAttachmentModel jobAttachmentModel}) async {
    pageStatus = PageStatus.loading;
    notifyListeners();

    try {
      var format = DateFormat.yMd();
      var dateString = format.format(DateTime.now());


      var response = await deleteDataRequest(
          urlAddress: 'JobAttachments/${jobAttachmentModel.id}',isShowLoader: false);
      jobAttachmentModels.removeAt(jobAttachmentModels.indexWhere((element) => element.id==jobAttachmentModel.id));

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
}
