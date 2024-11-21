import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/core/error/model/custom_exceptions.dart';
import 'package:dental_app/features/expences/model/expences_model.dart';

class ExpenseRepository {
  final FirebaseFirestore _firestore;

  ExpenseRepository(this._firestore);

  Stream<List<ExpenseModel>> getExpensesStream() {
    try {
      return _firestore.collection('expenses').snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => ExpenseModel.fromDocument(doc))
            .toList();
      });
    } catch (e) {
      throw DatabaseException('Failed to fetch expenses');
    }
  }

  Future<void> addExpense(ExpenseModel expense) async {
    try {
      await _firestore.collection('expenses').add(expense.toMap());
    } catch (e) {
      throw DatabaseException('Failed to add expense');
    }
  }

  Future<void> deleteExpense(String id) async {
    try {
      await _firestore.collection('expenses').doc(id).delete();
    } catch (e) {
      throw DatabaseException('Failed to delete expense');
    }
  }

  Future<void> updateExpense(ExpenseModel expense) async {
    try {
      await _firestore
          .collection('expenses')
          .doc(expense.id)
          .update(expense.toMap());
    } catch (e) {
      throw DatabaseException('Failed to update expense');
    }
  }
}
