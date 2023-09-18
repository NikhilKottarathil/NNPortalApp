import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/utils/time_utils.dart';

class DatePickerTextField extends StatelessWidget {
  String? label;
  String? hint;
  DateTime? startDate;
  DateTime? lastDate;
  double? maxHeight;

  FormFieldValidator<String> validator;

  DateTime? dateTime;
  Function callback;

  DatePickerTextField(
      {Key? key,
      this.hint,
      this.label,
      this.dateTime,
      required this.callback,
      required this.validator,
      this.startDate,
        this.lastDate,
      this.maxHeight})
      : super(key: key);

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (dateTime != null) {
      textEditingController.text = DateFormat('yyyy-MM-dd').format(dateTime!);
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(label!, style: Theme.of(context).textTheme.titleSmall!),
        const SizedBox(
          height: 6,
          width: double.infinity,
        ),
        GestureDetector(
          onTap: () async {
            dateTime = await showDatePicker(
                context: context,
                initialDate: dateTime ?? DateTime.now(),
                firstDate: startDate ?? DateTime.now(),
                lastDate:lastDate?? DateTime.now().add(const Duration(days: 365)));
            if (dateTime != null) {
              callback(dateTime);
              textEditingController.text =
                  DateFormat('yyyy-MM-dd').format(dateTime!);
            }
          },
          child: TextFormField(
            controller: textEditingController,
            minLines: 1,
            maxLines: 1,
            validator: validator,
            cursorColor: AppColors.textDark,
            enabled: false,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  height: 1.5,
                ),
            decoration: InputDecoration(
              counterText: '',
              suffixIcon: Icon(
                Icons.calendar_month,
                color: AppColors.iconColor,
              ),
              hintText: hint,
              constraints: maxHeight != null
                  ? BoxConstraints(maxHeight: maxHeight!)
                  : null,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              errorStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.red,decorationThickness: 0,height: 0.3),
              fillColor: AppColors.tertiary,
              filled: true,
              border: OutlineInputBorder(
                  // borderSide: BorderSide(color: AppColors.textDarFourth),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
      ],
    );
  }
}
