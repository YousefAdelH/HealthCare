import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/features/expences/model/expences_model.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';
import 'package:dental_app/features/store/model/material_model.dart';
import 'package:dental_app/features/store/model/transction_model.dart';

class BadgetRepository {
  final FirebaseFirestore _firestore;

  BadgetRepository(this._firestore);

  Future<List<ExpenseModel>> getAllExpenses() async {
    QuerySnapshot expensesSnapshot =
        await _firestore.collection('expenses').get();
    return expensesSnapshot.docs.map((doc) {
      return ExpenseModel.fromDocument(doc);
    }).toList();
  }

  Future<List<MaterialTransaction>> getAllTransactions() async {
    QuerySnapshot transactionSnapshot =
        await _firestore.collection('transaction').get();
    return transactionSnapshot.docs.map((doc) {
      return MaterialTransaction.fromFirestore(
          doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<List<PatientModel>> getAllPatients() async {
    QuerySnapshot snapshot = await _firestore.collection('patient').get();
    return snapshot.docs.map((doc) {
      return PatientModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<DentalMaterial> getMaterial(String materialId) async {
    DocumentSnapshot doc =
        await _firestore.collection('storehouse').doc(materialId).get();
    return DentalMaterial.fromMap(
        doc.data() as Map<String, dynamic>, materialId);
  }
}
