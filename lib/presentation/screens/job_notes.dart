import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/constants/enums.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/job_description_model.dart';
import 'package:nn_portal/presentation/components/others/no_items_found.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/custom_alert_dialoug.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/custom_circular_progress_indicator.dart';
import 'package:nn_portal/presentation/components/text_fields/text_field_outlined_label.dart';
import 'package:nn_portal/providers/authentication_provider.dart';
import 'package:nn_portal/providers/job_details_provider.dart';
import 'package:provider/provider.dart';

class JobNotes extends StatelessWidget {
  JobNotes({Key? key}) : super(key: key);

  bool isViewOnly = false;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<AuthenticationProvider>(context, listen: false)
            .userModel!
            .onLeave! ||
        Provider.of<AuthenticationProvider>(context, listen: false)
                .userModel!
                .roleId! ==
            1 ||
        Provider.of<JobsDetailsProvider>(context, listen: false)
                .jobModel!
                .status ==
            'Closed') {
      isViewOnly = true;
    }
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<JobsDetailsProvider>(builder: (context, value, child) {
        return value.pageStatus == PageStatus.loading ||
                value.pageStatus == PageStatus.initialState
            ? const CustomCircularProgressIndicator()
            : value.jobDescriptionModels.isEmpty
                ? const NoItemsFound()
                : ListView.separated(
                    padding: const EdgeInsets.all(10),
                    itemCount: value.jobDescriptionModels.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: AppColors.tertiary,
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              value.jobDescriptionModels[index].comment ?? '',
                              style: const TextStyle(height: 1.5),
                            ),
                            if (value
                                    .jobDescriptionModels[index].adminComment !=
                                null)
                              Column(
                                children: [
                                  SizedBox(
                                    height: 8,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: DefaultTextStyle.of(context)
                                          .style
                                          .copyWith(height: 1.5),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Admin Comment :  ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                            text: value
                                                .jobDescriptionModels[index]
                                                .adminComment!),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(height: 4),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        value.jobDescriptionModels[index]
                                                .staffName ??
                                            'Unknown User',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(fontSize: 13),
                                      ),
                                      Text(
                                        value.jobDescriptionModels[index]
                                                .commentOn ??
                                            'Unknown date',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(fontSize: 11),
                                      ),
                                    ],
                                  ),
                                ),
                                if (!isViewOnly &&
                                    Provider.of<AuthenticationProvider>(context,
                                                listen: false)
                                            .userModel!
                                            .staffId ==
                                        value.jobDescriptionModels[index]
                                            .staffId)
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        constraints: const BoxConstraints(),
                                        padding:
                                            const EdgeInsets.only(right: 13),
                                        icon: Image.asset('assets/edit.png'),
                                        iconSize: 21,
                                        onPressed: () {
                                          addNote(
                                              jobDescriptionModel: value
                                                  .jobDescriptionModels[index]);
                                        },
                                      ),
                                      IconButton(
                                        constraints: const BoxConstraints(),
                                        padding: EdgeInsets.zero,
                                        icon: Image.asset('assets/delete.png'),
                                        iconSize: 21,
                                        onPressed: () {
                                          showCustomAlertDialog(
                                              message:
                                                  'Are you sure to delete?',
                                              negativeButtonText: 'Cancel',
                                              positiveButtonText: 'CONFIRM',
                                              positiveButtonAction: () {
                                                Provider.of<JobsDetailsProvider>(
                                                        MyApp.navigatorKey
                                                            .currentContext!,
                                                        listen: false)
                                                    .deleteDescription(
                                                        jobDescriptionModel:
                                                            value.jobDescriptionModels[
                                                                index]);
                                                Navigator.pop(context);
                                              });
                                        },
                                      ),
                                    ],
                                  )
                              ],
                            )
                          ],
                        ),
                      );
                      // return Card(
                      //   elevation: .4,
                      //   child: ListTile(
                      //
                      //     // tileColor: /tileColor,
                      //     title: Row(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         // Padding(
                      //         //   padding: const EdgeInsets.only(top: 8.0),
                      //         //   child: const  Icon(Icons.circle,size: 12,),
                      //         // ),
                      //         //  const SizedBox(width: 8,),
                      //         Flexible(
                      //             child: Text(
                      //           value.jobDescriptionModels[index].comment??'',
                      //           style: const TextStyle(height: 1.5),
                      //         )),
                      //       ],
                      //     ),
                      //     subtitle: Text(value.jobDescriptionModels[index].commentOn??'Unknown date'
                      //         .substring(0, 10)),
                      //     trailing: IconButton(
                      //       constraints: const BoxConstraints(),
                      //       padding: EdgeInsets.zero,
                      //       icon: const Icon(Icons.edit),
                      //       onPressed: () {
                      //         addNote(jobDescriptionModel: value.jobDescriptionModels[index]);
                      //       },
                      //     ),
                      //   ),
                      // );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  );
      }),
      floatingActionButton: !isViewOnly
          ? FloatingActionButton(
              backgroundColor: AppColors.secondaryBase,
              onPressed: () {
                addNote();
              },
              child: Image.asset(
                'assets/add_note.png',
                height: 32,
                width: 32,
                fit: BoxFit.fill,
              ),
            )
          : null,
    );
  }

  addNote({JobDescriptionModel? jobDescriptionModel}) async {
    TextEditingController textEditingController = TextEditingController();
    if (jobDescriptionModel != null) {
      textEditingController.text = jobDescriptionModel.comment!;
    }
    final _formKey = GlobalKey<FormState>();

    bool isCompleted = false;
    if (jobDescriptionModel != null) {
      isCompleted = jobDescriptionModel.status == 'Completed';
    }
    await showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: MyApp.navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {
          return AlertDialog(
            titlePadding: const EdgeInsets.all(0),
            contentPadding: const EdgeInsets.all(14),
            actionsPadding: const EdgeInsets.all(0),
            buttonPadding: const EdgeInsets.all(0),
            insetPadding:
                const EdgeInsets.only(top: 54, left: 14, right: 14, bottom: 50),
            content: Form(
              key: _formKey,
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.clear),
                      ),
                    ),
                    Flexible(
                      child: TextFieldOutlineLabel(
                        textEditingController: textEditingController,
                        label: 'Enter your note',
                        textInputType: TextInputType.multiline,
                        hint: 'Write here...',
                        minLines: 8,
                        maxLines: 1000,
                        validator: (String? value) {
                          print(
                              'validator $value  ${value!.trim().isEmpty ? 'Please fill' : null}');
                          return value.trim().isEmpty ? 'Please fill' : null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Checkbox(
                              value: isCompleted,
                              fillColor: MaterialStateProperty.all(
                                  AppColors.primaryBase),
                              onChanged: (value) {
                                stateSetter(() {
                                  isCompleted = value!;
                                });
                              }),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('Is Completed'),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        if (jobDescriptionModel != null)
                          Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.secondaryBase),
                                onPressed: () {
                                  showCustomAlertDialog(
                                      message: 'Are you sure?',
                                      negativeButtonText: 'Cancel',
                                      positiveButtonText: 'CONFIRM',
                                      positiveButtonAction: () {
                                        Provider.of<JobsDetailsProvider>(
                                                MyApp.navigatorKey
                                                    .currentContext!,
                                                listen: false)
                                            .deleteDescription(
                                                jobDescriptionModel:
                                                    jobDescriptionModel);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 14),
                                  child: Text(
                                    'DELETE',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .apply(color: AppColors.textLight),
                                  ),
                                )),
                          ),
                        if (jobDescriptionModel != null)
                          const SizedBox(
                            width: 20,
                          ),
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryBase),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (jobDescriptionModel == null) {
                                    Provider.of<JobsDetailsProvider>(
                                            MyApp.navigatorKey.currentContext!,
                                            listen: false)
                                        .addDescription(
                                            textEditingController.text,
                                            isCompleted);
                                    Navigator.pop(context);
                                  } else {
                                    Provider.of<JobsDetailsProvider>(
                                            MyApp.navigatorKey.currentContext!,
                                            listen: false)
                                        .updateDescription(
                                            description:
                                                textEditingController.text,
                                            jobDescriptionModel:
                                                jobDescriptionModel,
                                            isCompleted: isCompleted);
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 14),
                                child: Text(
                                  'SAVE',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .apply(color: AppColors.textLight),
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
