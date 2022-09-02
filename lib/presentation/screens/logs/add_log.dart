import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/job_model.dart';
import 'package:nn_portal/models/log_model.dart';
import 'package:nn_portal/models/tool_model.dart';
import 'package:nn_portal/models/vehicle_model.dart';
import 'package:nn_portal/presentation/components/app_bars/app_bar_default.dart';
import 'package:nn_portal/presentation/components/list_tiles/job_list_tile.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/show_snack_bar.dart';
import 'package:nn_portal/presentation/components/text_fields/time_picker_text_field.dart';
import 'package:nn_portal/providers/log_provider.dart';
import 'package:provider/provider.dart';

class AddLog extends StatefulWidget {
  LogModel? logModel;
  LogType logType;

  AddLog({Key? key, required this.logType, this.logModel}) : super(key: key);

  @override
  State<AddLog> createState() => _AddLogState();
}

class _AddLogState extends State<AddLog> {
  TimeOfDay? checkInTime;
  TimeOfDay? checkOutTime;
  final _formKey = GlobalKey<FormState>();

  VehicleModel? selectedVehicleModel;
  ToolModel? selectedToolModel;
  JobModel? selectedJobModel;
  GlobalKey<AutoCompleteTextFieldState<VehicleModel>> vehicleKey =
      GlobalKey<AutoCompleteTextFieldState<VehicleModel>>();
  GlobalKey<AutoCompleteTextFieldState<ToolModel>> toolKey =
      GlobalKey<AutoCompleteTextFieldState<ToolModel>>();
  GlobalKey<AutoCompleteTextFieldState<JobModel>> jobKey =
      GlobalKey<AutoCompleteTextFieldState<JobModel>>();
  TextEditingController jobTextEditController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.logModel != null) {
      checkInTime = TimeOfDay(
          hour: widget.logModel!.checkIn.hour,
          minute: widget.logModel!.checkIn.minute);
      if(widget.logModel!.checkOut!=null) {
        checkOutTime = TimeOfDay(
            hour: widget.logModel!.checkOut!.hour,
            minute: widget.logModel!.checkOut!.minute);
      }
      if (widget.logType == LogType.siteLog) {
        selectedJobModel = JobModel(
            id: widget.logModel!.staffLogModel!.jobId,
            code: widget.logModel!.staffLogModel!.jobCode,
            locationName: widget.logModel!.staffLogModel!.locationName,
            clientName: widget.logModel!.staffLogModel!.clientName);
      }

      if (widget.logType == LogType.vehicleLog) {
        selectedVehicleModel = VehicleModel(
            id: widget.logModel!.vehicleLogModel!.vehicleId,
            vehicleNo: widget.logModel!.vehicleLogModel!.vehicleNo);
        selectedJobModel = JobModel(
            id: widget.logModel!.vehicleLogModel!.jobId,
            code: widget.logModel!.vehicleLogModel!.jobCode,
            locationName: widget.logModel!.vehicleLogModel!.locationName,
            clientName: widget.logModel!.vehicleLogModel!.clientName);
      }
      if (widget.logType == LogType.toolLog) {
        selectedToolModel = ToolModel(
            id: widget.logModel!.toolLogModel!.toolId,
            toolName: widget.logModel!.toolLogModel!.toolName);
        selectedJobModel = JobModel(
            id: widget.logModel!.toolLogModel!.jobId,
            code: widget.logModel!.toolLogModel!.jobCode,
            locationName: widget.logModel!.toolLogModel!.locationName,
            clientName: widget.logModel!.toolLogModel!.clientName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault(title: 'Add Work Log'),
      body: Form(
        key: _formKey,
        child: Padding(
          padding:const  EdgeInsets.symmetric(horizontal: 10,vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TimePickerTextField(
                    timeOfDay: checkInTime,
                    label: 'Check In Time',
                    callback: (time) {
                      checkInTime = time;
                    },
                    validator: (value) {
                      return checkInTime == null
                          ? 'Select Check In Time'
                          : compareTime()
                              ? 'Select Proper Time'
                              : null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                TimePickerTextField(
                    timeOfDay: checkOutTime,
                    label: 'Check Out Time',
                    callback: (time) {
                      checkOutTime = time;
                    },
                    validator: (value) {
                      return  compareTime()
                              ? 'Select Proper Time'
                              : null;
                    }),

                selectJob(),
                selectVehicle(),
                selectTool(),

                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    onPressed: () {
                      print(checkInTime);
                      if (_formKey.currentState!.validate()) {
                        bool isReady = true;
                        if (widget.logType != LogType.workLog &&
                            selectedJobModel == null) {
                          isReady = false;
                          showSnackBar(message: 'Select Job');
                        }
                        if (widget.logType == LogType.vehicleLog &&
                            selectedVehicleModel == null) {
                          isReady = false;

                          showSnackBar(message: 'Select Vehicle');
                        }
                        if (widget.logType == LogType.toolLog &&
                            selectedToolModel == null) {
                          isReady = false;

                          showSnackBar(message: 'Select Tool');
                        }
                        if (isReady) {
                          Provider.of<LogProvider>(
                                  MyApp.navigatorKey.currentContext!,
                                  listen: false)
                              .addLog(
                                  logType: widget.logType,
                                  checkInTime: checkInTime!,
                                  checkOutTime: checkOutTime,
                                  jobId: selectedJobModel != null
                                      ? selectedJobModel!.id.toString()
                                      : null,
                                  vehicleId: selectedVehicleModel != null
                                      ? selectedVehicleModel!.id.toString()
                                      : null,
                                  toolId: selectedToolModel != null
                                      ? selectedToolModel!.id.toString()
                                      : null,
                                  logModel: widget.logModel).then((value) {
                            Navigator.of(context).pop();

                          });
                        }
                      }
                    },
                    child:  SizedBox(
                       height: 48,
                        width: MediaQuery.of(context).size.width,
                        child:Center(child:  Text('SAVE',style: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.textLight),)))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget selectJob(){
    return Visibility(
        visible: widget.logType != LogType.workLog,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Select Job Site',
                    style: Theme.of(context).textTheme.subtitle2!),
                if(selectedJobModel!=null)
                GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedJobModel = null;
                      });
                    },
                    child: Text(
                      'Change',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: AppColors.secondaryBase),
                    ))
              ],
            ),
            const SizedBox(
              height: 6,
              width: double.infinity,
            ),
            if (selectedJobModel == null)
              AutoCompleteTextField<JobModel>(
                key: jobKey,
                controller: jobTextEditController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: AppColors.tertiary,
                  hintText: "Enter location or client",
                  suffixIcon: GestureDetector(
                    onTap: () async {
                      await Provider.of<LogProvider>(context,
                          listen: false)
                          .getJobList(
                          searchString:
                          jobTextEditController.text);
                      jobTextEditController.text =
                          jobTextEditController.text + '';
                    },
                    child: Icon(
                      Icons.search,
                      color: AppColors.iconColor,
                    ),
                  ),
                ),
                itemSubmitted: (item) =>
                    setState(() => selectedJobModel = item),
                suggestions:
                Provider.of<LogProvider>(context, listen: true)
                    .jobModels,
                suggestionsAmount: 10,
                itemBuilder: (context, suggestion) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 6),
                  child: JobListTile(
                    jobModel: suggestion,
                  ),
                ),
                itemSorter: (a, b) => 0,
                itemFilter: (suggestion, input) =>
                suggestion.locationName!
                    .toLowerCase()
                    .startsWith(input.toLowerCase()) ||
                    suggestion.clientName!
                        .toLowerCase()
                        .contains(''),
              ),
            if (selectedJobModel != null)
              JobListTile(
                jobModel: selectedJobModel!,
                showTrailingIcon: false,
              ),
          ],
        ));
  }
  Widget selectVehicle(){
    return Visibility(
        visible: widget.logType == LogType.vehicleLog,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Select Vehicle',
                    style: Theme.of(context).textTheme.subtitle2!),
                if(selectedVehicleModel!=null)

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedVehicleModel = null;
                      });
                    },
                    child: Text(
                      'Change',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: AppColors.secondaryBase),
                    ))
              ],
            ),
            const SizedBox(
              height: 6,
              width: double.infinity,
            ),
            if (selectedVehicleModel == null)
              AutoCompleteTextField<VehicleModel>(
                key: vehicleKey,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: AppColors.tertiary,
                  hintText: "Search Vehicle",
                ),
                itemSubmitted: (item) =>
                    setState(() => selectedVehicleModel = item),
                suggestions:
                Provider.of<LogProvider>(context, listen: false)
                    .vehicleModels,
                suggestionsAmount: 10,
                itemBuilder: (context, suggestion) => Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(suggestion.vehicleNo!),
                ),
                itemSorter: (a, b) => 0,
                itemFilter: (suggestion, input) => suggestion
                    .vehicleNo!
                    .toLowerCase()
                    .startsWith(input.toLowerCase()),
              ),
            if (selectedVehicleModel != null)
              Container(
                decoration: BoxDecoration(
                    color: AppColors.tertiary,
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Text(
                      selectedVehicleModel!.vehicleNo!,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              )
          ],
        ));
  }
  Widget selectTool(){
    return Visibility(
        visible: widget.logType == LogType.toolLog,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Select Tool',
                    style: Theme.of(context).textTheme.subtitle2!),
                if(selectedToolModel!=null)

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedToolModel = null;
                      });
                    },
                    child: Text(
                      'Change',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: AppColors.secondaryBase),
                    ))
              ],
            ),
            const SizedBox(
              height: 6,
              width: double.infinity,
            ),
            if (selectedToolModel == null)
              AutoCompleteTextField<ToolModel>(
                key: toolKey,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: AppColors.tertiary,
                  hintText: "Search Tool",
                ),
                itemSubmitted: (item) =>
                    setState(() => selectedToolModel = item),
                suggestions:
                Provider.of<LogProvider>(context, listen: false)
                    .toolModels,
                suggestionsAmount: 10,
                itemBuilder: (context, suggestion) => Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(suggestion.toolName!),
                ),
                itemSorter: (a, b) => 0,
                itemFilter: (suggestion, input) => suggestion
                    .toolName!
                    .toLowerCase()
                    .startsWith(input.toLowerCase()),
              ),
            if (selectedToolModel != null)
              Container(
                decoration: BoxDecoration(
                    color: AppColors.tertiary,
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Text(
                      selectedToolModel!.toolName!,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
          ],
        ));
  }
  bool compareTime() {
    if (checkInTime != null && checkOutTime != null) {
      double checkIn =
          checkInTime!.hour.toDouble() + (checkInTime!.minute.toDouble() / 60);
      double checkOut = checkOutTime!.hour.toDouble() +
          (checkOutTime!.minute.toDouble() / 60);
      if (checkIn > checkOut) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
