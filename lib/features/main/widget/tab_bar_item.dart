import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/common/inkwell_.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/main/comtroller/main_controller.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class TapBarItem extends StatelessWidget {
  final String text;
  final int index;
  const TapBarItem({
    super.key,
    required this.text,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainCtrl>(
      init: MainCtrl(),
      builder: (con) {
        return InkWellCustom(
          onTap: () {
            con.changeIndex(index);
          },
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 6.h),
                child: CustomText(
                  textAlign: TextAlign.start,
                  text: text,
                  size: 19.sp,
                  fontWeight: FontWeight.bold,
                  height: 1,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
