import 'package:dental_app/core/utlis/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LineTapBar extends StatelessWidget {
  final int index;
  const LineTapBar({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: leftGrey(),
          height: 1.h,
          color: AppColors.grayotp,
        ),
        Container(
          width: index == 1 ? 70.w : 55.w,
          height: 2.h,
          color: AppColors.primary,
        ),
      ],
    );
  }

  double leftGrey() {
    if (index == 0) {
      return 4.w;
    } else if (index == 1) {
      return 100.w;
    }
    return 165.w;
  }
}
