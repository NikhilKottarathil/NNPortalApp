import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/constants/app_strings.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/staff_model.dart';
import 'package:nn_portal/models/team_model.dart';
import 'package:nn_portal/presentation/components/app_bars/app_bar_default.dart';
import 'package:nn_portal/presentation/components/others/no_items_found.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/show_loader.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/show_snack_bar.dart';
import 'package:nn_portal/presentation/components/text_fields/auto_complete_text_field.dart';
import 'package:nn_portal/presentation/components/text_fields/text_field_custom.dart';
import 'package:nn_portal/providers/team_provider.dart';
import 'package:provider/provider.dart';

class AddStaffToTeam extends StatefulWidget {
  final TeamModel teamModel;

  const AddStaffToTeam({Key? key, required this.teamModel}) : super(key: key);

  @override
  State<AddStaffToTeam> createState() => _AddStaffToTeamState();
}

class _AddStaffToTeamState extends State<AddStaffToTeam> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController staffNameTextEDitController =
      TextEditingController();

  final TextEditingController descriptionTextEditController =
      TextEditingController();

  List<StaffModel> assignedStaffModels = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getStaffsInTeam();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault(title: 'Assign Staff For Team'),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              CustomAutoCompleteTextField(
                label: 'Staff',
                hint: '',
                textEditingController: staffNameTextEDitController,
                validator: (value) =>
                    Provider.of<TeamProvider>(context, listen: false)
                            .staffsModels
                            .any((e) =>
                                e.name!.trim() ==
                                staffNameTextEDitController.text.trim())
                        ? null
                        : 'Please fill',
                suggestions: Provider.of<TeamProvider>(context, listen: false)
                    .staffsModels
                    .map((e) => e.name.toString())
                    .toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldCustom(
                label: 'Description',
                textEditingController: descriptionTextEditController,
                validator: (String? value) => null,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (Provider.of<TeamProvider>(context, listen: false)
                              .staffsModels
                              .any((e) =>
                                  e.name!.trim() ==
                                  staffNameTextEDitController.text.trim())) {
                            StaffModel staffModel = Provider.of<TeamProvider>(
                                    context,
                                    listen: false)
                                .staffsModels
                                .singleWhere(
                                  (e) =>
                                      e.name!.trim() ==
                                      staffNameTextEDitController.text.trim(),
                                );
                            if (!assignedStaffModels.any(
                                (element) => element.id == staffModel.id)) {
                              staffModel.description =
                                  descriptionTextEditController.text;
                              assignedStaffModels.add(staffModel);
                            } else {
                              showSnackBar(message: 'Staff Already Exist');
                            }
                            descriptionTextEditController.clear();
                            staffNameTextEDitController.clear();
                            setState(() {});
                          }
                        }
                      },
                      child: Text(
                        'ADD',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: AppColors.textLight),
                      )),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Expanded(
                child: Container(
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
                            const Icon(
                              Icons.close,
                              color: Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: assignedStaffModels.isNotEmpty
                            ? ListView.separated(
                                itemCount: assignedStaffModels.length,
                                shrinkWrap: true,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 8),
                                itemBuilder: (context, index) {
                                  return _staffListTile(
                                      staffModel: assignedStaffModels[index],
                                      index: index);
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    height: 8,
                                  );
                                },
                              )
                            : const NoItemsFound(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 17)),
                        onPressed: () {
                          if (assignedStaffModels
                                  .where((element) => element.isLeader!)
                                  .length >
                              1) {
                            showSnackBar(
                                message: 'More than one leader selected');
                          }
                          // Provider.of<TeamProvider>(
                          //         MyApp.navigatorKey.currentContext!,
                          //         listen: false)
                          //     .addStaffToTeam(staffModel: staffModel, teamModel: widget.teamModel)
                          //     .then((value) {
                          //   Navigator.of(context).pop();
                          // });
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _staffListTile({required StaffModel staffModel, required index}) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.tertiary.withOpacity(.6),
          borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${staffModel.name}'),
                  Text(
                    staffModel.description ?? '',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              )),
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
                          staffModel.isLeader = !staffModel.isLeader!;
                          setState(() {});
                        })),
              )),
          GestureDetector(
            onTap: () {
              assignedStaffModels.remove(staffModel);
              setState(() {});
            },
            child: const Icon(Icons.close),
          )
        ],
      ),
    );
  }

  void _getStaffsInTeam() async {
    await Future.delayed(const Duration(milliseconds: 10));
    showLoader();

    try {
      assignedStaffModels = await Provider.of<TeamProvider>(
              MyApp.navigatorKey.currentContext!,
              listen: false)
          .getStaffInTeam(widget.teamModel.id!);
      hideLoader();
      setState(() {});
    } catch (e) {
      showSnackBar(message: AppStrings.somethingWentWrong);
      await Future.delayed(const Duration(milliseconds: 500));
      hideLoader();
      Navigator.pop(MyApp.navigatorKey.currentContext!);
    }
  }
}
