import 'package:dental_app/common/custom_text_form_field.dart';
import 'package:dental_app/core/utlis/assets_paths.dart';
import 'package:dental_app/features/appointment/controller/appointmemt_controller.dart';
import 'package:dental_app/features/appointment/widget/calender_screen.dart';
import 'package:dental_app/features/appointment/widget/card_patient_appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:universal_io/io.dart';

class Appointment extends StatelessWidget {
  Appointment({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  final AppointmemtCtrl sessionController = Get.put(AppointmemtCtrl());

  @override
  Widget build(BuildContext context) {
    sessionController
        .searchSessionsOnDate(sessionController.selectedDate.value);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Obx(
              () {
                if (sessionController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (sessionController.errorMessage.isNotEmpty) {
                  return Center(
                      child: Text('Error: ${sessionController.errorMessage}'));
                } else if (sessionController.sessionsOnDate.isEmpty) {
                  return Center(child: Image.asset(AssetPath.pagenotfound2));
                } else {
                  return ListView.builder(
                    itemCount: sessionController.sessionsOnDate.length,
                    itemBuilder: (context, index) {
                      var sessionData = sessionController.sessionsOnDate[index];

                      return PatientCardAppointment(
                        item: sessionData,
                      );
                    },
                  );
                }
              },
            ),
          ),
          SizedBox(width: 20.w),
          (Platform.isAndroid)
              ? SizedBox()
              : Expanded(
                  flex: 1,
                  child: const Calenderscreen(),
                ),
        ],
      ),
    );
  }
}
