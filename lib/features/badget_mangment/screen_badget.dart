import 'package:dental_app/common/button_large.dart';
import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/common/inkwell_.dart';
import 'package:dental_app/core/utlis/assets_paths.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/badget_mangment/controller/badget_controller.dart';
import 'package:dental_app/features/badget_mangment/controller/new_controller.dart';
import 'package:dental_app/features/home/widget/bit_chart.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ScreenBadget extends StatelessWidget {
  const ScreenBadget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BadgetCtrl>(
      init: BadgetCtrl(),
      builder: (con) {
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
            body: Obx(() {
              return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 40.h,
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor:
                                    AppColors.primary, // Background color
                                backgroundColor: Colors.white, // Text color
                                side: const BorderSide(
                                    color: AppColors.primary,
                                    width: 2), // Border color and width
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      12), // Border radius
                                ),
                                // minimumSize: Size(150.w, 60.h),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.filter_alt_sharp),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(S.of(context).selectBudgetPeriod),
                                  // S.of(context).addPatient
                                ],
                              ),
                              onPressed: () => con.showScreenFilter(context),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 100.h,
                        ),
                        con.isLoading.value
                            ? Center(child: CircularProgressIndicator())
                            : Column(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    margin: const EdgeInsets.all(10),
                                    child: Table(
                                      columnWidths: const {
                                        0: FixedColumnWidth(50.0),
                                        1: FlexColumnWidth(2),
                                        2: FlexColumnWidth(1),
                                      },
                                      border: TableBorder.symmetric(
                                        inside: BorderSide.none,
                                        outside: const BorderSide(
                                            color: Colors.transparent),
                                      ),
                                      children: [
                                        TableRow(
                                          children: [
                                            const SizedBox(),
                                            CustomText(
                                              text: S.of(context).description,
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black,
                                              size: 15.sp,
                                            ),
                                            CustomText(
                                              text: S.of(context).value,
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black,
                                              size: 15.sp,
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(7.0),
                                              color: AppColors.primary,
                                              child: Image.asset(
                                                AssetPath.patient,
                                                height: 33.h,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              color: AppColors.blue2,
                                              child: CustomText(
                                                text: S
                                                    .of(context)
                                                    .totalPricePatient,
                                                textAlign: TextAlign.center,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.black,
                                                size: 15.sp,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              color: AppColors.blue2,
                                              child: CustomText(
                                                text: con
                                                    .totalpatientprice.value
                                                    .toStringAsFixed(2),
                                                textAlign: TextAlign.center,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.black,
                                                size: 15.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            Container(
                                              color: AppColors.primary,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                AssetPath.expenses,
                                                height: 33.h,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              color: AppColors.blue3,
                                              child: CustomText(
                                                text: S
                                                    .of(context)
                                                    .totalPriceExpenses,
                                                textAlign: TextAlign.center,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.black,
                                                size: 15.sp,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              color: AppColors.blue3,
                                              child: CustomText(
                                                text: con
                                                    .totalExpensesPrice.value
                                                    .toStringAsFixed(2),
                                                textAlign: TextAlign.center,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.black,
                                                size: 15.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              color: AppColors.primary,
                                              child: Image.asset(
                                                AssetPath.matrial,
                                                height: 33.h,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              color: AppColors.blue4,
                                              child: CustomText(
                                                text: S
                                                    .of(context)
                                                    .totalPriceMaterial,
                                                textAlign: TextAlign.center,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.black,
                                                size: 15.sp,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              color: AppColors.blue4,
                                              child: CustomText(
                                                text: con
                                                    .totalTransactionPrice.value
                                                    .toStringAsFixed(2),
                                                textAlign: TextAlign.center,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.black,
                                                size: 15.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              color: AppColors.primary,
                                              child: Image.asset(
                                                AssetPath.netprofit,
                                                height: 33.h,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              color: AppColors.matchblue,
                                              child: CustomText(
                                                text: S.of(context).netProfit,
                                                textAlign: TextAlign.center,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.black,
                                                size: 15.sp,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              color: AppColors.matchblue,
                                              child: CustomText(
                                                text: con.netProfit.value
                                                    .toStringAsFixed(2),
                                                textAlign: TextAlign.center,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.black,
                                                size: 15.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50.h,
                                  ),
                                  Container(
                                    height: 200.h,
                                    width: 200.h,
                                    child: PieChart(
                                      PieChartData(
                                        sections: [
                                          PieChartSectionData(
                                            titlePositionPercentageOffset: 0.55,
                                            color: AppColors.blue2,
                                            title:
                                                con.totalpatientprice.value == 0
                                                    ? S.of(context).zeroPercent
                                                    : con.calculatePercentage(
                                                        con.totalpatientprice
                                                            .value),
                                          ),
                                          PieChartSectionData(
                                            titlePositionPercentageOffset: 0.55,
                                            color: AppColors.blue3,
                                            title: con.totalExpensesPrice
                                                        .value ==
                                                    0
                                                ? S.of(context).zeroPercent
                                                : con.calculatePercentage(con
                                                    .totalExpensesPrice.value),
                                          ),
                                          PieChartSectionData(
                                            titlePositionPercentageOffset: 0.55,
                                            color: AppColors.blue4,
                                            title: con.totalTransactionPrice
                                                        .value ==
                                                    0
                                                ? S.of(context).zeroPercent
                                                : con.calculatePercentage(con
                                                    .totalTransactionPrice
                                                    .value),
                                          ),
                                          PieChartSectionData(
                                            titlePositionPercentageOffset: 0.55,
                                            color: AppColors.matchblue,
                                            title: con.netProfit.value == 0
                                                ? S.of(context).zeroPercent
                                                : con.calculatePercentage(
                                                    con.netProfit.value),
                                          ),
                                        ],
                                        sectionsSpace: 2,
                                        centerSpaceRadius: 50,
                                        borderData: FlBorderData(show: false),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      child: PieChartOperation()),
                                ],
                              ),
                      ],
                    ),
                  ));
            }),
          )
        ]));
      },
    );
  }
}
