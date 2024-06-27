import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/common/custom_text_form_field.dart';
import 'package:dental_app/common/inkwell_.dart';
import 'package:dental_app/core/utlis/app_string.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/appointment/controller/appointmemt_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class AddNewPatient extends StatelessWidget {
  const AddNewPatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmemtCtrl>(
        init: AppointmemtCtrl(),
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
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: ListTile(
                            //     title: Text(con.selectedDate == null
                            //         ? AppStrings.selectDate
                            //         : '${AppStrings.date}: ${DateFormat('yyyy-MM-dd').format(con.selectedDate!)}'),
                            //     trailing: const Icon(Icons.calendar_today),
                            //     onTap: () async {
                            //       DateTime? picked = await showDatePicker(
                            //         context: context,
                            //         initialDate:
                            //             con.selectedDate ?? DateTime.now(),
                            //         firstDate: DateTime(2000),
                            //         lastDate: DateTime(2101),
                            //       );
                            //       if (picked != null &&
                            //           picked != con.selectedDate) {
                            //         con.setSelectedDate(picked);
                            //       }
                            //     },
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: ListTile(
                            //     title: Text(con.selectedTime == null
                            //         ? AppStrings.selectTime
                            //         : 'Time: ${con.selectedTime?.format(context)}'),
                            //     trailing: const Icon(Icons.access_time),
                            //     onTap: () async {
                            //       TimeOfDay? picked = await showTimePicker(
                            //         context: context,
                            //         initialTime:
                            //             con.selectedTime ?? TimeOfDay.now(),
                            //       );
                            //       if (picked != null &&
                            //           picked != con.selectedTime) {
                            //         con.setSelectedTime(picked);
                            //       }
                            //     },
                            //   ),
                            // ),
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
                                InkWellCustom(
                                  onTap: () =>
                                      con.showFullWidthBottomSheet(context),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    height: 80.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteff,
                                      borderRadius: BorderRadius.circular(18.0),
                                      border: Border.all(
                                        color: AppColors.primary,
                                        width:
                                            1, // You can adjust the width as needed
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Column(
                                        children: [
                                          const Icon(
                                            Icons.add,
                                            size: 30,
                                            color: AppColors.blueA1,
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          CustomText(
                                            text: 'Add New note',
                                            fontWeight: FontWeight.w500,
                                            bolUnderline: false,
                                            color: AppColors.blueA1,
                                            size: 10.sp,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
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
