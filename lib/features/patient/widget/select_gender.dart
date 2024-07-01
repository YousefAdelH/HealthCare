import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectGender extends StatelessWidget {
  final String text;

  const SelectGender({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.r),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 4.w),
          CustomText(
            text: text,
            size: 11.sp,
            color: AppColors.black,
          )
        ],
      ),
    );
  }
}
