import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/setting/model/model_operations.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OperationController extends GetxController {
  var operations = <OperationModel>[].obs; // Observable list of operations
  var isLoading = true.obs; // Observable loading state
  var touchedIndex = (-1).obs; // Observable touched index

  @override
  void onInit() {
    super.onInit();
    loadOperations();
  }

  void loadOperations() async {
    isLoading.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? operationsString = prefs.getString('operations');

    if (operationsString != null) {
      List<dynamic> operationsJson = jsonDecode(operationsString);
      List<OperationModel> savedOperations = operationsJson.map((json) {
        return OperationModel.fromMap(json as Map<String, dynamic>, '');
      }).toList();
      operations.value = savedOperations;
    } else {
      await fetchOperations();
    }

    isLoading.value = false;
  }

  Future<void> fetchOperations() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('operations').get();

      List<OperationModel> fetchedOperations = snapshot.docs.map((doc) {
        return OperationModel.fromMap(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      operations.value = fetchedOperations;
      saveOperations(fetchedOperations);
    } catch (e) {
      print('Error fetching operations: $e');
    } finally {
      isLoading.value =
          false; // Set loading state to false after data is fetched or error
    }
  }

  void saveOperations(List<OperationModel> operations) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> operationsJson = operations.map((operation) {
      return operation.toMap();
    }).toList();
    prefs.setString('operations', jsonEncode(operationsJson));
  }

  Color getColorForOperation(String operationName) {
    switch (operationName) {
      case 'item1':
        return AppColors.contentColorBlue;
      case 'item2':
        return AppColors.contentColorYellow;
      case 'item3':
        return AppColors.contentColorPurple;
      case 'item4':
        return AppColors.contentColorGreen;
      default:
        return Colors.grey; // Default color or fallback color
    }
  }

  List<PieChartSectionData> showingSections() {
    double totalOperations =
        operations.fold(0, (sum, operation) => sum + operation.numOfTime!);

    return operations.map((operation) {
      final isTouched = operations.indexOf(operation) == touchedIndex.value;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      double percentage = (operation.numOfTime! / totalOperations) * 100;

      return PieChartSectionData(
        color: getColorForOperation(operation.name!),
        value: percentage,
        title: '${percentage.toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: AppColors.mainTextColor1,
          shadows: shadows,
        ),
      );
    }).toList();
  }
}
