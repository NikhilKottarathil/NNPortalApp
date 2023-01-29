import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
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
import 'package:provider/provider.dart';

class Leaves extends StatefulWidget {
  const Leaves({Key? key}) : super(key: key);

  @override
  State<Leaves> createState() => _LeavesState();
}

class _LeavesState extends State<Leaves> {
  final _formKey = GlobalKey<FormState>();

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() { });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault(title: 'Leaves'),
      body: Consumer<LeaveProvider>(builder: (context, value, child) {
        return Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text('Apply Leave',style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),),
                   const SizedBox(height: 15,),
                    Row(
                      children: [
                        Expanded(
                          child: DatePickerTextField(
                            startDate: DateTime.now().subtract(const Duration(days: 365)),
                            dateTime: value.fromDate,
                            label: 'Leave From',
                            callback: (date) {
                              value.fromDate = date;
                            },
                            validator: (value) {
                              return value!.isEmpty ? 'Select from date' : null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: DatePickerTextField(
                            startDate: DateTime.now().subtract(const Duration(days: 365)),
                            dateTime: value.tillDate,
                            label: 'Leave till',
                            callback: (date) {
                              value.tillDate = date;
                            },
                            validator: (value) {
                              return value!.isEmpty?'Select till date' : null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
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
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: AppColors.secondaryBase,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                            shape:   RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                            )
                          ),
                          onPressed: () {
                            Provider.of<LeaveProvider>(
                                context, listen: false)
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
                                shape:   RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                )
                            ),
                            onPressed: () {
                              if(_formKey.currentState!.validate()) {
                                bool isReady=true;
                                if(value.fromDate!.difference(value.tillDate!).inDays>1){
                                  isReady=false;
                                  showSnackBar(message: 'From date must be less than till date');
                                }
                                if(isReady) {
                                  Provider.of<LeaveProvider>(context,listen: false).addOrEditData();

                                }
                              }
                            }, child: const Text('  Submit  '))
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text('My Leaves',style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),),
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
                                return LeaveTile(leaveModel: value.models[index]);
                              },
                              separatorBuilder: (BuildContext context, int index) {
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
