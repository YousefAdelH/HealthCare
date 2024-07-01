import 'package:dental_app/common/custom_text_form_field.dart';
import 'package:dental_app/core/utlis/app_string.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/appointment/controller/appointmemt_controller.dart';
import 'package:dental_app/features/patien_details/controller/patient_details_controller.dart';
import 'package:dental_app/features/patient/controller/patient_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';

class ShowAddNewNote extends StatelessWidget {
  final String id;
  const ShowAddNewNote({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaientDetailsCtrl>(
        init: PaientDetailsCtrl(),
        builder: (con) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteF7,
                    borderRadius: BorderRadius.circular(18.0),
                    border: Border.all(
                      color: AppColors.primary,
                      width: 1.w, // You can adjust the width as needed
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                        '  ${con.sessionDate != null ? DateFormat.yMd().format(con.sessionDate!) : 'Select Session Date'}'),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != con.sessionDate) {
                        con.setSessionDate(picked);
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteF7,
                    borderRadius: BorderRadius.circular(18.0),
                    border: Border.all(
                      color: AppColors.primary,
                      width: 1.w, // You can adjust the width as neede
                    ),
                  ),
                  child: ListTile(
                    title: Text(con.sessionTime == null
                        ? AppStrings.selectTime
                        : 'Time: ${con.sessionTime?.format(context)}'),
                    trailing: const Icon(Icons.access_time),
                    onTap: () async {
                      TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: con.sessionTime ?? TimeOfDay.now(),
                      );
                      if (picked != null && picked != con.sessionTime) {
                        con.setSessionTime(picked);
                      }
                    },
                  ),
                ),
              ),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextFormField(
                  label: AppStrings.sessionNote,
                  controller: con.sessionNoteController,
                  maxLines: 10,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 100.w,
                      child: CustomTextFormField(
                        label: AppStrings.price,
                        controller: con.sessionPriceController,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
