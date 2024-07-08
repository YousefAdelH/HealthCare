import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/common/custom_text_form_field.dart';
import 'package:dental_app/core/utlis/app_string.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/patien_details/model/model_operations.dart';
import 'package:dental_app/features/setting/controller/setting_controller.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OperationSetting extends StatelessWidget {
  OperationSetting({Key? key}) : super(key: key);
  final LocalizationController con2 = Get.put(LocalizationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Obx(() {
            return Column(
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
                  width: MediaQuery.of(context).size.width / 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextFormField(
                      controller: con2.opnameController,
                      label: AppStrings.name,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextFormField(
                      controller: con2.oppriceController,
                      label: AppStrings.price,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextFormField(
                      controller: con2.costpriceController,
                      label: AppStrings.price,
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
                      con2.addOperation();
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
                            con2.selectedOperation.value = con2.operations
                                .firstWhere((operation) =>
                                    operation.name == operationName);
                          }
                        },
                        value: con2.selectedOperation.value?.name ??
                            (con2.operations.isNotEmpty
                                ? con2.operations.first.name
                                : ""),
                        items: con2.operations
                            .map<DropdownMenuItem<String>>((operation) {
                          return DropdownMenuItem<String>(
                            value: operation.name,
                            child: Text(
                                '${operation.name} (\$${operation.price.toStringAsFixed(2)})'),
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
                      if (con2.selectedOperation.value != null) {
                        con2.deleteOperation(con2.selectedOperation.value!.id);
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
              ],
            );
          }),
        ),
      ),
    );
  }
}
