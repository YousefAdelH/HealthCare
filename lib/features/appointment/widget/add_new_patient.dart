import 'package:dental_app/common/custom_text_form_field.dart';
import 'package:dental_app/core/utlis/app_string.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/appointment/controller/appointmemt_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';

class AddNewPatient extends StatelessWidget {
  const AddNewPatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmemtCtrl>(
        init: AppointmemtCtrl(),
        builder: (con) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.bluewhite,
              title: const Text(AppStrings.patient),
            ),
            body: Container(
              color: AppColors.bluewhite,
              child: SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextFormField(
                              controller: con.nameController,
                              label: AppStrings.name,
                              // decoration: const InputDecoration(
                              //     labelText: AppStrings.name),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                DropdownButton<String>(
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
                                  hint: const Text(AppStrings.selectGender),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextFormField(
                              label: AppStrings.age,
                              controller: con.ageController,

                              // decoration: const InputDecoration(
                              //     labelText: AppStrings.age),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextFormField(
                              controller: con.numberController,
                              label: AppStrings.number,
                              // decoration: const InputDecoration(
                              //     labelText: AppStrings.number),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextFormField(
                              label: AppStrings.medicalhistory,
                              maxLines: 10,
                              controller: con.medicalhistoryController,
                              // decoration: const InputDecoration(
                              //     labelText: AppStrings.medicalhistory),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(con.selectedDate == null
                                  ? AppStrings.selectDate
                                  : '${AppStrings.date}: ${DateFormat('yyyy-MM-dd').format(con.selectedDate!)}'),
                              trailing: const Icon(Icons.calendar_today),
                              onTap: () async {
                                DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate:
                                      con.selectedDate ?? DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (picked != null &&
                                    picked != con.selectedDate) {
                                  con.setSelectedDate(picked);
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(con.selectedTime == null
                                  ? AppStrings.selectTime
                                  : 'Time: ${con.selectedTime?.format(context)}'),
                              trailing: const Icon(Icons.access_time),
                              onTap: () async {
                                TimeOfDay? picked = await showTimePicker(
                                  context: context,
                                  initialTime:
                                      con.selectedTime ?? TimeOfDay.now(),
                                );
                                if (picked != null &&
                                    picked != con.selectedTime) {
                                  con.setSelectedTime(picked);
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextFormField(
                              label: AppStrings.totalAmount,
                              controller: con.totalpriceController,
                              // decoration: const InputDecoration(
                              //     labelText: AppStrings.totalAmount),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextFormField(
                              label: AppStrings.amountPaid,

                              controller: con.amountController,
                              // decoration: const InputDecoration(
                              //     labelText: AppStrings.amountPaid),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              con.addMember(context);
                            },
                            child: const Text(AppStrings.addPatient),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20.w),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
