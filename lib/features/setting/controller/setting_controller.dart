import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/features/setting/model/model_operations.dart';
import 'package:dental_app/features/store/model/material_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:uuid/uuid.dart';

class LocalizationController extends GetxController {
  var locale = Locale('en').obs;

  void changeLocale(Locale newLocale) {
    locale.value = newLocale;
    Get.updateLocale(newLocale);
    update();
  }

  final _db = FirebaseFirestore.instance;
  var operations = <OperationModel>[].obs;
  var selectedOperation = Rx<OperationModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchOperations();
  }

  TextEditingController oppriceController = TextEditingController();
  TextEditingController opnameController = TextEditingController();
  TextEditingController costpriceController = TextEditingController();
  void fetchOperations() {
    _db.collection('operations').snapshots().listen((snapshot) {
      operations.value = snapshot.docs
          .map((doc) => OperationModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  double getPriceGain(double price, double amount) {
    return price - amount;
  }

  Future<void> addOperation() async {
    final uuid = Uuid();
    final opId = uuid.v4();

    var newOperation = OperationModel(
      id: opId,
      name: opnameController.text,
      price: double.parse(oppriceController.text),
      costPrice: double.parse(costpriceController.text), // Set this accordingly
      priceGain: getPriceGain(
          double.parse(oppriceController.text ?? "0"),
          double.parse(
              costpriceController.text ?? "0")), // Set this accordingly
      numOfTime: 0, // Set this accordingly
    );
    await _db.collection('operations').add(newOperation.toMap());
    opnameController.clear();
    oppriceController.clear();
    costpriceController.clear();
  }

  Future<void> updateOperation(OperationModel operation) async {
    await _db
        .collection('operations')
        .doc(operation.id)
        .update(operation.toMap());
  }

  Future<void> deleteOperation(String id) async {
    await _db.collection('operations').doc(id).delete();
  }
}
