
import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';

class BasicTextField extends StatelessWidget {
  String label;
  String? hint;
  Icon? prefixIcon;
  TextInputType textInputType;
  int maxLength;
  bool enabled;
  TextEditingController textEditingController;
  FormFieldValidator<String> validator;


  BasicTextField({
    Key? key,
    this.hint,
    required this.label,
    this.prefixIcon,
    this.maxLength = 100000,
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
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .apply(color: AppColors.textLight),
        ),
        const SizedBox(
          height: 6,
        ),
        TextFormField(
          keyboardType: textInputType,
          maxLength: maxLength,
          controller: textEditingController,
          validator: validator,

          cursorColor: AppColors.textLight,
          enableSuggestions:
              textInputType == TextInputType.visiblePassword ? false : true,
          autocorrect:
              textInputType == TextInputType.visiblePassword ? false : true,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.textLight),
          decoration: InputDecoration(
              counterText: '',
              prefixIcon: prefixIcon,
              hintText: hint,
              contentPadding:const EdgeInsets.symmetric(vertical:6,horizontal: 12),

              errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.textLight),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textLightSecondary)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textLight)),
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textLightSecondary)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textLightSecondary)),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textLightSecondary)),
              focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textLightSecondary))),
        ),
      ],
    );
  }
}
