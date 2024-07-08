import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package

class HelperFunction {
  static String formatDate(String? dateString) {
    if (dateString == null) {
      return '';
    }
    try {
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('yyyy-MM-dd').format(dateTime);
    } catch (e) {
      // Handle error if the date string is not in the expected format
      return dateString;
    }
  }

  static String remainingamount(String totalprice, String amount) {
    double total = double.tryParse(totalprice) ?? 0.0;
    double paid = double.tryParse(amount) ?? 0.0;
    return (total - paid).toStringAsFixed(2);
  }

  static String totalamount(String totalnew, String totalold) {
    double totaln = double.tryParse(totalnew) ?? 0.0;
    double totalo = double.tryParse(totalold) ?? 0.0;
    return (totaln + totalo).toStringAsFixed(2);
  }

  static TimeOfDay sessionTimeFromFormatted(
      String formattedTime, DateTime date) {
    List<String> timeParts = formattedTime.split(' ');
    String time = timeParts[0]; // "10:47"
    String period = timeParts[1]; // "AM" or "PM"

    List<String> timeComponents = time.split(':');
    int hour = int.parse(timeComponents[0]);
    int minute = int.parse(timeComponents[1]);

    if (period == 'PM' && hour != 12) {
      hour += 12;
    } else if (period == 'AM' && hour == 12) {
      hour = 0;
    }

    return TimeOfDay(hour: hour, minute: minute);
  }
}
