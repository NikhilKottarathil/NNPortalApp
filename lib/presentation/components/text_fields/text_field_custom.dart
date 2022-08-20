import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';

class TextFieldCustom extends StatelessWidget {
  TextFieldCustom({
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



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        if (label != null)
          Text(label!, style: Theme.of(context).textTheme.titleSmall!),

        if (label != null)

          const SizedBox(
          height: 8,
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
            prefixIcon: prefixIcon,
            hintText: hint,
            counterText: '',
            contentPadding:
            const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            fillColor: AppColors.tertiary,
            filled: true,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
