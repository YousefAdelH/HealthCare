import 'package:cloud_firestore/cloud_firestore.dart';

class MaterialTransaction {
  String id;
  String materialId;
  DateTime date;
  int quantity;
  bool isIncoming;

  MaterialTransaction({
    required this.id,
    required this.materialId,
    required this.date,
    required this.quantity,
    required this.isIncoming,
  });

  factory MaterialTransaction.fromFirestore(Map<String, dynamic> data) {
    return MaterialTransaction(
      id: data['id'],
      materialId: data['materialId'],
      date: (data['date'] as Timestamp).toDate(),
      quantity: data['quantity'],
      isIncoming: data['isIncoming'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'materialId': materialId,
      'date': date,
      'quantity': quantity,
      'isIncoming': isIncoming,
    };
  }
}
