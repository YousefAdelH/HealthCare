import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/expences/model/expences_model.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';
import 'package:dental_app/features/store/model/material_model.dart';
import 'package:dental_app/features/store/model/transction_model.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BadgetCtrl extends GetxController {
  final _db = FirebaseFirestore.instance;
  var totalpatientprice = 0.0.obs;
  var totalExpensesPrice = 0.0.obs;
  var totalTransactionPrice = 0.0.obs;
  RxList<FlSpot> totalPatients = <FlSpot>[].obs;
  RxList<FlSpot> totalExpenses = <FlSpot>[].obs;
  RxList<FlSpot> totalMaterial = <FlSpot>[].obs;
  var netProfit = 0.0.obs;
  @override
  void onInit() {
    getAllPatients();
    super.onInit();
    // DateTime now = DateTime.now();
    // DateTime startDate = DateTime(now.year, now.month, 1);
    // DateTime endDate = DateTime(now.year, now.month + 1, 0);
    // calculateNetProfit(startDate, endDate);
  }

///////////////////getAllExpenses////////////////////////
  Future<List<ExpenseModel>> getAllExpenses() async {
    QuerySnapshot expensesSnapshot = await _db.collection('expenses').get();
    return expensesSnapshot.docs.map((doc) {
      return ExpenseModel.fromDocument(doc);
    }).toList();
  }

  Future<double> getTotalPriceAllExpenses(
      DateTime startDate, DateTime endDate) async {
    List<ExpenseModel> expenses = await getAllExpenses();
    double totalPrice = 0.0;

    for (var item in expenses) {
      totalPrice += item.calculateTotalPrice(startDate, endDate);
    }

    // totalExpensesPrice.value = totalPrice;
    print("////////////////////////////////totalPrice");
    print(totalPrice);
    return totalPrice;
  }

///////////////////getAllTransaction////////////////////////
  Future<List<MaterialTransaction>> getAllTransactions() async {
    QuerySnapshot transactionSnapshot =
        await _db.collection('transaction').get();
    return transactionSnapshot.docs.map((doc) {
      return MaterialTransaction.fromFirestore(
          doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<double> getTotalPriceWithinDateRangeForAllTransactions(
      DateTime startDate, DateTime endDate) async {
    List<MaterialTransaction> transactions = await getAllTransactions();
    double totalPrice = 0.0;

    for (var transaction in transactions) {
      if (!transaction.isIncoming &&
          transaction.date.isAfter(
              DateTime(startDate.year, startDate.month, startDate.day)) &&
          transaction.date.isBefore(
              DateTime(endDate.year, endDate.month, endDate.day)
                  .add(Duration(days: 1)))) {
        totalPrice += transaction.quantity *
            (await getMaterial(transaction.materialId)).wholesalePrice;
      }
    }

    // totalTransactionPrice.value = totalPrice;
    print("Total Transaction Price: $totalPrice");
    return totalPrice;
  }

  Future<DentalMaterial> getMaterial(String materialId) async {
    DocumentSnapshot doc =
        await _db.collection('storehouse').doc(materialId).get();
    return DentalMaterial.fromMap(
        doc.data() as Map<String, dynamic>, materialId);
  }

///////////////////getAllPatients////////////////////////
  Future<List<PatientModel>> getAllPatients() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('patient').get();
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return PatientModel.fromJson(data);
    }).toList();
  }

  Future<double> getTotalPriceWithinDateRangeForAllPatients(
      DateTime startDate, DateTime endDate) async {
    List<PatientModel> patients = await getAllPatients();
    double totalPrice = 0.0;

    for (var patient in patients) {
      totalPrice +=
          patient.calculateTotalPriceWithinDateRange(startDate, endDate);
    }

    // totalpatientprice.value = totalPrice;
    print("////////////////////////////////totalPrice");
    print(totalPrice);
    return totalPrice;
  }

//  DateTime startDate = DateTime(2024, 12, 1);
//   DateTime endDate = DateTime(2024, 12, 3);
  var startdate = Rx<DateTime?>(null);
  var enddate = Rx<DateTime?>(null);
  Future<void> selectDate(
      BuildContext context, Rx<DateTime?> dateVariable) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDatePickerMode: DatePickerMode.day,
    );

    if (selectedDate != null) {
      String formattedDate =
          DateFormat('yyyy-MM-dd', 'en').format(selectedDate);
      DateTime parsedDate = DateFormat('yyyy-MM-dd', 'en').parse(formattedDate);
      dateVariable.value = parsedDate;
      print("////////////////////////////////date");
      print(dateVariable.value);
    }
  }

  Future<void> calculateNetProfit(DateTime startDate, DateTime endDate) async {
    totalpatientprice.value =
        await getTotalPriceWithinDateRangeForAllPatients(startDate, endDate);
    totalExpensesPrice.value =
        await getTotalPriceAllExpenses(startDate, endDate);
    totalTransactionPrice.value =
        await getTotalPriceWithinDateRangeForAllTransactions(
            startDate, endDate);

    double netprofit = totalpatientprice.value -
        (totalExpensesPrice.value + totalTransactionPrice.value);
    netProfit.value = netprofit;
    print("Net Profit: $netprofit");
    // totalPatients.value =
    //     generateSpotsForMonth(startDate, endDate, totalpatientprice.value);
    // totalExpenses.value =
    //     generateSpotsForMonth(startDate, endDate, totalExpensesPrice.value);
    // totalMaterial.value =
    //     generateSpotsForMonth(startDate, endDate, totalTransactionPrice.value);
    // print(totalPatients.value);
    // print(totalExpenses.value);
    // print(totalMaterial.value);
  }

  void showScreenFilter(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteFE,
          title: Text(S.of(context).newSession),
          content: SizedBox(
            height: MediaQuery.of(context).size.height /
                2, // Adjusted height to fit content
            width: MediaQuery.of(context).size.width / 2,
            child: Obx(() {
              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.primary, // Text color
                      backgroundColor: Colors.white, // Background color
                      side: BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ), // Border color and width
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12), // Border radius
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.filter_alt_sharp),
                        SizedBox(width: 5),
                        Text(
                            ' ${startdate.value != null ? DateFormat.yMd().format(startdate.value!) : S.of(context).startDate}'),
                      ],
                    ),
                    onPressed: () => selectDate(context, startdate),
                  ),
                  CustomText(
                    text: "To",
                    color: Colors.black,
                    size: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  // Add spacing between buttons
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.primary, // Text color
                      backgroundColor: Colors.white, // Background color
                      side: BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ), // Border color and width
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12), // Border radius
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.filter_alt_sharp),
                        SizedBox(width: 5),
                        Text(
                            ' ${enddate.value != null ? DateFormat.yMd().format(startdate.value!) : S.of(context).end}'),
                      ],
                    ),
                    onPressed: () => selectDate(context, enddate),
                  ),
                ],
              );
            }),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (startdate.value != null && enddate.value != null) {
                  calculateNetProfit(startdate.value!, enddate.value!);
                }
                Navigator.of(context).pop();
                enddate.value = null;
                startdate.value = null;
              },
              child: Text(S.of(context).save),
            ),
          ],
        );
      },
    );
  }

  List<FlSpot> generateSpotsForMonth(
      DateTime startDate, DateTime endDate, double totalPrice) {
    List<FlSpot> spots = [];
    int totalDays = endDate.difference(startDate).inDays + 1;
    double dailyAverage = totalPrice / totalDays;

    for (int i = 0; i < totalDays; i++) {
      spots.add(FlSpot(i.toDouble(), dailyAverage));
    }

    return spots;
  }

  // Future<void> fetchCurrentMonthData() async {
  //   await calculateNetProfitForCurrentMonth();
  //   DateTime now = DateTime.now();
  //   int daysInMonth = DateTime(now.year, now.month + 1, 0).day;

  //   // Create a list of spots for the LineChart
  //   List<FlSpot> spots = [];
  //   for (int i = 1; i <= daysInMonth; i++) {
  //     double value = await getDailyValue(now.year, now.month, i);
  //     spots.add(FlSpot(i.toDouble(), value));
  //   }
  //   lineChartSpots.value = spots;
  // }

  // Future<double> getDailyValue(int year, int month, int day) async {
  //   // Fetch the value for the specific day
  //   // This method should be implemented to get the value from your database
  //   return 0.0; // Replace with actual logic
  // }
}
