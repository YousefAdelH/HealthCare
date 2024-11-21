import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/core/error/error_handle.dart';
import 'package:dental_app/core/error/model/custom_exceptions.dart';
import 'package:dental_app/core/utlis/helper_function.dart';
import 'package:dental_app/features/expences/model/expences_model.dart';
import 'package:dental_app/features/expences/repo/expense_repository.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ExpenseController extends GetxController {
  final ExpenseRepository _repository = GetIt.I<ExpenseRepository>();
  var expenses = <ExpenseModel>[].obs;
  var isLoading = true.obs;
  var expensesname = ''.obs;
  var expensesdate = DateTime.now().obs;
  var expensestype = ''.obs;
  var expensesPrice = TextEditingController();
  var filteredExpenses = <ExpenseModel>[].obs;
  var selectFilter = false.obs;
  var errorOccurred = false.obs;

  @override
  void onInit() {
    fetchExpenses();
    super.onInit();
  }

  void clearControllers() {
    expensesname.value = '';
    expensesdate.value = DateTime.now();
    expensestype.value = '';
    expensesPrice.clear();
  }

  // Future<void> fetchExpenses() async {
  //   await _firestore.collection('expenses').snapshots().listen((snapshot) {
  //     expenses.value =
  //         snapshot.docs.map((doc) => ExpenseModel.fromDocument(doc)).toList();
  //     isLoading.value = false;
  //   });
  //   // await _firestore.collection('expenses').get();
  //   // expenses.value = expenseSnapshots.docs
  //   //     .map((doc) => ExpenseModel.fromDocument(doc))
  //   //     .toList();
  //   // isLoading.value = false;
  // }
  void fetchExpenses() async {
    isLoading.value = true;
    errorOccurred.value = false;
    try {
      _repository.getExpensesStream().listen((expenseList) {
        expenses.value = expenseList;
        isLoading.value = false;
      });
    } on DatabaseException catch (e) {
      isLoading.value = false;
      errorOccurred.value = true;
      ErrorHandler.logError(e.message);
      ErrorHandler.showError("Error: ${e.message}");
    } catch (e) {
      isLoading.value = false;
      errorOccurred.value = true;
      ErrorHandler.logError('Unknown error occurred', e);
      ErrorHandler.showError("Unknown error occurred");
    }
  }

  final uuid = const Uuid();

  // Future<void> addExpense(context) async {
  //   final itemId = uuid.v4();
  //   final newExpense = ExpenseModel(
  //     id: itemId,
  //     name: expensesname.value,
  //     date: DateFormat('yyyy-MM-dd', 'en').format(expensesdate.value),
  //     type: expensestype.value,
  //     expensesPrice: expensesPrice.text,
  //   );

  //   await _firestore.collection('expenses').add(newExpense.toMap());
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(S.of(context).addExpense),
  //     ),
  //   );
  //   clearControllers();
  //   fetchExpenses();
  // }
  Future<void> addExpense(BuildContext context) async {
    final itemId = uuid.v4();
    final newExpense = ExpenseModel(
      id: itemId,
      name: expensesname.value,
      date: DateFormat('yyyy-MM-dd', 'en').format(expensesdate.value),
      type: expensestype.value,
      expensesPrice: expensesPrice.text,
    );
    try {
      await _repository.addExpense(newExpense);
      clearControllers();
      fetchExpenses();
    } on DatabaseException catch (e) {
      ErrorHandler.logError(e.message);
      ErrorHandler.showError("Error: ${e.message}");
    } catch (e) {
      ErrorHandler.logError('Unknown error occurred', e);
      ErrorHandler.showError("Unknown error occurred");
    }
  }

  // Future<void> deleteExpense(String id) async {
  //   await _firestore.collection('expenses').doc(id).delete();
  //   fetchExpenses();
  // }
  Future<void> deleteExpense(BuildContext context, String id) async {
    try {
      await _repository.deleteExpense(id);
      fetchExpenses();
    } on DatabaseException catch (e) {
      ErrorHandler.logError(e.message);
      ErrorHandler.showError("Error: ${e.message}");
    } catch (e) {
      ErrorHandler.logError('Unknown error occurred', e);
      ErrorHandler.showError("Unknown error occurred");
    }
  }

  // Future<void> updateExpense(ExpenseModel expense, context) async {
  //   final updatedExpense = ExpenseModel(
  //     id: expense.id,
  //     name: expensesname.value,
  //     date: DateFormat('yyyy-MM-dd', 'en').format(expensesdate.value),
  //     type: expensestype.value,
  //     expensesPrice: expensesPrice.text,
  //   );

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(S.of(context).updateExpense),
  //     ),
  //   );
  //   await _firestore
  //       .collection('expenses')
  //       .doc(expense.id)
  //       .update(updatedExpense.toMap());
  //   clearControllers();
  //   fetchExpenses(context);
  // }
  Future<void> updateExpense(ExpenseModel expense, BuildContext context) async {
    final updatedExpense = ExpenseModel(
      id: expense.id,
      name: expensesname.value,
      date: DateFormat('yyyy-MM-dd', 'en').format(expensesdate.value),
      type: expensestype.value,
      expensesPrice: expensesPrice.text,
    );
    try {
      await _repository.updateExpense(updatedExpense);
      clearControllers();
      fetchExpenses();
    } on DatabaseException catch (e) {
      ErrorHandler.logError(e.message);
      ErrorHandler.showError("Error: ${e.message}");
    } catch (e) {
      ErrorHandler.logError('Unknown error occurred', e);
      ErrorHandler.showError("Unknown error occurred");
    }
  }

  void isFilter() {
    selectFilter.value = !selectFilter.value;
  }

  void filterExpensesByDate(DateTime selectedDate) {
    isLoading.value = true;
    filteredExpenses.value = expenses.where((expense) {
      DateTime expenseDate = DateFormat('yyyy-MM-dd', 'en')
          .parse(expense.date); // Adjust format as per your date string
      return expenseDate.isSameDate(selectedDate);
    }).toList();
    isLoading.value = false;
  }

  String mapTypeToLocalizedString(BuildContext context, String type) {
    switch (type) {
      case 'Electricity':
      case 'الكهرباء':
        return S.of(context).electricity;
      case 'Rent':
      case "الإيجار":
        return S.of(context).rent;
      case 'Water bill':
      case "فاتورة المياه":
        return S.of(context).waterBill;
      case 'Employees':
      case "الموظفين":
        return S.of(context).employees;
      case 'Other':
      case "أخرى":
        return S.of(context).other;
      default:
        return type;
    }
  }
}

extension DateCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}
