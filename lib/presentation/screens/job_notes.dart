import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/constants/enums.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/job_description_model.dart';
import 'package:nn_portal/presentation/components/others/no_items_found.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/custom_alert_dialoug.dart';
import 'package:nn_portal/presentation/components/pop_ups_loaders/custom_circular_progress_indicator.dart';
import 'package:nn_portal/presentation/components/text_fields/text_field_outlied_label.dart';
import 'package:nn_portal/providers/job_details_provider.dart';
import 'package:provider/provider.dart';

class JobNotes extends StatelessWidget {
  const JobNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<JobsDetailsProvider>(builder: (context, value, child) {
        return value.pageStatus == PageStatus.loading ||
                value.pageStatus == PageStatus.initialState
            ? const CustomCircularProgressIndicator():value.jobDescriptionModels.isEmpty?const NoItemsFound()
            : ListView.builder(
                padding: const EdgeInsets.all(14),
                itemCount: value.jobDescriptionModels.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: .4,
                    child: ListTile(

                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 8.0),
                          //   child: const  Icon(Icons.circle,size: 12,),
                          // ),
                          //  const SizedBox(width: 8,),
                          Flexible(
                              child: Text(
                            value.jobDescriptionModels[index].description??'',
                            style: const TextStyle(height: 1.5),
                          )),
                        ],
                      ),
                      subtitle: Text(value.jobDescriptionModels[index].postedOn??'Unknown date'
                          .substring(0, 10)),
                      trailing: IconButton(
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          addNote(jobDescriptionModel: value.jobDescriptionModels[index]);
                        },
                      ),
                    ),
                  );
                });
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryBase,
        onPressed: () {
          addNote();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  addNote({JobDescriptionModel? jobDescriptionModel}) async {
    TextEditingController textEditingController = TextEditingController();
    if(jobDescriptionModel!=null){
      textEditingController.text=jobDescriptionModel.description!;
    }
    final _formKey = GlobalKey<FormState>();

    await showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: MyApp.navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.all(14),
          actionsPadding: const EdgeInsets.all(0),
          buttonPadding: const EdgeInsets.all(0),
          insetPadding: const EdgeInsets.only(left: 14, right: 14, bottom: 50),
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
                  const SizedBox(
                    height: 5,
                  ),
                  Text('Enter your note.',
                      style: Theme.of(context).textTheme.subtitle2),
                  TextFieldOutlineLabel(
                    textEditingController: textEditingController,
                    label: 'Enter your note',
                    textInputType: TextInputType.multiline,
                    hint: 'Write here...',
                    minLines: 8,
                    maxLines: 100,
                    validator: (String? value) {
                      print(
                          'validator $value  ${value!.trim().isEmpty ? 'Please fill' : null}');
                      return value.trim().isEmpty ? 'Please fill' : null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      if(jobDescriptionModel!=null)
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: AppColors.secondaryBase),
                            onPressed: () {
                              showCustomAlertDialog(message: 'Are you sure?',negativeButtonText: 'Cancel', positiveButtonText: 'CONFIRM', positiveButtonAction: (){
                                Provider.of<JobsDetailsProvider>(
                                    MyApp.navigatorKey.currentContext!,
                                    listen: false)
                                    .deleteDescription(jobDescriptionModel: jobDescriptionModel);
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
                                    .button!
                                    .apply(color: AppColors.textLight),
                              ),
                            )),
                      ),
                      if(jobDescriptionModel!=null)

                       const SizedBox(width: 20,),
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: AppColors.primaryBase),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if(jobDescriptionModel==null) {

                                  Provider.of<JobsDetailsProvider>(
                                      MyApp.navigatorKey.currentContext!,
                                      listen: false)
                                      .addDescription(textEditingController.text);
                                  Navigator.pop(context);
                                }else{
                                  Provider.of<JobsDetailsProvider>(
                                      MyApp.navigatorKey.currentContext!,
                                      listen: false)
                                      .updateDescription(description:textEditingController.text,jobDescriptionModel: jobDescriptionModel);
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
                                    .button!
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
      },
    );
  }
}
