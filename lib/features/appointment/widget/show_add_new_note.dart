import 'package:dental_app/common/custom_text_form_field.dart';
import 'package:dental_app/core/utlis/app_string.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/appointment/controller/appointmemt_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';

class ShowAddNewNote extends StatelessWidget {
  const ShowAddNewNote({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmemtCtrl>(
        init: AppointmemtCtrl(),
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
                    title: Text(
                        '  ${con.sessionTime != null ? con.sessionTime!.format(context) : 'Select Session Time'}'),
                    trailing: Icon(Icons.access_time),
                    onTap: () async {
                      TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null && picked != con.sessionTime) {
                        con.setSessionTime(picked);
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextFormField(
                  label: AppStrings.sessionNote,
                  controller: con.sessionNoteController,
                  maxLines: 10,
                ),
              ),
            ],
          );
        });
  }
}
