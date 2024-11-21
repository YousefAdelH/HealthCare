import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/badget_mangment/repo/Badget_repository.dart';
import 'package:dental_app/features/expences/model/expences_model.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';
import 'package:dental_app/features/store/model/transction_model.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class BadgetCtrl extends GetxController {
  final BadgetRepository _repository = GetIt.I<BadgetRepository>();

  var totalpatientprice = 0.0.obs;
  var totalExpensesPrice = 0.0.obs;
  var totalTransactionPrice = 0.0.obs;
  var totalSum = 0.0.obs;
  RxList<FlSpot> totalPatients = <FlSpot>[].obs;
  RxList<FlSpot> totalExpenses = <FlSpot>[].obs;
  RxList<FlSpot> totalMaterial = <FlSpot>[].obs;
  var netProfit = 0.0.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    _repository.getAllPatients();
    super.onInit();
  }

  Future<double> getTotalPriceAllExpenses(
      DateTime startDate, DateTime endDate) async {
    List<ExpenseModel> expenses = await _repository.getAllExpenses();
    double totalPrice = 0.0;
    for (var item in expenses) {
      totalPrice += item.calculateTotalPrice(startDate, endDate);
    }
    return totalPrice;
  }

  Future<double> getTotalPriceWithinDateRangeForAllTransactions(
      DateTime startDate, DateTime endDate) async {
    List<MaterialTransaction> transactions =
        await _repository.getAllTransactions();
    double totalPrice = 0.0;
    for (var transaction in transactions) {
      if (!transaction.isIncoming &&
          transaction.date.isAfter(startDate) &&
          transaction.date.isBefore(endDate.add(Duration(days: 1)))) {
        totalPrice +=
            transaction.quantity * parseDouble(transaction.wholesalePrice);
      }
    }
    return totalPrice;
  }

  Future<double> getTotalPriceWithinDateRangeForAllPatients(
      DateTime startDate, DateTime endDate) async {
    List<PatientModel> patients = await _repository.getAllPatients();
    double totalPrice = 0.0;
    for (var patient in patients) {
      totalPrice +=
          patient.calculateTotalPriceWithinDateRange(startDate, endDate);
    }
    return totalPrice;
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
    totalSum.value = totalpatientprice.value +
        totalExpensesPrice.value +
        totalTransactionPrice.value +
        netProfit.value;
    isLoading.value = false;
  }

  double parseDouble(String value) => double.tryParse(value) ?? 0.0;

  String calculatePercentage(double value) {
    if (totalSum.value == 0) return '0%';
    return '${((value / totalSum.value) * 100).toStringAsFixed(1)}%';
  }

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

  void showScreenFilter(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteFE,
          title: Text(S.of(context).selectDate),
          content: SizedBox(
            height: MediaQuery.of(context).size.height /
                3, // Adjusted height to fit content
            width: MediaQuery.of(context).size.width / 1.2,
            child: Obx(() {
              return Column(
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
                  isLoading.value = true;
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
}
