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
