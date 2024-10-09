import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserInfo2 extends StatelessWidget {
  final String subtitle;
  final String title;
  final Widget icone;
  final double size;

  const UserInfo2({
    super.key,
    required this.subtitle,
    required this.title,
    required this.icone,
    this.size = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          SizedBox(
            child: icone,
          ),
          SizedBox(
            width: 5.w,
          ),
          CustomText(
            text: subtitle,
            size: size.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
            underline: false,
            underLineColor: AppColors.whiteff,
          ),
          SizedBox(
            width: 10.w,
          ),
          CustomText(
            text: title,
            size: size.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
            underLineColor: AppColors.whiteff,
          ),
        ],
      ),
    );
  }
}
