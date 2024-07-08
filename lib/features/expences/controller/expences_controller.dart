import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/core/utlis/helper_function.dart';
import 'package:dental_app/features/expences/model/expences_model.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ExpenseController extends GetxController {
  var expenses = <ExpenseModel>[].obs;
  var isLoading = true.obs;
  var expensesname = ''.obs;
  var expensesdate = DateTime.now().obs;
  var expensestype = ''.obs;
  var expensesPrice = TextEditingController();
  var filteredExpenses = <ExpenseModel>[].obs;
  var selectFilter = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    fetchExpenses();
    super.onInit();
  }

//  void fetchMaterials() {
//     _db.collection('storehouse').snapshots().listen((snapshot) {
//       materials.value = snapshot.docs
//           .map((doc) => DentalMaterial.fromMap(doc.data(), doc.id))
//           .toList();
//       isLoading.value = false;
//     });
//   }
  Future<void> fetchExpenses() async {
    await _firestore.collection('expenses').snapshots().listen((snapshot) {
      expenses.value =
          snapshot.docs.map((doc) => ExpenseModel.fromDocument(doc)).toList();
      isLoading.value = false;
    });
    // await _firestore.collection('expenses').get();
    // expenses.value = expenseSnapshots.docs
    //     .map((doc) => ExpenseModel.fromDocument(doc))
    //     .toList();
    // isLoading.value = false;
  }

  final uuid = const Uuid();

  Future<void> addExpense(context) async {
    final itemId = uuid.v4();
    final newExpense = ExpenseModel(
      id: itemId,
      name: expensesname.value,
      date: DateFormat('yyyy-MM-dd').format(expensesdate.value),
      type: expensestype.value,
      expensesPrice: expensesPrice.text,
    );
    await _firestore.collection('expenses').add(newExpense.toMap());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.of(context).addExpense),
      ),
    );
    fetchExpenses();
  }

  Future<void> deleteExpense(String id) async {
    await _firestore.collection('expenses').doc(id).delete();
    fetchExpenses();
  }

  Future<void> updateExpense(ExpenseModel expense, context) async {
    final updatedExpense = ExpenseModel(
      id: expense.id,
      name: expensesname.value,
      date: DateFormat('yyyy-MM-dd').format(expensesdate.value),
      type: expensestype.value,
      expensesPrice: expensesPrice.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.of(context).updateExpense),
      ),
    );
    await _firestore
        .collection('expenses')
        .doc(expense.id)
        .update(updatedExpense.toMap());
    fetchExpenses();
  }

  void isFilter() {
    selectFilter.value = !selectFilter.value;
  }

  void filterExpensesByDate(DateTime selectedDate) {
    isLoading.value = true;
    filteredExpenses.value = expenses.where((expense) {
      DateTime expenseDate = DateFormat('yyyy-MM-dd')
          .parse(expense.date); // Adjust format as per your date string
      return expenseDate.isSameDate(selectedDate);
    }).toList();
    isLoading.value = false;
  }
}

extension DateCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}