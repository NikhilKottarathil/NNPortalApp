import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/alert_model.dart';

showAllAlerts(List<AlertModel> alertModels) async {
  await showModalBottomSheet(
      elevation: 10,
      useRootNavigator: true,
      isDismissible: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      )),
      context: MyApp.navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return ConstrainedBox(
          constraints:  BoxConstraints(maxHeight: MediaQuery.of(context).size.height*.6),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryBase,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Alerts',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: ListView.separated(
                  padding: EdgeInsets.all(12),
                  shrinkWrap: true,
                  itemCount: alertModels.length,
                  itemBuilder: (_, index) => _widget(context,
                    alertModels[index],
                  ), separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 12,); },
                ),
              ),
              SizedBox(height: 32,),
            ],
          ),
        );
      });
}

Widget _widget(BuildContext context,AlertModel alertModel) {
  return Container(
    decoration: BoxDecoration(color: AppColors.tertiary,borderRadius: BorderRadius.circular(8)),
    padding: EdgeInsets.all(12),
    child: Column(
      children: [
        Text('${alertModel.type} on ${alertModel.expiry}',style: Theme.of(context).textTheme.titleSmall,),
        SizedBox(height: 4,),
        Text(alertModel.name??'',style: Theme.of(context).textTheme.titleSmall,),
      ],
    ),
  );
}
