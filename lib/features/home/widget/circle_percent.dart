import 'package:dental_app/core/utlis/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CirclePercentAmount extends StatelessWidget {
  final int amount;
  final int total;
  final Color? backColor;
  const CirclePercentAmount({
    super.key,
    required this.amount,
    required this.total,
    this.backColor,
  });

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: AppColors.secondary,
      backgroundColor: Colors.black,
      backgroundWidth: 10.0,
      radius: 80.0,
      lineWidth: 5.0,
      animation: true,
      percent: amount / total,
      center: RichText(
        text: TextSpan(
          text: "$amount",
          style: TextStyle(
            fontFamily: AppFontNames.outfit,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.white94,
          ),
          children: [
            TextSpan(
              text: "/",
              style: TextStyle(
                fontFamily: AppFontNames.outfit,
                fontSize: 8.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.white94,
              ),
            ),
            TextSpan(
              text: "$total",
              style: TextStyle(
                fontFamily: AppFontNames.outfit,
                fontSize: 8.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.white94,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
