import 'package:dental_app/features/home/widget/circle_percent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 50.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CirclePercentAmount(
                total: 70000,
                amount: 9000,
                backColor: Colors.black,
              ),
              SizedBox(
                width: 50.w,
              ),
              const CirclePercentAmount(
                total: 15,
                amount: 9,
              )
            ],
          ),
        ],
      ),
    );
  }
}
