import 'package:dental_app/features/home/widget/bar_chart_group.dart';
import 'package:dental_app/features/home/widget/bit_chart.dart';
import 'package:dental_app/features/home/widget/circle_percent.dart';
import 'package:dental_app/features/home/widget/line_chart_sample.dart';
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
              SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 2,
                  child: BarChartSample6()),
              SizedBox(
                width: 50.w,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 2,
                  child: const PieChartSample2()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 3,
                child: LineChartmain(
                  isShowingMainData: true,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
