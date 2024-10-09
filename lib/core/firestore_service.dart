import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';

class PatientService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference _membersCollection =
      FirebaseFirestore.instance.collection('patient');

  Future<PatientModel?> fetchPatientFromFirestore(String id) async {
    var docRef = _membersCollection.doc(id);
    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      var patientData = docSnapshot.data() as Map<String, dynamic>;
      return PatientModel.fromJson(patientData);
    } else {
      throw Exception("Patient not found");
    }
  }
}
