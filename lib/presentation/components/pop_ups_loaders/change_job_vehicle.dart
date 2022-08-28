import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/main.dart';
import 'package:nn_portal/models/job_model.dart';
import 'package:nn_portal/models/vehicle_model.dart';
import 'package:nn_portal/providers/job_details_provider.dart';
import 'package:nn_portal/providers/log_provider.dart';
import 'package:provider/provider.dart';

changeJobVehicle({
  required JobVehicle jobVehicle,
}) async {
  VehicleModel? selectedVehicleModel;

  GlobalKey<AutoCompleteTextFieldState<VehicleModel>> vehicleKey =
      GlobalKey<AutoCompleteTextFieldState<VehicleModel>>();
  await showDialog(
      context: MyApp.navigatorKey.currentContext!,
      useSafeArea: true,
      builder: (alertContext) => StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              insetPadding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              // backgroundColor: Colors.black,
              contentPadding: const EdgeInsets.all(0),
              content: Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height / 2,
                padding: const EdgeInsets.only(
                    top: 10, right: 20, left: 20, bottom: 30),
                decoration: BoxDecoration(
                  // color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      GestureDetector(onTap: (){
                        Navigator.of(context).pop();
                      }, child:const  Icon(Icons.clear),)
                    ],),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Change Vehicle',
                            style:
                                Theme.of(alertContext).textTheme.titleLarge!),
                        if (selectedVehicleModel != null)
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedVehicleModel = null;
                                });
                              },
                              child: Text(
                                'Change',
                                style: Theme.of(alertContext)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(color: AppColors.secondaryBase),
                              ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
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
                        suggestions: Provider.of<LogProvider>(alertContext,
                                listen: false)
                            .vehicleModels,
                        suggestionsAmount: 10,
                        itemBuilder: (alertContext, suggestion) => Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(suggestion.vehicleNo!),
                        ),
                        itemSorter: (a, b) => 0,
                        itemFilter: (suggestion, input) => suggestion.vehicleNo!
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
                      ),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          if(selectedVehicleModel!=null){
                            Provider.of<JobsDetailsProvider>(alertContext,
                                listen: false).updateJobVehicle( vehicleModel: selectedVehicleModel!,jobVehicle: jobVehicle);
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(primary: selectedVehicleModel==null?AppColors.tertiary:null,onPrimary: selectedVehicleModel==null?AppColors.textDark:null,),
                        child: SizedBox(
                            height: 48,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                                child: Text(
                              'SAVE',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: AppColors.textLight),
                            )))),
                  ],
                ),
              ),
            );
          }));
  return false;
}
