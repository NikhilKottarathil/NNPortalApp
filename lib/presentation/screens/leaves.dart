import 'dart:io';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/constants/enums.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/job_model.dart';
import 'package:nn_portal/models/log_model.dart';
import 'package:nn_portal/models/tool_model.dart';
import 'package:nn_portal/models/vehicle_model.dart';
import 'package:nn_portal/presentation/components/app_bars/app_bar_default.dart';
import 'package:nn_portal/presentation/components/list_tiles/job_list_tile.dart';
import 'package:nn_portal/presentation/components/list_tiles/leave_tile.dart';
import 'package:nn_portal/presentation/components/others/no_items_found.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/custom_circular_progress_indicator.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/show_snack_bar.dart';
import 'package:nn_portal/presentation/components/text_fields/date_picker_text_field.dart';
import 'package:nn_portal/presentation/components/text_fields/text_field_custom.dart';
import 'package:nn_portal/presentation/components/text_fields/text_field_outlined_label.dart';
import 'package:nn_portal/presentation/components/text_fields/time_picker_text_field.dart';
import 'package:nn_portal/providers/leave_provider.dart';
import 'package:nn_portal/providers/log_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:nn_portal/constants/app_colors.dart';

import '../components/pop_ups_loaders/permission_request_alert.dart';

class Leaves extends StatefulWidget {
  const Leaves({Key? key}) : super(key: key);

  @override
  State<Leaves> createState() => _LeavesState();
}

class _LeavesState extends State<Leaves> {
  final _formKey = GlobalKey<FormState>();

  ScrollController scrollController = ScrollController();

  bool isFromDateValid=true;
  bool isTillDateValid=true;
  bool isDateOfJoiningValid=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault(title: 'Leaves'),
      body: Consumer<LeaveProvider>(builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Apply Leave',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: DatePickerTextField(
                            startDate: DateTime.now()
                                .subtract(const Duration(days: 365)),
                            lastDate: value.tillDate,
                            dateTime: value.fromDate,
                            label: 'Leave From',
                            callback: (date) {
                              value.fromDate = date;
                              value.notifyListeners();

                            },
                            maxHeight: isFromDateValid?38:50,
                            validator: (value) {
                              isFromDateValid=value!.isNotEmpty;

                              return value!.isEmpty ? 'Select from date' : null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: DatePickerTextField(
                            startDate: value.fromDate??DateTime.now()
                                .subtract(const Duration(days: 365)),
                            dateTime: value.tillDate,
                            label: 'Leave till',
                            maxHeight: isTillDateValid?38:50,
                            callback: (date) {
                              value.tillDate = date;
                              value.notifyListeners();
                            },
                            validator: (value) {
                              isTillDateValid=value!.isNotEmpty;
                              return value!.isEmpty ? 'Select till date' : null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: DatePickerTextField(
                            startDate: DateTime.now()
                                .subtract(const Duration(days: 3650)),
                            dateTime: value.joiningDate,
                            label: 'Date of Joining',
                            callback: (date) {
                              value.joiningDate = date;
                            },
                            maxHeight: isDateOfJoiningValid?38:50,
                            validator: (value) {
                              isDateOfJoiningValid=value!.isNotEmpty;

                              return value!.isEmpty
                                  ? 'Select joining date'
                                  : null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            SizedBox(height: 22,),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  minimumSize: Size(10, 38),
                                  backgroundColor: AppColors.tertiary,
                                  side: BorderSide(color: Colors.transparent),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.attach_file,
                                    color: AppColors.iconColor,
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text('Attach Doc',
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                              onPressed: () async {
                                bool isGranted = await Permission.storage
                                    .request()
                                    .isGranted;
                                if (isGranted) {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: [
                                      'jpg',
                                      'jpeg',
                                      'jpe',
                                      'jif',
                                      'jfif',
                                      'jfi',
                                      'png',
                                      'apng',
                                      'webp',
                                      'tif',
                                      'tiff',
                                      'bmp',
                                      'BMPf',
                                      'raw',
                                      'arw',
                                      'cr2',
                                      'nrw',
                                      'k25',
                                      'arw',
                                      'heif',
                                      'hevc',
                                      'heic',
                                      'svg',
                                      'psd',
                                      'pdf',
                                      'doc',
                                      'docx',
                                      'xls',
                                      'xlsx',
                                      'ppt',
                                      'pptx',
                                      'txt',
                                      'rtf',
                                      'odt',
                                      'pub',
                                      'pages',
                                      'html',
                                    ],
                                  );
                                  if (result != null) {
                                    File file = File(result.files.single.path!);
                                    value.attachment = file;
                                    value.notifyListeners();
                                  } else {
                                    // User canceled the picker
                                  }
                                } else {
                                  await showStoragePermissionRequest();
                                }
                              },
                            ),
                          ],
                        ))
                      ],
                    ),
                    if (value.attachment != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              value.attachment!.path.toString().split('/').last,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: (){
                              value.attachment=null;
                              value.notifyListeners();
                            },
                            child: Icon(
                              Icons.close,
                              color: AppColors.iconColor,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFieldCustom(
                      label: 'Reason',
                      minLines: 3,
                      maxLines: 100,
                      hint: 'Enter your reason',
                      textEditingController: value.reasonTextEditController,
                      validator: (val) =>
                      val!.isEmpty ? 'Please enter reason' : null,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                height: 24,
                                width: 24,
                                child: Checkbox(
                                    value: value.isAnnualLeave,
                                    onChanged: (val) =>
                                        value.onAnnualLeaveChanged(val))),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text('Annual Leave')
                          ],
                        ),
                        if(value.fromDate!=null && value.tillDate!=null)
                        Text('${value.tillDate!.difference(value.fromDate!).inDays+1} Days',style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600))
                        else
                          SizedBox(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: AppColors.secondaryBase,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              )),
                          onPressed: () {
                            Provider.of<LeaveProvider>(context, listen: false)
                                .clearLeaveForm();
                          },
                          child: const Text('Clear'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                )),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                bool isReady = true;
                                if (value.fromDate!
                                        .difference(value.tillDate!)
                                        .inDays >
                                    1) {
                                  isReady = false;
                                  showSnackBar(
                                      message:
                                          'From date must be less than till date');
                                }
                                if (value.tillDate!
                                        .difference(value.joiningDate!)
                                        .inDays >
                                    1) {
                                  isReady = false;
                                  showSnackBar(
                                      message:
                                          'Till date must be less than Date of joining');
                                }
                                if (isReady) {
                                  // Provider.of<LeaveProvider>(context,
                                  //         listen: false)
                                  //     .addOrEditData();
                                }
                              }else{
                                value.notifyListeners();
                              }
                            },
                            child: const Text('  Submit  '))
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'My Leaves',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ColoredBox(
                  color: AppColors.tertiary.withOpacity(.3),
                  child: value.pageStatus == PageStatus.loading
                      ? CustomCircularProgressIndicator()
                      : value.models.isNotEmpty
                          ? ListView.separated(
                              itemCount: value.models.length,
                              controller: scrollController,
                              itemBuilder: (BuildContext context, int index) {
                                return LeaveTile(
                                    leaveModel: value.models[index]);
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                            )
                          : const NoItemsFound(),
                ),
              ),
              if (value.pageStatus == PageStatus.loadMore)
                const Center(
                  child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CustomCircularProgressIndicator()),
                ),
            ],
          ),
        );
      }),
    );
  }
}
