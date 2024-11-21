class Medication {
  String? medication;
  String? dosage;

  Medication({
    required this.medication,
    required this.dosage,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': medication,
      'dosage': dosage,
    };
  }

  // Factory method to create a PrescriptionModel from Firestore data
  factory Medication.fromMap(Map<String, dynamic> data, String id) {
    return Medication(
      medication: data['medication'] ?? "",
      dosage: data['dosage'] ?? "",
    );
  }
}
