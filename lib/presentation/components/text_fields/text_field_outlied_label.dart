import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';

class TextFieldOutlineLabel extends StatelessWidget {
  String? label;
  String? hint;
  Icon? prefixIcon;
  TextInputType textInputType;
  int maxLength;
  int minLines;
  int maxLines;
  bool enabled;
  TextEditingController textEditingController;
  FormFieldValidator<String> validator;

  TextFieldOutlineLabel({
    Key? key,
    this.hint,
    this.label,
    this.prefixIcon,
    this.maxLength = 100000,
    this.maxLines = 1,
    this.minLines = 1,
    this.enabled = true,
    this.textInputType = TextInputType.text,
    required this.textEditingController,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                .apply(color: AppColors.textLight),
          ),
        const SizedBox(
          height: 6,
          width: double.infinity,
        ),
        TextFormField(
          keyboardType: textInputType,
          maxLength: maxLength,
          minLines: minLines,
          maxLines: maxLines,
          controller: textEditingController,
          validator: validator,
          cursorColor: AppColors.textDark,
          enableSuggestions:
              textInputType == TextInputType.visiblePassword ? false : true,
          autocorrect:
              textInputType == TextInputType.visiblePassword ? false : true,

          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(height: 1.5,),
          decoration: InputDecoration(
              counterText: '',
              prefixIcon: prefixIcon,
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
      ],
    );
  }
}
