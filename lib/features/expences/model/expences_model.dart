import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseModel {
  String id;
  String name;
  String date;
  String type;
  String? expensesPrice;

  ExpenseModel(
      {required this.id,
      required this.name,
      required this.date,
      required this.type,
      this.expensesPrice});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
      'type': type,
      'expensesPrice': expensesPrice,
    };
  }

  double calculateTotalPrice(DateTime startDate, DateTime endDate) {
    if (expensesPrice == null) return 0.0;

    double total = 0.0;
    DateTime adjustedStartDate =
        DateTime(startDate.year, startDate.month, startDate.day);
    DateTime adjustedEndDate =
        DateTime(endDate.year, endDate.month, endDate.day)
            .add(Duration(days: 1));

    DateTime? sessionDate = DateTime.tryParse(date ?? "");
    if (sessionDate != null) {
      DateTime adjustedSessionDate =
          DateTime(sessionDate.year, sessionDate.month, sessionDate.day);
      if (adjustedSessionDate.isAfter(adjustedStartDate) &&
          adjustedSessionDate.isBefore(adjustedEndDate)) {
        double price = double.tryParse(expensesPrice ?? "0.0") ?? 0.0;
        total += price;
      }
    }

    return total;
  }

  factory ExpenseModel.fromDocument(DocumentSnapshot doc) {
    return ExpenseModel(
      id: doc.id,
      name: doc['name'],
      date: doc['date'],
      type: doc['type'],
      expensesPrice: doc['expensesPrice'],
    );
  }
}
