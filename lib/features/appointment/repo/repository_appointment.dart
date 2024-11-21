import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/core/error/model/custom_exceptions.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';
import 'package:intl/intl.dart';

class AppointmentRepository {
  final FirebaseFirestore _firestore;

  AppointmentRepository(this._firestore);

  Future<List<PatientModel>> getSessionsOnDate(DateTime date) async {
    List<PatientModel> sessions = [];
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    try {
      QuerySnapshot patientsSnapshot =
          await _firestore.collection('patient').get();
      for (var doc in patientsSnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        var patient = PatientModel.fromJson(data);

        if (patient.session != null) {
          for (var session in patient.session!) {
            if (session.date == formattedDate) {
              sessions.add(patient.copyWithSelectedSession(session));
            }
          }
        }
      }
    } catch (e) {
      throw DatabaseException('Failed to fetch expenses');
    }

    return sessions;
  }
}
