import 'dart:io';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/admin_job_model.dart';
import 'package:nn_portal/models/job_model.dart';
import 'package:nn_portal/models/log_model.dart';
import 'package:nn_portal/models/tool_model.dart';
import 'package:nn_portal/models/vehicle_model.dart';
import 'package:nn_portal/presentation/components/app_bars/app_bar_default.dart';
import 'package:nn_portal/presentation/components/list_tiles/job_list_tile.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/permission_request_alert.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/show_snack_bar.dart';
import 'package:nn_portal/presentation/components/text_fields/auto_complete_text_field.dart';
import 'package:nn_portal/presentation/components/text_fields/mutli_select_list.dart';
import 'package:nn_portal/presentation/components/text_fields/text_field_custom.dart';
import 'package:nn_portal/presentation/components/text_fields/time_picker_text_field.dart';
import 'package:nn_portal/providers/admin_jobs_provider.dart';
import 'package:nn_portal/providers/log_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AddJob extends StatefulWidget {
  JobModel? jobModel;

  AddJob({Key? key, this.jobModel}) : super(key: key);

  @override
  State<AddJob> createState() => AddJobState();
}

class AddJobState extends State<AddJob> {
  TextEditingController clientTextEditController = TextEditingController();
  TextEditingController locationTextEditController = TextEditingController();
  TextEditingController jobTextEditController = TextEditingController();
  List<MultiSelectItemModel> jobTypes = [
    MultiSelectItemModel(id: 'Site', text: "Site", isSelected: true),
    MultiSelectItemModel(id: 'Project', text: "Project", isSelected: false)
  ];
  List<MultiSelectItemModel> status = [
    MultiSelectItemModel(id: 'Open', text: "Open", isSelected: true)
  ];

  TextEditingController ticketNoTextEditController = TextEditingController();
  TextEditingController ticketCallerTextEditController =
      TextEditingController();
  TextEditingController descriptionTextEditController = TextEditingController();
  TextEditingController commentsTextEditController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  File? file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.jobModel != null) {
      JobModel jobModel = widget.jobModel!;
      if (Provider.of<AdminJobsProvider>(context, listen: false).clients.any(
          (element) => element.id.toString() == jobModel.clientId.toString())) {
        clientTextEditController.text =
            Provider.of<AdminJobsProvider>(context, listen: false)
                .clients
                .singleWhere((element) =>
                    element.id.toString() == jobModel.clientId.toString())
                .text;
      }
      if (Provider.of<AdminJobsProvider>(context, listen: false).locations.any(
          (element) =>
              element.id.toString() == jobModel.locationId.toString())) {
        locationTextEditController.text =
            Provider.of<AdminJobsProvider>(context, listen: false)
                .locations
                .singleWhere((element) =>
                    element.id.toString() == jobModel.locationId.toString())
                .text;
      }

      ticketNoTextEditController.text = jobModel.ticketNo ?? '';
      ticketCallerTextEditController.text = jobModel.ticketCaller ?? '';
      descriptionTextEditController.text = jobModel.description ?? '';
      commentsTextEditController.text = jobModel.comment ?? '';

      status.add(MultiSelectItemModel(
          id: 'Pending', text: "Pending", isSelected: false));
      status.add(MultiSelectItemModel(
          id: 'Completed', text: "Completed", isSelected: false));
      status.add(MultiSelectItemModel(
          id: 'Closed', text: "Closed", isSelected: false));

      if (jobModel.status != null) {
        for (var element in status) {
          element.isSelected = jobModel.status == element.id;
        }
      }
      if (jobModel.prev != null) {
        for (var element in jobTypes) {
          element.isSelected = false;
        }
        jobModel.prev!?jobTypes.last.isSelected=true:jobTypes.first.isSelected=true;
      }
    }
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: appBarDefault(title: 'Add Job'),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              CustomAutoCompleteTextField(
                hint: 'Client',
                textEditingController: clientTextEditController,
                validator: (value) =>
                    Provider.of<AdminJobsProvider>(context, listen: false)
                            .clients
                            .map((e) => e.text)
                            .toList()
                            .contains(clientTextEditController.text)
                        ? null
                        : 'Please fill',
                suggestions:
                    Provider.of<AdminJobsProvider>(context, listen: false)
                        .clients
                        .map((e) => e.text)
                        .toList(),
              ),
              const SizedBox(
                height: 12,
              ),
              CustomAutoCompleteTextField(
                hint: 'Location',
                textEditingController: locationTextEditController,
                validator: (value) =>
                    Provider.of<AdminJobsProvider>(context, listen: false)
                            .locations
                            .map((e) => e.text)
                            .toList()
                            .contains(locationTextEditController.text)
                        ? null
                        : 'Please fill',
                suggestions:
                    Provider.of<AdminJobsProvider>(context, listen: false)
                        .locations
                        .map((e) => e.text)
                        .toList(),
              ),
              const SizedBox(
                height: 12,
              ),
              MultiSelectList(
                title: 'Type',
                multiSelectItemModels: jobTypes,
                isMultiSelect: false,
              ),
              const SizedBox(
                height: 10,
              ),
              MultiSelectList(
                title: 'Status',
                multiSelectItemModels: status,
                isMultiSelect: false,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldCustom(
                label: 'Ticket No',
                textEditingController: ticketNoTextEditController,
                validator: (String? value) => null,
              ),
              const SizedBox(
                height: 12,
              ),
              TextFieldCustom(
                label: 'Ticket Caller',
                textEditingController: ticketCallerTextEditController,
                validator: (String? value) => null,
              ),
              const SizedBox(
                height: 12,
              ),
              TextFieldCustom(
                label: 'Description',
                textEditingController: descriptionTextEditController,
                maxLines: 10000,
                minLines: 4,
                validator: (String? value) => null,
              ),
              const SizedBox(
                height: 12,
              ),
              TextFieldCustom(
                label: 'Comments',
                maxLines: 1000,
                minLines: 2,
                textEditingController: commentsTextEditController,
                validator: (String? value) => null,
              ),
              const SizedBox(
                height: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'File',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      IconButton(
                          onPressed: () async {
                            bool isGranted =
                                await Permission.storage.request().isGranted;
                            if (isGranted) {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: [
                                  'jpg',
                                  'png',
                                  'raw',
                                  'svg',
                                  'pdf',
                                  'doc',
                                  'docx',
                                  'xls',
                                  'xlsx',
                                  'ppt',
                                  'pptx',
                                  'txt',
                                  'html',
                                ],
                              );
                              if (result != null) {
                                file = File(result.files.single.path!);
                                setState((){});
                              } else {
                                // User canceled the picker
                              }
                            } else {
                              await showStoragePermissionRequest();
                            }
                          },
                          icon: const Icon(
                            Icons.add_box,
                            size: 32,
                          ))
                    ],
                  ),
                  if (file != null)
                    const SizedBox(
                      height: 8,
                    ),
                  if (file != null)
                    [
                      'jpg',
                      'png',
                      'raw',
                      'svg',
                    ].contains(file!.path.split('.').toList().last)
                        ? Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.tertiary),
                            padding: const EdgeInsets.all(4),
                            child: Image.file(
                              file!,
                              width: double.infinity,
                              height: MediaQuery.of(context).size.width * .5,
                            ),
                          )
                        : Text(
                            file!.path.split('/').toList().last,
                            textAlign: TextAlign.start,
                          )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Provider.of<AdminJobsProvider>(
                              MyApp.navigatorKey.currentContext!,
                              listen: false)
                          .addOrEdit(state: this,jobModel: widget.jobModel)
                          .then((value) {
                        Navigator.of(context).pop();
                      });
                    }
                  },
                  child: SizedBox(
                      height: 48,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: Text(
                        'SAVE',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: AppColors.textLight),
                      ))))
            ],
          ),
        ),
      ),
    );
  }
}
