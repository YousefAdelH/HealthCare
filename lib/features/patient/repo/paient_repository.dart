import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/core/error/error_handle.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';

class PatientRepository {
  final FirebaseFirestore _firestore;

  PatientRepository(this._firestore);

  // Use _firestore directly without .instance
  CollectionReference get patientsCollection =>
      _firestore.collection('patient');

  Future<Map<String, dynamic>> fetchPatients({
    DocumentSnapshot? lastDocument,
    int limit = 5,
  }) async {
    try {
      // Start the query and apply startAfterDocument if lastDocument is provided
      Query query = patientsCollection.orderBy('name').limit(limit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      // Execute the query and map the results to PatientModel
      // final querySnapshot = await query.get();
      // querySnapshot.docs.map((doc) {
      //   PatientModel.fromJson(doc.data() as Map<String, dynamic>);
      // }).toList();
      final querySnapshot = await query.get();
      final patients = querySnapshot.docs.map((doc) {
        return PatientModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      return {
        'patients': patients,
        'lastDocument':
            querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null,
      };
    } on FirebaseException catch (e) {
      ErrorHandler.showError("Error fetching patients: ${e.message}");
      return {
        'patients': [],
        'lastDocument': null,
      };
    } catch (e) {
      ErrorHandler.showError("Unknown error occurred while fetching patients");
      return {
        'patients': [],
        'lastDocument': null,
      };
    }
  }

  Future<void> addPatient(PatientModel patient) async {
    try {
      // Add the patient document to Firestore
      await patientsCollection.doc(patient.id).set(patient.toJson());
    } on FirebaseException catch (e) {
      ErrorHandler.showError("Error adding patient: ${e.message}");
    } catch (e) {
      ErrorHandler.showError("Unknown error occurred while adding patient");
    }
  }

  Future<void> deletePatient(String patientId) async {
    try {
      await patientsCollection.doc(patientId).delete();
    } on FirebaseException catch (e) {
      ErrorHandler.showError("Error deleting patient: ${e.message}");
    } catch (e) {
      ErrorHandler.showError("Unknown error occurred while deleting patient");
    }
  }

  Future<List<PatientModel>> searchPatients(String searchTerm) async {
    // Search by name
    Query nameQuery = patientsCollection
        .where('name', isGreaterThanOrEqualTo: searchTerm)
        .where('name', isLessThan: searchTerm + 'z');

    // Search by code
    Query codeQuery = patientsCollection
        .where('code', isGreaterThanOrEqualTo: searchTerm)
        .where('code', isLessThan: searchTerm + 'z');

    // Execute both queries
    final nameQuerySnapshot = await nameQuery.get();
    final codeQuerySnapshot = await codeQuery.get();

    // Store unique results
    Set<String> patientIds = {};
    List<PatientModel> searchedPatients = [];

    // Process name query results
    for (var doc in nameQuerySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      PatientModel patient = PatientModel.fromJson(data);
      if (patientIds.add(patient.id!)) {
        searchedPatients.add(patient);
      }
    }

    // Process code query results
    for (var doc in codeQuerySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      PatientModel patient = PatientModel.fromJson(data);
      if (patientIds.add(patient.id!)) {
        searchedPatients.add(patient);
      }
    }

    return searchedPatients;
  }
}
