import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/team_model.dart';
import 'package:nn_portal/presentation/components/text_fields/text_field_outlined_label.dart';
import 'package:nn_portal/providers/team_provider.dart';
import 'package:provider/provider.dart';

addTeam({TeamModel? teamModel}) async {
  TextEditingController textEditingController = TextEditingController();
  bool isActive = true;
  if (teamModel != null) {
    textEditingController.text = teamModel.teamName ?? '';
    isActive = teamModel.isActive ?? false;
  }
  final formKey = GlobalKey<FormState>();

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
          insetPadding: const EdgeInsets.only(left: 14, right: 14, bottom: 50),
          content: Form(
            key: formKey,
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
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.clear),
                    ),
                  ),
                  TextFieldOutlineLabel(
                    textEditingController: textEditingController,
                    label: 'Team Name',
                    textInputType: TextInputType.multiline,
                    hint: 'Write here...',
                    minLines: 2,
                    maxLines: 100,
                    validator: (String? value) {
                      return value != null && value.trim().isEmpty
                          ? 'Please fill'
                          : null;
                    },
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
                            value: isActive,
                            fillColor: MaterialStateProperty.all(
                                AppColors.primaryBase),
                            onChanged: (value) {
                              stateSetter(() {
                                isActive = value!;
                              });
                            }),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text('Is Active'),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: AppColors.primaryBase),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                Provider.of<TeamProvider>(
                                        MyApp.navigatorKey.currentContext!,
                                        listen: false)
                                    .addOrEdit(
                                        teamModel: teamModel,
                                        text: textEditingController.text,
                                        isActive: isActive)
                                    .then((value) {
                                  if (value) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();

                                    Navigator.pop(context);
                                  }
                                });
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
      });
    },
  );
}
