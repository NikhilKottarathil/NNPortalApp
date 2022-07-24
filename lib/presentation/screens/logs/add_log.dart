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
      checkOutTime = TimeOfDay(
          hour: widget.logModel!.checkOut!.hour,
          minute: widget.logModel!.checkOut!.minute);
      if (widget.logType == LogType.vehicleLog) {
        selectedJobModel = JobModel(
            id: widget.logModel!.vehicleLogModel!.jobId,
            locationName: widget.logModel!.vehicleLogModel!.locationName,
            clientName: widget.logModel!.vehicleLogModel!.clientName);
        selectedVehicleModel = VehicleModel(
            id: widget.logModel!.vehicleLogModel!.vehicleId,
            vehicleNo: widget.logModel!.vehicleLogModel!.vehicleNo);
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
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TimePickerTextField(
                    timeOfDay: checkInTime,
                    label: 'Starting Time',
                    callback: (time) {
                      checkInTime = time;
                    },
                    validator: (value) {
                      return checkInTime == null ? 'Select Start Time' : null;
                    }),
                SizedBox(
                  height: 20,
                ),
                TimePickerTextField(
                    timeOfDay: checkOutTime,
                    label: 'Ending Time',
                    callback: (time) {
                      checkOutTime = time;
                    },
                    validator: (value) {
                      return checkOutTime == null ? 'Select Ending Time' : null;
                    }),
                Visibility(
                    visible: widget.logType != LogType.workLog,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text('Select Job Site',
                            style: Theme.of(context).textTheme.subtitle2!),
                        const SizedBox(
                          height: 6,
                          width: double.infinity,
                        ),
                        AutoCompleteTextField<JobModel>(
                          key: jobKey,
                          controller: jobTextEditController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.textDarFourth)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.textDarFourth)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.textDarFourth)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.textDarFourth)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.textDarFourth)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.textDarFourth)),
                              hintText: "Enter location or client",
                              suffixIcon: IconButton(
                                  onPressed: () async {
                                    await Provider.of<LogProvider>(context,
                                            listen: false)
                                        .getJobList(
                                            searchString:
                                                jobTextEditController.text);
                                    jobTextEditController.text =
                                        jobTextEditController.text + '';
                                  },
                                  icon: Icon(Icons.search))),
                          itemSubmitted: (item) =>
                              setState(() => selectedJobModel = item),
                          suggestions:
                              Provider.of<LogProvider>(context, listen: true)
                                  .jobModels,
                          itemBuilder: (context, suggestion) => Padding(
                            padding: EdgeInsets.all(12.0),
                            child: JobListTile(
                              jobModel: suggestion,
                            ),
                          ),
                          itemSorter: (a, b) => 0,
                          itemFilter: (suggestion, input) =>
                              suggestion.locationName!
                                  .toLowerCase()
                                  .startsWith(input.toLowerCase()) ||
                              suggestion.clientName!.toLowerCase().contains(''),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        if (selectedJobModel != null)
                          JobListTile(
                            jobModel: selectedJobModel!,
                            showTrailingIcon: false,
                          ),
                      ],
                    )),
                Visibility(
                    visible: widget.logType == LogType.vehicleLog,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text('Select Vehicle',
                            style: Theme.of(context).textTheme.subtitle2!),
                        const SizedBox(
                          height: 6,
                          width: double.infinity,
                        ),
                        AutoCompleteTextField<VehicleModel>(
                          key: vehicleKey,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.textDarFourth)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.textDarFourth)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.textDarFourth)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.textDarFourth)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.textDarFourth)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.textDarFourth)),
                              hintText: "Search Vehicle",
                              suffixIcon: Icon(Icons.search)),
                          itemSubmitted: (item) =>
                              setState(() => selectedVehicleModel = item),
                          suggestions:
                              Provider.of<LogProvider>(context, listen: false)
                                  .vehicleModels,
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
                        const SizedBox(
                          height: 12,
                        ),
                        if (selectedVehicleModel != null)
                          Card(
                            margin: EdgeInsets.all(1),
                            child: SizedBox(
                                width: double.infinity,
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
                                    child: Text(
                                      selectedVehicleModel!.vehicleNo!,
                                      textAlign: TextAlign.start,
                                    ))),
                          )
                      ],
                    )),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      print(checkInTime);
                      if (widget.logType == LogType.workLog) {
                        if (_formKey.currentState!.validate()) {
                          if (widget.logModel == null) {
                            Provider.of<LogProvider>(
                                    MyApp.navigatorKey.currentContext!,
                                    listen: false)
                                .addWorkLogs(
                                    checkInTime: checkInTime!,
                                    checkOutTime: checkOutTime!);
                            Navigator.of(context).pop();
                          } else {
                            //edit
                            Provider.of<LogProvider>(
                                    MyApp.navigatorKey.currentContext!,
                                    listen: false)
                                .updateWorkLogs(
                                    checkInTime: checkInTime!,
                                    logModel: widget.logModel!,
                                    checkOutTime: checkOutTime!);
                            Navigator.of(context).pop();
                          }
                        }
                      } else if (widget.logType == LogType.vehicleLog) {
                        if (_formKey.currentState!.validate()) {
                          if (selectedJobModel == null) {
                            showSnackBar(message: 'Select Job Site');
                          }
                          if (selectedVehicleModel == null) {
                            showSnackBar(message: 'Select Vehicle');
                          } else {
                            if (widget.logModel == null) {
                              Provider.of<LogProvider>(
                                      MyApp.navigatorKey.currentContext!,
                                      listen: false)
                                  .addVehicleLogs(
                                      checkInTime: checkInTime!,
                                      checkOutTime: checkOutTime!,
                                      vehicleId:
                                          selectedVehicleModel!.id.toString(),
                                      jobId: selectedJobModel!.id.toString());
                              Navigator.of(context).pop();
                            } else {
                              Provider.of<LogProvider>(
                                      MyApp.navigatorKey.currentContext!,
                                      listen: false)
                                  .updateVehicleLogs(
                                      logModel: widget.logModel!,
                                      checkInTime: checkInTime!,
                                      checkOutTime: checkOutTime!,
                                      vehicleId:
                                          selectedVehicleModel!.id.toString(),
                                      jobId: selectedJobModel!.id.toString());
                              Navigator.of(context).pop();
                            }
                          }
                        }
                      }
                    },
                    child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        child: Text('SAVE'))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
