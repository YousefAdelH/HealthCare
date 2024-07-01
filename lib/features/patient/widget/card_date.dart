import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/core/utlis/app_string.dart';
import 'package:dental_app/core/utlis/helper_function.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EventCardDates extends StatelessWidget {
  final PatientModel itemcard;
  const EventCardDates({
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
            DateCardInfo(
              icon: const Icon(Icons.access_time),
              title: AppStrings.time.tr,
              subtitle: itemcard.session!.last.time ?? "",
              minWidth: 100.w,
            ),
            const VerticalSeperated(),
            DateCardInfo(
              icon: const Icon(Icons.calendar_today),
              title: AppStrings.date.tr,
              subtitle: HelperFunction.formatDate(itemcard.session!.last.date!),
              minWidth: 100.w,
            ),
          ] else
            Text("No session"),
          const VerticalSeperated(),
          DateCardInfo(
            title: AppStrings.age,
            subtitle: itemcard.age ?? "",
            icon: Icon(Icons.person),
          ),
          const SizedBox(width: 1),
          DateCardInfo(
            icon: const Icon(Icons.phone),
            title: AppStrings.number,
            subtitle: itemcard.number ?? "",
          ),
        ],
      ),
    );
  }
}

class DateCardInfo extends StatelessWidget {
  final String title;
  final String? titleHint;
  final String subtitle;
  final Color? subtitleColor;
  final double? minWidth;
  final Widget icon;
  const DateCardInfo(
      {super.key,
      required this.title,
      required this.subtitle,
      this.subtitleColor,
      this.minWidth,
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
              size: 12.sp,
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
          size: 10.sp,
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
      height: 36.h,
    );
  }
}
