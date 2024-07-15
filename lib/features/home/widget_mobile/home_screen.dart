import 'package:dental_app/core/utlis/assets_paths.dart';
import 'package:dental_app/features/badget_mangment/controller/badget_controller.dart';
import 'package:dental_app/features/home/widget/badget_line.dart';
import 'package:dental_app/features/home/widget/bar_chart_group.dart';
import 'package:dental_app/features/home/widget/bit_chart.dart';
import 'package:dental_app/features/home/widget/circle_percent.dart';
import 'package:dental_app/features/home/widget/line_chart_sample.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeScreenMobile extends StatelessWidget {
  HomeScreenMobile({Key? key}) : super(key: key);
  // final BadgetCtrl controller = Get.put(BadgetCtrl());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: [
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
              AssetPath.background2), // Your background image asset path
          fit: BoxFit.contain,
        )),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //     width: MediaQuery.of(context).size.width / 3,
                  //     height: MediaQuery.of(context).size.height / 2,
                  //     child: BarChartSample6()),
                  // SizedBox(
                  //   width: 30.w,
                  // ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 2,
                      child: PieChartOperation()),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SizedBox(
              //       width: MediaQuery.of(context).size.width / 2,
              //       height: MediaQuery.of(context).size.height / 3,
              //       child:
              //           //  Obx(() {
              //           //   return controller.totalPatients.isEmpty
              //           //       ? Center(child: CircularProgressIndicator())
              //           //       : Linebadget(
              //           //           patientsData: controller.totalPatients.value,
              //           //           expensesData: controller.totalExpenses.value,
              //           //           transactionsData: controller.totalMaterial.value,
              //           //         );
              //           // }),
              //           LineChartmain(
              //         isShowingMainData: true,
              //       ),
              //     )
              //   ],
              // )
            ],
          ),
        ),
      ),
    ]));
  }
}
