import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/utils/time_utils.dart';

class TimePickerTextField extends StatefulWidget {
  String? label;
  String? hint;

  FormFieldValidator<String> validator;

  TimeOfDay? timeOfDay;
  Function callback;
  bool isShowCloseIcon;

  TimePickerTextField({
    Key? key,
    this.hint,
    this.label,
    this.timeOfDay,
    this.isShowCloseIcon=false,
    required this.callback,
    required this.validator,
  }) : super(key: key);

  @override
  State<TimePickerTextField> createState() => _TimePickerTextFieldState();
}

class _TimePickerTextFieldState extends State<TimePickerTextField> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.timeOfDay != null) {
      textEditingController.text = DateFormat('hh:mm a')
          .format(TimeUtils().dateTimeFromTimeAndDate(widget.timeOfDay!));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(widget.label!, style: Theme.of(context).textTheme.bodyMedium!),
        const SizedBox(
          height: 6,
          width: double.infinity,
        ),
        Container(
          decoration: BoxDecoration(
              color: AppColors.tertiary,
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    widget.timeOfDay = await showTimePicker(
                        context: context,
                        initialTime: widget.timeOfDay ?? TimeOfDay.now());
                    if (widget.timeOfDay != null) {
                      widget.callback(widget.timeOfDay);
                      textEditingController.text = DateFormat('hh:mm a').format(
                          TimeUtils().dateTimeFromTimeAndDate(widget.timeOfDay!));
                    }
                    setState(() {

                    });
                  },
                  child: TextFormField(
                    controller: textEditingController,
                    minLines: 1,
                    maxLines: 1,
                    validator: widget.validator,
                    cursorColor: AppColors.textDark,
                    enabled: false,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          height: 1.5,
                        ),
                    decoration: InputDecoration(
                      counterText: '',
                      suffixIcon: Icon(
                        Icons.access_time_outlined,
                        color: AppColors.iconColor,
                      ),

                      hintText: widget.hint,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 12),
                      errorStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.red),
                      fillColor: AppColors.tertiary,
                      filled: true,
                      border: OutlineInputBorder(
                          // borderSide: BorderSide(color: AppColors.textDarFourth),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                          borderRadius: BorderRadius.circular(8)),
                      // focusedBorder: OutlineInputBorder(
                      //     borderSide: BorderSide(color: AppColors.textDarFourth)),
                      // disabledBorder: OutlineInputBorder(
                      //     borderSide: BorderSide(color: AppColors.textDarFourth)),
                      // enabledBorder: OutlineInputBorder(
                      //     borderSide: BorderSide(color: AppColors.textDarFourth)),
                      // errorBorder: OutlineInputBorder(
                      //     borderSide: BorderSide(color: AppColors.textDarFourth)),
                      // focusedErrorBorder: OutlineInputBorder(
                      //     borderSide: BorderSide(color: AppColors.textDarFourth)),
                    ),
                  ),
                ),
              ),
              if(widget.isShowCloseIcon && widget.timeOfDay !=null)
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: AppColors.iconColor,
                ),
                constraints:const BoxConstraints(),
                padding: const EdgeInsets.only(left: 0,right: 15),
                onPressed: () {
                  widget.callback(null);
                  widget.timeOfDay=null;
                  textEditingController.clear();
                  setState(() {

                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
