import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calenderscreen extends StatefulWidget {
  const Calenderscreen({
    Key? key,
  }) : super(key: key);

  @override
  State<Calenderscreen> createState() => _CalenderscreenState();
}

DateTime _selectedDate = DateTime.now();

class _CalenderscreenState extends State<Calenderscreen> {
  @override
  Widget build(BuildContext context) {
    // final _events = LinkedHashMap<DateTime, List>(
    //   hashCode: getHashCode,
    // )..addAll(_eventsList);

    // List getEventForDay(DateTime day) {
    //   // Filter events for the selected day
    //   List eventsForDay = _events.entries
    //       .where((entry) => isSameDay(entry.key, day))
    //       .map((entry) => entry.value)
    //       .expand((events) => events)
    //       .toList();

    //   return eventsForDay;
    // }

    return Padding(
      padding: const EdgeInsets.only(left: 50.0),
      child: Column(
        children: [
          Text(
            'Selected Date: ${_selectedDate.toLocal()}'.split(' ')[0],
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TableCalendar(
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            focusedDay: _selectedDate,
            selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
              });
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
