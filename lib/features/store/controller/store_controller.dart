import 'package:dental_app/features/store/model/material_model.dart';
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
    await _db.collection('storehouse').doc(id).delete();
  }
}
