import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/features/prescription/model/medication_model.dart';

class PrescriptionModel {
  final String id;
  final List<Medication> medication;
  final String instructions;
  final DateTime date;

  PrescriptionModel({
    required this.id,
    required this.medication,
    required this.instructions,
    required this.date,
  });

  // Factory method to create a PrescriptionModel from Firestore data
  factory PrescriptionModel.fromFirestore(
      Map<String, dynamic> data, String id) {
    return PrescriptionModel(
      id: id,
      medication: data['medication'] != null
          ? (data['medication'] as List)
              .map((item) =>
                  Medication.fromMap(item as Map<String, dynamic>, id))
              .toList()
          : [],
      instructions: data['instructions'],
      date: DateTime.parse(data['date']),
    );
  }
}
