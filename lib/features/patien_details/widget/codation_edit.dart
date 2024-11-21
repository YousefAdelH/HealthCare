import 'dart:io';

import 'package:dental_app/common/custom_text_form_field.dart';
import 'package:dental_app/common/custom_text_type_field.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/patient/widget/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConditionalFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String value;

  final double widthFactor;
  final bool isVisible;

  const ConditionalFormField({
    Key? key,
    required this.controller,
    required this.label,
    required this.widthFactor,
    required this.isVisible,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isVisible) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * widthFactor,
        child: medcailInfo(
          widthFactor: widthFactor,
          subtitle: label,
          title: value ?? "",
          icone: const Icon(Icons.text_fields),
        ),
      );
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width * widthFactor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomTextFormField(
          controller: controller,
          label: label,
        ),
      ),
    );
  }
}

class ConditionalFormType extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String value;
  final Future<List<String>> Function(String) suggestionsCallback;
  final void Function(String) onSuggestionSelected;
  final double widthFactor;
  final bool isVisible;

  const ConditionalFormType({
    Key? key,
    required this.suggestionsCallback,
    required this.onSuggestionSelected,
    required this.controller,
    required this.label,
    required this.widthFactor,
    required this.isVisible,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isVisible) {
      return SizedBox(
        width: (Platform.isAndroid || Platform.isIOS)
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width * widthFactor,
        child: medcailInfo(
          widthFactor: widthFactor,
          subtitle: label,
          title: value ?? "",
          icone: const Icon(Icons.text_fields),
        ),
      );
    }
    return SizedBox(
      width: (Platform.isAndroid || Platform.isIOS)
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.width * widthFactor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomTypeAheadField(
            controller: controller,
            label: label,
            widthFactor: widthFactor,
            maxLines: 12,
            suggestionsCallback: suggestionsCallback,
            onSuggestionSelected: onSuggestionSelected),
      ),
    );
  }
}

class medcailInfo extends StatelessWidget {
  final String subtitle;
  final String title;
  final Widget icone;
  final double widthFactor;

  const medcailInfo({
    super.key,
    required this.subtitle,
    required this.title,
    required this.icone,
    required this.widthFactor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: SizedBox(
          height: 40.h,
          child: Row(
            children: [
              SizedBox(
                child: icone,
              ),
              SizedBox(width: 5.w),
              Text(
                subtitle,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 14.sp,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blueA1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
