import 'package:dental_app/core/utlis/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CustomTypeAheadField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final Future<List<String>> Function(String) suggestionsCallback;
  final void Function(String) onSuggestionSelected;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final bool? autofocus;
  final Color? fillColor;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final void Function(String)? onChange;
  final int? maxLength;
  final double widthFactor;
  final int? maxLines;

  const CustomTypeAheadField({
    Key? key,
    required this.label,
    required this.controller,
    required this.suggestionsCallback,
    required this.onSuggestionSelected,
    this.focusNode,
    this.textInputType,
    this.autofocus = false,
    this.fillColor,
    this.radius = 10.0,
    this.padding,
    this.onChange,
    this.maxLength,
    this.maxLines,
    required this.widthFactor,
  }) : super(key: key);

  @override
  State<CustomTypeAheadField> createState() => _CustomTypeAheadFieldState();
}

class _CustomTypeAheadFieldState extends State<CustomTypeAheadField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * widget.widthFactor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TypeAheadField<String>(
          textFieldConfiguration: TextFieldConfiguration(
            controller: widget.controller,
            focusNode: widget.focusNode,
            autofocus: widget.autofocus!,
            maxLines: widget.maxLines ?? 1,
            keyboardType: widget.textInputType ?? TextInputType.name,
            maxLength: widget.maxLength,
            onChanged: widget.onChange,
            decoration: InputDecoration(
              hintText: widget.label,
              filled: true,
              fillColor: widget.fillColor ?? AppColors.whiteF7,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(
                  widget.radius ?? 18.0.r,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,
                  color: AppColors.primary,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius ?? 18.0.r),
                borderSide: const BorderSide(
                  width: 2,
                  color: AppColors.blueA1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius ?? 18.0.r),
                borderSide: const BorderSide(
                  width: 1,
                  color: AppColors.error,
                ),
              ),
            ),
          ),
          suggestionsCallback: (pattern) async {
            // Split text by spaces and use the last word for suggestions
            final lastWord = pattern.split(" ").last;
            return widget.suggestionsCallback(lastWord);
          },
          itemBuilder: (context, suggestion) =>
              ListTile(title: Text(suggestion)),
          onSuggestionSelected: (suggestion) {
            // Append the suggestion and add a trailing space
            widget.controller.text = "${widget.controller.text}$suggestion ";
            // Move the cursor to the end of the text
            widget.controller.selection = TextSelection.fromPosition(
              TextPosition(offset: widget.controller.text.length),
            );
          },
        ),
      ),
    );
  }
}
