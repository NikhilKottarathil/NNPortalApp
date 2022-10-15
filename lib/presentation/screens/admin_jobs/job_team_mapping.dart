import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/constants/app_strings.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/job_model.dart';
import 'package:nn_portal/models/staff_model.dart';
import 'package:nn_portal/models/team_model.dart';
import 'package:nn_portal/models/vehicle_model.dart';
import 'package:nn_portal/presentation/components/app_bars/app_bar_default.dart';
import 'package:nn_portal/presentation/components/others/no_items_found.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/show_loader.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/show_snack_bar.dart';
import 'package:nn_portal/presentation/components/text_fields/auto_complete_text_field.dart';
import 'package:nn_portal/presentation/components/text_fields/date_picker_text_field.dart';
import 'package:nn_portal/presentation/components/text_fields/text_field_custom.dart';
import 'package:nn_portal/presentation/screens/admin_jobs/assigned_teams.dart';
import 'package:nn_portal/presentation/screens/teams/add_staff_to_team.dart';
import 'package:nn_portal/providers/assign_team_provider.dart';
import 'package:nn_portal/providers/jobs_provider.dart';
import 'package:nn_portal/providers/log_provider.dart';
import 'package:nn_portal/providers/team_provider.dart';
import 'package:provider/provider.dart';

class JobTeamMapping extends StatefulWidget {
  final TeamModel? teamModel;
  final JobModel? jobModel;
  final String? parentPage;

  const JobTeamMapping(
      {Key? key, this.teamModel, this.jobModel, this.parentPage})
      : super(key: key);

  @override
  State<JobTeamMapping> createState() => _JobTeamMappingState();
}

class _JobTeamMappingState extends State<JobTeamMapping> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController jobTextEditController = TextEditingController();
  final TextEditingController teamTextEditController = TextEditingController();
  final TextEditingController descriptionTextEditController =
      TextEditingController();

  List<StaffModel> staffModels = [];

  DateTime dateTime = DateTime.now();

  List<TeamModel> teamModels = [];
  List<JobModel> jobModels = [];
  List<VehicleModel> vehicleModels = [];

  JobModel? selectedJobModel;
  TeamModel? selectedTeamModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault(title: 'Assign Staff For Team'),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                   if(widget.parentPage=='team')
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: [
                         Expanded(
                           child:  CustomAutoCompleteTextField(
                             label: 'Job',
                             hint: '',

                             action: (value){
                               selectedJobModel=null;
                               if(value!=null && value.toString().trim().isNotEmpty) {
                                 if (jobModels.any((element) =>
                                 element.code == value)) {
                                   selectedJobModel = jobModels.singleWhere((
                                       element) => element.code == value);
                                 }
                               }
                               setState(() {});

                             },
                             textEditingController: jobTextEditController,

                             validator: (value) => jobModels.any((e) =>
                             e.code! ==
                                 jobTextEditController.text)
                                 ? null
                                 : 'Please fill',
                             suggestions:
                             jobModels.map((e) => e.code.toString()).toList(),
                           ),
                         ),
                         if (selectedJobModel != null && widget.parentPage=='team')
                           IconButton(
                               onPressed: () {
                                 Provider.of<AssignTeamProvider>(
                                     MyApp.navigatorKey.currentContext!,
                                     listen: false)
                                     .getData(jobId: selectedJobModel!.id!.toString());
                                 Navigator.push(context,
                                     MaterialPageRoute(builder: (_) => AssignedTeams(jobModel: selectedJobModel!,isFromJob: false,)));
                               },
                               icon: const Icon(Icons.add_business))
                       ],
                     ),


                    if(widget.parentPage=='team')
                    const SizedBox(
                      height: 12,
                    ),
                    if(widget.parentPage=='job')
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: CustomAutoCompleteTextField(
                            label: 'Team',
                            hint: '',
                            action: (value) {
                              _getStaffsInTeam();
                            },
                            textEditingController: teamTextEditController,
                            validator: (value) => teamModels.any((e) =>
                                    e.teamName!.trim() ==
                                    teamTextEditController.text.trim())
                                ? null
                                : 'Please fill',
                            suggestions: teamModels
                                .where((element) => element.isActive!)
                                .map((e) => e.teamName.toString())
                                .toList(),
                          ),
                        ),
                        if (selectedTeamModel != null && widget.parentPage=='job')
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AddStaffToTeam(
                                        teamModel: selectedTeamModel!),
                                  ),
                                ).then((value) => _getStaffsInTeam());
                              },
                              icon: const Icon(Icons.person_add))
                      ],
                    ),
                    if(widget.parentPage=='job')

                      const SizedBox(
                      height: 12,
                    ),
                    DatePickerTextField(
                      label: 'Assigned For',
                      dateTime: dateTime,
                      validator: (String? value) => null,
                      callback: (date) {},
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFieldCustom(
                      label: 'Description',
                      textEditingController: descriptionTextEditController,
                      validator: (String? value) => null,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      constraints: const BoxConstraints(minHeight: 300),
                      decoration: BoxDecoration(
                        // border: Border.all(color: AppColors.tertiary, width: 2),
                        borderRadius: BorderRadius.circular(9),
                        color: AppColors.tertiary.withOpacity(.2),
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Name',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: AppColors.textDark),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                      'Driver',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(color: AppColors.textDark),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                      'Leader',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(color: AppColors.textDark),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView.separated(
                            itemCount: staffModels.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 16),
                            itemBuilder: (context, index) {
                              return _staffListTile(
                                  staffModel: staffModels[index], index: index);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 8,
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 160,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 17)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (staffModels
                                      .where((element) => element.isLeader!)
                                      .length >
                                  1) {
                                showSnackBar(
                                    message: 'More than one leader selected');
                              } else {
                                Provider.of<AssignTeamProvider>(
                                        MyApp.navigatorKey.currentContext!,
                                        listen: false)
                                    .add(
                                        staffModels: staffModels,
                                        teamId: selectedTeamModel!.id!,
                                        jobId: jobModels
                                            .singleWhere((element) =>
                                                element.code.toString() ==
                                                jobTextEditController.text.toString())
                                            .id!, description: descriptionTextEditController.text,dateTime: dateTime)
                                    .then((value) {
                                  Navigator.of(context).pop();
                                });
                              }
                            }
                          },
                          child: Text(
                            'SAVE',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: AppColors.textLight),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _staffListTile({required StaffModel staffModel, required index}) {
    TextEditingController vehicleTextEditController = TextEditingController();
    if (staffModel.vehicleNo != null) {
      vehicleTextEditController.text = staffModel.vehicleNo!;
    }
    return Container(
      decoration: BoxDecoration(
          color: AppColors.tertiary.withOpacity(.6),
          borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 3, child: Text('${staffModel.name}')),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                            value: staffModel.isDriver,
                            onChanged: (value) {
                              staffModel.isDriver = !staffModel.isDriver!;
                              if (!staffModel.isDriver!) {
                                staffModel.vehicleNo = null;
                                staffModel.vehicleId = null;
                                staffModel.vehicleName = null;
                              }
                              setState(() {});
                            })),
                  )),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                            value: staffModel.isLeader,
                            onChanged: (value) {
                              for(StaffModel staff in staffModels){
                                staff.isLeader = false;

                                if(staffModel.id==staff.id){
                                  staff.isLeader = true;
                                }
                              }
                              setState(() {});
                            })),
                  )),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  staffModel.description ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              if (staffModel.isDriver!)
                Expanded(
                  flex: 1,
                  child: CustomAutoCompleteTextField(
                    hint: 'Select Vehicle',
                    textInputType: TextInputType.none,
                    textEditingController: vehicleTextEditController,
                    validator: (value) => vehicleModels.any((e) =>
                            e.vehicleNo!.trim() ==
                            vehicleTextEditController.text.trim())
                        ? null
                        : 'Please fill',
                    action: (value) {
                      VehicleModel selectedVehicleModel = vehicleModels
                          .singleWhere((element) => element.vehicleNo == value);

                      staffModel.vehicleId = selectedVehicleModel.id;
                      staffModel.vehicleNo = selectedVehicleModel.vehicleNo;
                    },
                    suggestions: vehicleModels
                        .map((e) => e.vehicleNo.toString())
                        .toList(),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  _initPage() async {
    await Future.delayed(const Duration(milliseconds: 10));

    showLoader();
    await Provider.of<JobsProvider>(
        MyApp.navigatorKey.currentContext!,
        listen: false)
        .getJobSuggestions();
    teamModels = Provider.of<TeamProvider>(context, listen: false).teamModels;
    jobModels =
        Provider.of<JobsProvider>(context, listen: false).jobSuggestionModels;
    vehicleModels =
        Provider.of<LogProvider>(context, listen: false).vehicleModels;
    if (widget.parentPage == 'team') {
      teamTextEditController.text = widget.teamModel!.teamName!;
      await Future.delayed(const Duration(milliseconds: 10));
      _getStaffsInTeam();
    }
    if (widget.parentPage == 'job') {
      jobTextEditController.text = jobModels.singleWhere((element) => element.id==widget.jobModel!.id).code!;
        selectedJobModel=jobModels.singleWhere((element) => element.id==widget.jobModel!.id);

      _getStaffsInTeam();
    }


    hideLoader();
  }

  void _getStaffsInTeam() async {
    staffModels.clear();
    selectedTeamModel = null;

    if (teamModels
        .any((e) => e.teamName!.trim() == teamTextEditController.text.trim())) {
      selectedTeamModel = teamModels.singleWhere(
          (element) => element.teamName == teamTextEditController.text);
      showLoader();

      try {
        staffModels = await Provider.of<TeamProvider>(
                MyApp.navigatorKey.currentContext!,
                listen: false)
            .getStaffInTeam(selectedTeamModel!.id!);
        hideLoader();
      } catch (e) {
        hideLoader();
      }
    }
    setState(() {});
  }
}
