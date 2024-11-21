import 'package:dental_app/core/utlis/assets_paths.dart';
import 'package:dental_app/features/appointment/controller/appointmemt_controller.dart';
import 'package:dental_app/features/appointment/widget/calender_screen.dart';
import 'package:dental_app/features/appointment/widget/card_patient_appointment.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:universal_io/io.dart';

class Appointment extends StatelessWidget {
  Appointment({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  final AppointmemtCtrl sessionController = Get.put(AppointmemtCtrl());
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

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
                  return AnimatedList(
                    key: _listKey,
                    initialItemCount: sessionController.sessionsOnDate.length,
                    itemBuilder: (context, index, animation) {
                      var sessionData = sessionController.sessionsOnDate[index];
                      return _buildAnimatedItem(sessionData, animation);
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

  Widget _buildAnimatedItem(
      PatientModel sessionData, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(1, 0), // Slide from the right
          end: Offset.zero,
        ).animate(animation),
        child: PatientCardAppointment(
          item: sessionData,
        ),
      ),
    );
  }
}
