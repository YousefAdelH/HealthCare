import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/common/custom_text_form_field.dart';
import 'package:dental_app/common/inkwell_.dart';
import 'package:dental_app/core/utlis/app_string.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/appointment/controller/appointmemt_controller.dart';
import 'package:dental_app/features/patient/controller/patient_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class AddNewPatient extends StatelessWidget {
  const AddNewPatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaientCtrl>(
        init: PaientCtrl(),
        builder: (con) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const Text(AppStrings.patient),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.transparent,
                child: SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomTextFormField(
                                  controller: con.nameController,
                                  label: AppStrings.name,
                                  // decoration: const InputDecoration(
                                  //     labelText: AppStrings.name),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteF7,
                                      borderRadius: BorderRadius.circular(18.0),
                                      border: Border.all(
                                        color: AppColors.primary,
                                        width:
                                            1, // You can adjust the width as needed
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DropdownButton<String>(
                                        borderRadius: BorderRadius.zero,
                                        dropdownColor: AppColors.whiteff,
                                        elevation: 0,
                                        underline: Container(
                                          height: 1,
                                          color: AppColors
                                              .whiteff, // Replace with your underline color
                                        ),
                                        value: con.selectedGender,
                                        onChanged: (String? newValue) {
                                          con.setSelectedGender(newValue!);
                                        },
                                        items: <String>[
                                          AppStrings.male,
                                          AppStrings.female
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        hint:
                                            const Text(AppStrings.selectGender),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomTextFormField(
                                  label: AppStrings.age,
                                  controller: con.ageController,

                                  // decoration: const InputDecoration(
                                  //     labelText: AppStrings.age),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomTextFormField(
                                  controller: con.numberController,
                                  label: AppStrings.number,
                                  // decoration: const InputDecoration(
                                  //     labelText: AppStrings.number),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomTextFormField(
                                  label: AppStrings.medicalhistory,
                                  maxLines: 10,
                                  controller: con.medicalhistoryController,
                                  // decoration: const InputDecoration(
                                  //     labelText: AppStrings.medicalhistory),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomTextFormField(
                                  label: AppStrings.totalAmount,
                                  controller: con.totalpriceController,
                                  // decoration: const InputDecoration(
                                  //     labelText: AppStrings.totalAmount),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomTextFormField(
                                  label: AppStrings.amountPaid,

                                  controller: con.amountController,
                                  // decoration: const InputDecoration(
                                  //     labelText: AppStrings.amountPaid),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: AppColors
                                          .success2, // Background color
                                      backgroundColor:
                                          AppColors.success2, // Text color
                                      side: const BorderSide(
                                          color: AppColors.primary,
                                          width: 2), // Border color and width
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            12), // Border radius
                                      ),
                                      minimumSize: Size(150.w, 80.h),
                                    ),
                                    onPressed: () {
                                      con.addMember(context);
                                    },
                                    child: CustomText(
                                      text: AppStrings.addPatient,
                                      fontWeight: FontWeight.w500,
                                      bolUnderline: false,
                                      color: AppColors.whiteff,
                                      size: 10.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
