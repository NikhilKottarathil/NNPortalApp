import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';

class TextFieldSearch extends StatefulWidget {
  const TextFieldSearch(
      {Key? key,
      required this.searchTextEditingController,
      required this.hintText,
      this.onTypingSearchEnable = false,
      required this.searchAction})
      : super(key: key);

  final TextEditingController searchTextEditingController;
  final Function searchAction;
  final String hintText;
  final bool onTypingSearchEnable;

  @override
  State<TextFieldSearch> createState() => _TextFieldSearchState();
}

class _TextFieldSearchState extends State<TextFieldSearch> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.searchTextEditingController.addListener(() {
      setState(() {});
      if (widget.searchTextEditingController.text.isEmpty) {
        widget.searchAction();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.searchTextEditingController,
      cursorColor: AppColors.textDark,
      textInputAction: TextInputAction.search,
      onSubmitted: (value) {
        widget.searchAction();
      },
      onChanged: (value) {
        if (widget.onTypingSearchEnable) {
          widget.searchAction();
        }
      },
      decoration: InputDecoration(
        hintText: 'Search...',
        contentPadding: const EdgeInsets.all(14),
        fillColor: AppColors.tertiary,
        filled: true,
        prefixIcon: Icon(
          Icons.search,
          color: AppColors.textDark,
        ),
        suffixIcon: widget.searchTextEditingController.text.trim().isNotEmpty
            ? GestureDetector(
                onTap: () {
                  widget.searchTextEditingController.clear();
                },
                child: Icon(Icons.clear, color: AppColors.textDark))
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }
}
