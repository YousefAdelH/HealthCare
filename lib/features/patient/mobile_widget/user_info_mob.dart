import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserInfoMob extends StatelessWidget {
  final String subtitle;
  final String title;
  final Widget icone;

  const UserInfoMob({
    super.key,
    required this.subtitle,
    required this.title,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
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
              size: 8.sp,
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
              size: 10.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.blueA1,
              underLineColor: AppColors.whiteff,
            ),
          ],
        ),
      ),
    );
  }
}
