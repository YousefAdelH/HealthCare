import 'package:dental_app/core/utlis/app_string.dart';
import 'package:dental_app/core/utlis/helper_function.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';
import 'package:dental_app/features/patient/widget/card_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CardDates extends StatelessWidget {
  final PatientModel itemcard;
  const CardDates({
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
          if (itemcard.selectedSession!.time != null)
            DateCardInfo(
              icon: const Icon(Icons.access_time),
              title: AppStrings.time.tr,
              subtitle: itemcard.selectedSession!.time ?? "",
              minWidth: 100.w,
            ),
          const VerticalSeperated(),
          if (itemcard.selectedSession!.date != null)
            DateCardInfo(
              icon: const Icon(Icons.calendar_today),
              title: AppStrings.date.tr,
              subtitle:
                  HelperFunction.formatDate(itemcard.selectedSession!.date),
              minWidth: 100.w,
            ),
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