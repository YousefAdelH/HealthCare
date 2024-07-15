import 'package:dental_app/features/store/model/material_model.dart';
import 'package:dental_app/features/store/model/transction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MaterialController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var materials = <DentalMaterial>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMaterials();
  }

  void fetchMaterials() {
    _db.collection('storehouse').snapshots().listen((snapshot) {
      materials.value = snapshot.docs
          .map((doc) => DentalMaterial.fromMap(doc.data(), doc.id))
          .toList();
      isLoading.value = false;
    });
  }

  late DentalMaterial? material;
  void getmatrial(DentalMaterial materialitem) {
    nameController.text = materialitem.name;
    quantityController.text = materialitem.quantity.toString();
    wholesalePriceController.text = materialitem.wholesalePrice.toString();
    sellingPriceController.text = materialitem.sellingPrice.toString();
  }

  void deletecontroller() {
    nameController.clear();
    quantityController.clear();
    sellingPriceController.clear();
    wholesalePriceController.clear();
  }

// add matrial//////////////////////////
  void setDate(DateTime date) {
    expirationDate = date;
    update();
  }

  var nameController = TextEditingController();
  var quantityController = TextEditingController();
  var wholesalePriceController = TextEditingController();
  var sellingPriceController = TextEditingController();
  DateTime? expirationDate;

  Future<void> addMaterial(DentalMaterial material) async {
    await _db.collection('storehouse').add(material.toMap());
    await addTransaction(MaterialTransaction(
      id: '', // Firestore will set the ID
      materialId: material.id,
      date: DateTime.now(),
      quantity: material.quantity,
      isIncoming: true,
    ));
    nameController.clear();
    quantityController.clear();
    sellingPriceController.clear();
    wholesalePriceController.clear();
    update();
  }

  Future<void> updateMaterial(DentalMaterial material) async {
    await _db
        .collection('storehouse')
        .doc(material.id)
        .update(material.toMap());
    nameController.clear();
    quantityController.clear();
    sellingPriceController.clear();
    wholesalePriceController.clear();
    update();
  }

  Future<void> deleteMaterial(String id) async {
    List<MaterialTransaction> transactions =
        await getTransactionsForMaterial(id);
    for (var transaction in transactions) {
      await _db.collection('transaction').doc(transaction.id).delete();
    }
    await _db.collection('storehouse').doc(id).delete();
  }

  Future<void> addTransaction(MaterialTransaction transaction) async {
    await _db.collection('transaction').add(transaction.toFirestore());

    // Update material quantity
    DocumentSnapshot materialDoc =
        await _db.collection('storehouse').doc(transaction.materialId).get();
    DentalMaterial material = DentalMaterial.fromMap(
        materialDoc.data() as Map<String, dynamic>, transaction.materialId);
    material.quantity +=
        transaction.isIncoming ? transaction.quantity : -transaction.quantity;
    await updateMaterial(material);
  }

  Future<void> adjustQuantity(
      String materialId, int amount, bool isIncoming) async {
    // Create a transaction
    MaterialTransaction transaction = MaterialTransaction(
      id: '',
      materialId: materialId,
      date: DateTime.now(),
      quantity: amount,
      isIncoming: isIncoming,
    );
    await addTransaction(transaction);
  }

  Future<List<MaterialTransaction>> getTransactionsForMaterial(
      String materialId) async {
    QuerySnapshot querySnapshot = await _db
        .collection('transaction')
        .where('materialId', isEqualTo: materialId)
        .get();

    return querySnapshot.docs
        .map((doc) => MaterialTransaction.fromFirestore(
            doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<double> calculateMonthlyDisbursements(int year, int month) async {
    double totalDisbursements = 0.0;

    QuerySnapshot querySnapshot = await _db
        .collection('transaction')
        .where('date', isGreaterThanOrEqualTo: DateTime(year, month, 1))
        .where('date', isLessThanOrEqualTo: DateTime(year, month + 1, 0))
        .get();

    List<MaterialTransaction> transactions = querySnapshot.docs
        .map((doc) => MaterialTransaction.fromFirestore(
            doc.data() as Map<String, dynamic>))
        .toList();

    for (var transaction in transactions) {
      if (transaction.isIncoming) {
        totalDisbursements += transaction.quantity *
            (await getMaterial(transaction.materialId)).wholesalePrice;
      } else {
        totalDisbursements -= transaction.quantity *
            (await getMaterial(transaction.materialId)).sellingPrice;
      }
    }
    return totalDisbursements;
  }

  Future<DentalMaterial> getMaterial(String materialId) async {
    DocumentSnapshot doc =
        await _db.collection('storehouse').doc(materialId).get();
    return DentalMaterial.fromMap(
        doc.data() as Map<String, dynamic>, materialId);
  }
}
