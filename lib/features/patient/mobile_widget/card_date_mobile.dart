import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/core/utlis/app_string.dart';
import 'package:dental_app/core/utlis/helper_function.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MobileCardDates extends StatelessWidget {
  final PatientModel itemcard;
  const MobileCardDates({
    super.key,
    required this.itemcard,
    // required this.session,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteff,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.all(6.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (itemcard.session != null && itemcard.session!.isNotEmpty) ...[
            DateCardInfoMob(
              icon: const Icon(
                Icons.access_time,
                size: 10,
              ),
              title: AppStrings.time.tr,
              subtitle: itemcard.session!.last.time ?? "",
            ),
            const VerticalSeperated(),
            DateCardInfoMob(
              icon: const Icon(Icons.calendar_today, size: 10),
              title: AppStrings.date.tr,
              subtitle: HelperFunction.formatDate(itemcard.session!.last.date!),
            ),
          ] else
            Text("No session"),
        ],
      ),
    );
  }
}

class DateCardInfoMob extends StatelessWidget {
  final String title;
  final String? titleHint;
  final String subtitle;
  final Color? subtitleColor;

  final Widget icon;
  const DateCardInfoMob(
      {super.key,
      required this.title,
      required this.subtitle,
      this.subtitleColor,
      this.titleHint,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              child: icon,
            ),
            SizedBox(
              width: 5.w,
            ),
            CustomText(
              text: title,
              color: AppColors.black,
              size: 10.sp,
              fontWeight: FontWeight.w400,
              height: 1,
            ),
          ],
        ),
        SizedBox(
          height: 7.h,
        ),
        CustomText(
          text: subtitle,
          color: subtitleColor ?? AppColors.black,
          size: 8.sp,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}

class VerticalSeperated extends StatelessWidget {
  const VerticalSeperated({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1F1F1F),
      width: 1,
      height: 20.h,
    );
  }
}
