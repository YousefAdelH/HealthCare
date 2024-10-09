import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/appointment/controller/appointmemt_controller.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalenderscreenMob extends StatefulWidget {
  const CalenderscreenMob({Key? key}) : super(key: key);

  @override
  State<CalenderscreenMob> createState() => _CalenderscreenMobState();
}

final AppointmemtCtrl sessionController = Get.put(AppointmemtCtrl());
DateTime _selectedDate = DateTime.now();

class _CalenderscreenMobState extends State<CalenderscreenMob> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        color: Colors.transparent,
        child: Column(
          children: [
            EasyDateTimeLine(
              initialDate: sessionController.selectedDate.value,
              onDateChange: (date) {
                sessionController.updateSelectedDate(date);
              },
              dayProps: const EasyDayProps(
                  todayStyle: DayStyle(
                      dayStrStyle: TextStyle(color: Colors.black),
                      monthStrStyle: TextStyle(color: Colors.black)),
                  inactiveDayStyle: DayStyle(
                      dayStrStyle: TextStyle(color: Colors.black),
                      monthStrStyle: TextStyle(color: Colors.black))),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
