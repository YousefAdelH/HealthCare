import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/core/error/error_handle.dart';
import 'package:dental_app/core/error/model/custom_exceptions.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';
import 'package:dental_app/features/prescription/model/medication_model.dart';
import 'package:dental_app/features/prescription/model/prescription_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PrescriptionReposatiry {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firestorage;
  PrescriptionReposatiry(this._firestore, this._firestorage);
  // Observable list for medications

  Future<void> uploadPrescription(
      String patientId,
      String patientName,
      Uint8List pdfBytes,
      List<Map<String, dynamic>> medications,
      String instructions) async {
    // final prescriptionRef = _firestorage.ref().child(
    //     "prescriptions/${patientId}_${DateFormat('yyyy-MM-dd', 'en').format(DateTime.now())}.pdf");
    try {
      // await prescriptionRef.putData(
      //     pdfBytes, SettableMetadata(contentType: 'application/pdf'));
      // final downloadUrl = await prescriptionRef.getDownloadURL();
      await _firestore.collection('prescriptions').add({
        'patientId': patientId,
        'patientName': patientName,
        'medication': medications,
        'instructions': instructions,
        'date': DateFormat('yyyy-MM-dd', 'en').format(DateTime.now()),
      });
    } catch (e) {
      print("Failed to upload prescription: $e");
    }
  }

  Future<List<PrescriptionModel>> fetchPrescriptions(String patientId) async {
    final snapshots = await _firestore
        .collection('prescriptions')
        .where('patientId', isEqualTo: patientId)
        .get();
    return snapshots.docs
        .map((doc) => PrescriptionModel.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  Future<void> deletePrescription(String prescriptionId) async {
    try {
      await _firestore.collection('prescriptions').doc(prescriptionId).delete();
      print("Prescription deleted successfully!");
    } catch (e) {
      print("Failed to delete prescription: $e");
    }
  }

  Future<void> downloadPrescription(String url) async {
    final ref = _firestorage.refFromURL(url);
    final tempDir = await getTemporaryDirectory();
    final localFile = File('${tempDir.path}/${ref.name}');
    await ref.writeToFile(localFile);
    print("Prescription downloaded to ${localFile.path}");
  }
}
