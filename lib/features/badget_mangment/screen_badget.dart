import 'package:dental_app/common/button_large.dart';
import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/common/inkwell_.dart';
import 'package:dental_app/core/utlis/assets_paths.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/badget_mangment/controller/badget_controller.dart';
import 'package:dental_app/generated/l10n.dart';
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
                              borderRadius:
                                  BorderRadius.circular(12), // Border radius
                            ),
                            // minimumSize: Size(150.w, 60.h),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.filter_alt_sharp),
                              SizedBox(
                                width: 5.w,
                              ),
                              const Text("Select a period for the budget"),
                              // S.of(context).addPatient
                            ],
                          ),
                          onPressed: () => con.showScreenFilter(context),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 150.h,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      margin: const EdgeInsets.all(10),
                      child: Table(
                        columnWidths: const {
                          0: FixedColumnWidth(
                              50.0), // Width for the first column
                          1: FlexColumnWidth(2), // Width for the second column
                          2: FlexColumnWidth(1), // Width for the third column
                        },
                        border: TableBorder.symmetric(
                          inside: BorderSide.none,
                          outside: const BorderSide(color: Colors.transparent),
                        ),
                        children: [
                          TableRow(
                            children: [
                              const SizedBox(),
                              CustomText(
                                text: 'Description',
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                                size: 15.sp,
                              ),
                              CustomText(
                                text: 'Value',
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
                                padding: const EdgeInsets.all(7.0),
                                color:
                                    AppColors.primary, // Add your desired color
                                child: Image.asset(
                                  AssetPath
                                      .patient, // Replace with your image path
                                  height: 33.h, // Adjust the height as needed
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                color: AppColors.blue2,
                                child: CustomText(
                                  text: 'Total price patient',
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                  size: 15.sp,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                color: AppColors.blue2,
                                child: CustomText(
                                  text: con.totalpatientprice.value
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
                                padding: const EdgeInsets.all(
                                    8.0), // Add your desired color
                                child: Image.asset(
                                  AssetPath
                                      .expenses, // Replace with your image path
                                  height: 33.h, // Adjust the height as needed
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                color: AppColors.blue3,
                                child: CustomText(
                                  text: 'Total price expenses',
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                  size: 15.sp,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                color: AppColors.blue3,
                                child: CustomText(
                                  text: con.totalExpensesPrice.value
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
                                padding: const EdgeInsets.all(8.0),
                                color:
                                    AppColors.primary, // Add your desired color
                                child: Image.asset(
                                  AssetPath
                                      .matrial, // Replace with your image path
                                  height: 33.h, // Adjust the height as needed
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                color: AppColors.blue4,
                                child: CustomText(
                                  text: 'Total price material',
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                  size: 15.sp,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                color: AppColors.blue4,
                                child: CustomText(
                                  text: con.totalTransactionPrice.value
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
                                padding: const EdgeInsets.all(8.0),
                                color:
                                    AppColors.primary, // Add your desired color
                                child: Image.asset(
                                  AssetPath
                                      .netprofit, // Replace with your image path
                                  height: 33.h, // Adjust the height as needed
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                color: AppColors.matchblue,
                                child: CustomText(
                                  text: 'Net profit',
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                  size: 15.sp,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                color: AppColors.matchblue,
                                child: CustomText(
                                  text: con.netProfit.value.toStringAsFixed(2),
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
                  ],
                ),
              );
            }),
          )
        ]));
      },
    );
  }
}
