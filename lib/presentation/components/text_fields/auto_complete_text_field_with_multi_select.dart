import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';

class AutoCompleteTextFieldWithMultiSelect extends StatefulWidget {
  const AutoCompleteTextFieldWithMultiSelect({Key? key, required this.heading})
      : super(key: key);
  final String heading;

  @override
  State<AutoCompleteTextFieldWithMultiSelect> createState() =>
      _AutoCompleteTextFieldWithMultiSelectState();
}

class _AutoCompleteTextFieldWithMultiSelectState
    extends State<AutoCompleteTextFieldWithMultiSelect> {
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  List<String> suggestions = [
    "Apple",
    "Armidillo",
    "Actual",
    "Actuary",
    "America",
    "Argentina",
    "Australia",
    "Antarctica",
    "Blueberry",
    "Cheese",
    "Danish",
    "Eclair",
    "Fudge",
    "Granola",
    "Hazelnut",
    "Ice Cream",
    "Jely",
    "Kiwi Fruit",
    "Lamb",
    "Macadamia",
    "Nachos",
    "Oatmeal",
    "Palm Oil",
    "Quail",
    "Rabbit",
    "Salad",
    "T-Bone Steak",
    "Urid Dal",
    "Vanilla",
    "Waffles",
    "Yam",
    "Zest"
  ];
  List<String> selectedNames = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.heading,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        if (selectedNames.isNotEmpty)
          SizedBox(
            height: 10,
          ),
        Wrap(
          children: selectedNames
              .map((e) => Container(
                  padding:
                      EdgeInsets.only(left: 8, right: 2, top: 3, bottom: 3),
                  margin: EdgeInsets.only(right: 5, bottom: 5),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(6)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(e),
                      SizedBox(
                        width: 2,
                      ),
                      IconButton(
                        onPressed: () {
                          selectedNames.remove(e);
                          setState(() {});
                        },
                        constraints: BoxConstraints(),
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.close,
                          size: 18,
                        ),
                      ),
                    ],
                  )))
              .toList(),
        ),
        const SizedBox(
          height: 5,
        ),
        SimpleAutoCompleteTextField(
          key: key,
          decoration: InputDecoration(
            hintText: 'Search..',
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            constraints: BoxConstraints(maxHeight: 32),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.black.withOpacity(.5)),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.black.withOpacity(.8))),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.black.withOpacity(.5)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.black.withOpacity(.5)),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.black.withOpacity(.5)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.black.withOpacity(.5)),
            ),
          ),
          controller: TextEditingController(),
          suggestions: suggestions,
          clearOnSubmit: true,
          textSubmitted: (text) => setState(() {
            print('text $text');
            if (text != "" && suggestions.contains(text)) {
              selectedNames.add(text);
            }
          }),
        ),
      ],
    );
  }
}
