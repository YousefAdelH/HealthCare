import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/common/custom_text_form_field.dart';
import 'package:dental_app/core/utlis/assets_paths.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/setting/controller/setting_controller.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppSettingMob extends StatelessWidget {
  final LocalizationController con = Get.put(LocalizationController());
  // final PaientDetailsCtrl con2 = Get.put(PaientDetailsCtrl());

  AppSettingMob();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.whiteF7,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: AppColors.black,
                  width: 1, // You can adjust the width as needed
                ),
              ),
              child: DropdownButton<Locale>(
                padding: EdgeInsetsDirectional.all(8),
                underline: Container(
                  height: 1,
                  color:
                      Colors.transparent, // Replace with your underline color
                ),
                borderRadius: BorderRadius.zero,
                icon: Icon(Icons.language, color: Colors.black),
                onChanged: (Locale? locale) {
                  if (locale != null) {
                    con.changeLocale(locale);
                  }
                },
                value: con.locale.value,
                items: const [
                  DropdownMenuItem(
                    value: Locale('en'),
                    child: Text('English'),
                  ),
                  DropdownMenuItem(
                    value: Locale('ar'),
                    child: Text('العربية'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CustomText(
                    text: S.of(context).specialForAddingOperations,
                    fontWeight: FontWeight.w700,
                    bolUnderline: false,
                    color: AppColors.black,
                    size: 18.sp,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextFormField(
                      controller: con.opnameController,
                      label: S.of(context).name,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextFormField(
                      controller: con.oppriceController,
                      label: S.of(context).price,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextFormField(
                      controller: con.costpriceController,
                      label: S.of(context).costprice,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.success2,
                      backgroundColor: AppColors.success2,
                      side: const BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: Size(150.w, 40.h),
                    ),
                    onPressed: () {
                      con.addOperation();
                    },
                    child: CustomText(
                      text: S.of(context).addanitem,
                      fontWeight: FontWeight.w500,
                      bolUnderline: false,
                      color: AppColors.whiteff,
                      size: 10.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.whiteF7,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: AppColors.black,
                          width: 1,
                        ),
                      ),
                      child: DropdownButton<String>(
                        padding: EdgeInsetsDirectional.all(8),
                        underline: Container(
                          height: 1,
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.zero,
                        icon: Icon(Icons.shopping_bag, color: Colors.black),
                        onChanged: (String? operationName) {
                          if (operationName != null) {
                            con.selectedOperation.value = con.operations
                                .firstWhere((operation) =>
                                    operation.name == operationName);
                          }
                        },
                        value: con.selectedOperation.value?.name ??
                            (con.operations.isNotEmpty
                                ? con.operations.first.name
                                : ""),
                        items: con.operations
                            .map<DropdownMenuItem<String>>((operation) {
                          return DropdownMenuItem<String>(
                            value: operation.name,
                            child: Text(
                                '${operation.name} (\$${operation.price!.toStringAsFixed(2)})'),
                          );
                        }).toList(),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.blueA1,
                      backgroundColor: AppColors.blueA1,
                      side: const BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: Size(150.w, 40.h),
                    ),
                    onPressed: () {
                      if (con.selectedOperation.value != null) {
                        con.deleteOperation(con.selectedOperation.value!.id!);
                      }
                    },
                    child: CustomText(
                      text: S.of(context).delete,
                      fontWeight: FontWeight.w500,
                      bolUnderline: false,
                      color: AppColors.whiteff,
                      size: 10.sp,
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 10.0),
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       foregroundColor: AppColors.reject,
                //       backgroundColor: AppColors.reject,
                //       side: const BorderSide(
                //         color: AppColors.primary,
                //         width: 2,
                //       ),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(12),
                //       ),
                //       minimumSize: Size(150.w, 40.h),
                //     ),
                //     onPressed: () {
                //       if (con2.selectedOperation.value != null) {
                //         var updatedOperation = OperationModel(
                //           id: con2.selectedOperation.value!.id,
                //           name: con2.opnameController.text,
                //           price: double.parse(con2.oppriceController.text),
                //           costPrice: con2.selectedOperation.value!.costPrice,
                //           priceGain: con2.selectedOperation.value!.priceGain,
                //           numOfTime: con2.selectedOperation.value!.numOfTime,
                //         );
                //         con2.updateOperation(updatedOperation);
                //       }
                //     },
                //     child: CustomText(
                //       text: "Update Operation",
                //       fontWeight: FontWeight.w500,
                //       bolUnderline: false,
                //       color: AppColors.whiteff,
                //       size: 10.sp,
                //     ),
                //   ),
                // ),
                // ScreenBadget()
              ],
            ),
          );
        }),
      ),
    );
  }
}
