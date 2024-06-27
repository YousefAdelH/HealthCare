import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/common/custom_text_form_field.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatientSessionItem extends StatelessWidget {
  var textBoxhController = TextEditingController();
  PatientSessionItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.whiteff,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4.0,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "session 1 ",
                  size: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                  underLineColor: AppColors.whiteff,
                ),
                Row(
                  children: [
                    CustomText(
                      text: "12:00",
                      size: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                      underLineColor: AppColors.whiteff,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    CustomText(
                      text: "11/7/2024",
                      size: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                      underLineColor: AppColors.whiteff,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 10.w,
            ),
            CustomText(
              text: "Notes",
              size: 13.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
              underLineColor: AppColors.whiteff,
            ),
            SizedBox(
              height: 10.w,
            ),
            CustomTextFormField(
              label: "Enter your notes here",
              controller: textBoxhController,
              maxLines: 6,
            ),
          ],
        ),
      ),
    );
  }
}
