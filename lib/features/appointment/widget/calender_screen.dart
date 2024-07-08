import 'dart:collection';

import 'package:dental_app/features/appointment/controller/appointmemt_controller.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class Calenderscreen extends StatefulWidget {
  const Calenderscreen({
    Key? key,
  }) : super(key: key);

  @override
  State<Calenderscreen> createState() => _CalenderscreenState();
}

final AppointmemtCtrl sessionController = Get.put(AppointmemtCtrl());
DateTime _selectedDate = DateTime.now();

class _CalenderscreenState extends State<Calenderscreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0),
      child: Obx(
        () => Column(
          children: [
            Text(
              S.of(context).selectDate +
                  ' ${_selectedDate.toLocal()}'.split(' ')[0],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TableCalendar(
              firstDay: DateTime(2000),
              lastDay: DateTime(2100),
              focusedDay: sessionController.selectedDate.value,
              selectedDayPredicate: (day) =>
                  isSameDay(sessionController.selectedDate.value, day),
              onDaySelected: (selectedDay, focusedDay) {
                sessionController.updateSelectedDate(selectedDay);
                print(selectedDay);
                print(focusedDay);
              },
              calendarStyle: const CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
