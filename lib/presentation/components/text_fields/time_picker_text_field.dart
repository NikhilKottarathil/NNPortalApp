import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/utils/time_utils.dart';

class TimePickerTextField extends StatelessWidget {
  String? label;
  String? hint;

  FormFieldValidator<String> validator;

  TimeOfDay? timeOfDay;
  Function callback;
  TimePickerTextField({
    Key? key,
    this.hint,
    this.label,
     this.timeOfDay,
    required this.callback,

    required this.validator,
  }) : super(key: key);

  final TextEditingController textEditingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    if(timeOfDay!=null){
      textEditingController.text=DateFormat('hh:mm a').format(TimeUtils().dateTimeFromTimeAndDate(timeOfDay!));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: Theme.of(context)
                .textTheme
                .subtitle2!
          ),
        const SizedBox(
          height: 6,
          width: double.infinity,
        ),
        GestureDetector(
          onTap: ()async{
             timeOfDay=await showTimePicker(context: context, initialTime: timeOfDay??TimeOfDay.now());
            if(timeOfDay!=null){
              callback(timeOfDay);
              textEditingController.text=DateFormat('hh:mm a').format(TimeUtils().dateTimeFromTimeAndDate(timeOfDay!));
            }
          },
          child: TextFormField(

            controller: textEditingController,
            minLines: 1,
            maxLines: 1,
            validator: validator,
            cursorColor: AppColors.textDark,

            enabled: false,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(height: 1.5,),

            decoration: InputDecoration(
                counterText: '',
                suffixIcon:const Icon( Icons.access_time_outlined),
                hintText: hint,
                contentPadding:
                const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                errorStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.red),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.textDarFourth)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.textDarFourth)),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.textDarFourth)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.textDarFourth)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.textDarFourth)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.textDarFourth))),
          ),
        ),
      ],
    );
  }
}
