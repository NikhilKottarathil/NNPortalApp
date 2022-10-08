import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:nn_portal/constants/app_colors.dart';

class CustomAutoCompleteTextField extends StatefulWidget {
  const CustomAutoCompleteTextField({
    Key? key,
    required this.hint,
    this.label,
    required this.textEditingController,
    this.validator,
    this.isRequiredField = true,
    required this.suggestions,
    this.action,
  }) : super(key: key);

  final String hint;
  final TextEditingController textEditingController;
  final FormFieldValidator<String>? validator;
  final String? label;
  final bool isRequiredField;
  final List<String> suggestions;
  final Function? action;

  @override
  State<CustomAutoCompleteTextField> createState() =>
      _CustomAutoCompleteTextFieldState();
}

class _CustomAutoCompleteTextFieldState
    extends State<CustomAutoCompleteTextField> {
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.textEditingController.addListener(() {
      if (widget.textEditingController.text.isEmpty) {
        if (widget.action != null) {
          widget.action!('');
        }
      }
      if (mounted) {
        setState(() {});
      }
    });
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        if (!widget.suggestions.contains(widget.textEditingController.text)) {
          widget.textEditingController.clear();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) Text(widget.label!),
        if (widget.label != null)
          const SizedBox(
            height: 4,
          ),
        TypeAheadFormField(
          textFieldConfiguration: TextFieldConfiguration(
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(decoration: TextDecoration.none),
            focusNode: focusNode,
            decoration: InputDecoration(
              hintText: widget.hint,
              suffixIcon: widget.textEditingController.text.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        widget.textEditingController.clear();
                      },
                      child: const Icon(
                        Icons.close,
                      ),
                    )
                  : null,
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
            controller: widget.textEditingController,
          ),
          suggestionsCallback: (pattern) {
            return getSuggestions(pattern);
          },
          itemBuilder: (context, String suggestion) {
            return ListTile(
              title: Text(
                suggestion,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          },
          transitionBuilder: (context, suggestionsBox, controller) {
            return suggestionsBox;
          },
          onSuggestionSelected: (String suggestion) {
            widget.textEditingController.text = suggestion;
            if (widget.action != null) {
              widget.action!(suggestion);
            }
          },
          noItemsFoundBuilder: (context) {
            return ListTile(
              title: Text(
                'No matches found',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          },
          validator: widget.validator,
          // onSaved: (value) => this._selectedCity = value,
        ),
      ],
    );
  }

  List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(widget.suggestions);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
