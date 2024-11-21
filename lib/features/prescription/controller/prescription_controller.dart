import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/core/error/error_handle.dart';
import 'package:dental_app/core/error/model/custom_exceptions.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';
import 'package:dental_app/features/prescription/model/medication_model.dart';
import 'package:dental_app/features/prescription/model/prescription_model.dart';
import 'package:dental_app/features/prescription/repo/prescription_reposatiry.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';

class PrescriptionCtrl extends GetxController {
  final storageRef = FirebaseStorage.instance.ref();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var selectFilter = false.obs;
  var medications = <Medication>[].obs;
  final PrescriptionReposatiry prescriptionRepository =
      GetIt.I<PrescriptionReposatiry>();

////////////////////////////////////Addprescription////////////////////
  final TextEditingController medicationController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();
  // @override
  // void addNewMedication() {
  //   if (medicationController.text.isNotEmpty &&
  //       dosageController.text.isNotEmpty) {
  //     var newMedication = Medication(
  //       medication: medicationController.text,
  //       dosage: dosageController.text,
  //     );

  //     // Add the new medication to the observable list
  //     medications.add(newMedication);

  //     // Clear the text fields
  //     medicationController.clear();
  //     dosageController.clear();
  //     instructionsController.clear();
  //   }
  // }

  // Future<void> generateAndUploadPrescription(
  //     PatientModel patient, context) async {
  //   final pdfBytes = await generatePdf(
  //     patient.name!,
  //     medicationController.text,
  //     dosageController.text,
  //     instructionsController.text,
  //   );

  //   // Save PDF to Firebase Storage

  //   final prescriptionRef = storageRef.child(
  //       "prescriptions/${patient.id}_${DateFormat('yyyy-MM-dd', 'en').format(DateTime.now())}.pdf");

  //   try {
  //     await prescriptionRef.putData(
  //         pdfBytes, SettableMetadata(contentType: 'application/pdf'));

  //     // Get download URL
  //     // Get download URL
  //     final downloadUrl = await prescriptionRef.getDownloadURL();

  //     // Convert medications to a list of maps
  //     final medicationMaps = medications.map((med) => med.toMap()).toList();

  //     // Optionally, save URL in Firestore for later reference
  //     await firestore.collection('prescriptions').add({
  //       'patientId': patient.id,
  //       'patientName': patient.name,
  //       'medication': medicationMaps, // Store as a list of maps
  //       'instructions': instructionsController.text,
  //       'date': DateFormat('yyyy-MM-dd', 'en').format(DateTime.now()),
  //       'downloadUrl': downloadUrl,
  //     });

  //     // Clear the text fields
  //     medicationController.clear();
  //     dosageController.clear();
  //     instructionsController.clear();
  //     medications.clear();
  //     // openPdf(downloadUrl);

  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text("Prescription Uploaded"),
  //           content: Text("The prescription was successfully uploaded."),
  //           actions: [
  //             TextButton(
  //               onPressed: () async {
  //                 Navigator.of(context).pop();
  //                 await openPdf(downloadUrl); // Call function to open PDF
  //               },
  //               child: Text("OK"),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   } catch (e) {
  //     print("Failed to upload PDF: $e");
  //   }
  // }
  void addNewMedication() {
    if (medicationController.text.isNotEmpty &&
        dosageController.text.isNotEmpty) {
      var newMedication = Medication(
        medication: medicationController.text,
        dosage: dosageController.text,
      );
      medications.add(newMedication);
      medicationController.clear();
      dosageController.clear();
      instructionsController.clear();
    }
  }

  Future<void> generateAndUploadPrescription(
      PatientModel patient, context) async {
    final medicationMaps = medications.map((med) => med.toMap()).toList();
    final pdfBytes = await generatePdf(
        patient.name!, medications, instructionsController.text);
    await prescriptionRepository.uploadPrescription(patient.id!, patient.name!,
        pdfBytes, medicationMaps, instructionsController.text);
    _clearForm();
    _showUploadDialog(context);
  }

  void _clearForm() {
    medicationController.clear();
    dosageController.clear();
    instructionsController.clear();
    medications.clear();
  }

  void _showUploadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Prescription Uploaded"),
          content: Text("The prescription was successfully uploaded."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // Future<void> openPdf(String filePathOrUrl) async {
  //   try {
  //     Uri uri;

  //     // Check if the provided path is a network URL
  //     if (filePathOrUrl.startsWith('http') ||
  //         filePathOrUrl.startsWith('https')) {
  //       uri = Uri.parse(filePathOrUrl); // Network URL
  //     } else {
  //       uri = Uri.file(filePathOrUrl); // Local file path
  //       // Verify the file exists if it's a local file
  //       if (!File(uri.toFilePath()).existsSync()) {
  //         throw Exception('$uri does not exist!');
  //       }
  //     }

  //     // Attempt to launch the PDF
  //     if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
  //       throw Exception('Could not launch $uri');
  //     }
  //   } on DatabaseException catch (e) {
  //     ErrorHandler.logError(e.message);
  //     ErrorHandler.showError("Error: ${e.message}");
  //   } catch (e) {
  //     ErrorHandler.logError('Unknown error occurred', e);
  //     ErrorHandler.showError("Unknown error occurred");
  //   }
  // }

//////////////////////////////download pdf
  // Future<void> downloadPrescription(String url) async {
  //   final ref = FirebaseStorage.instance.refFromURL(url);
  //   final tempDir = await getTemporaryDirectory();
  //   final localFile = File('${tempDir.path}/${ref.name}');
  //   await ref.writeToFile(localFile);
  //   print("Prescription downloaded to ${localFile.path}");
  // }

  Future<void> downloadPrescription(String url) async {
    await prescriptionRepository.downloadPrescription(url);
  }

///////////////////print pdf/////////
  Future<void> printPdf(Uint8List pdfBytes) async {
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfBytes,
    );
  }

///////////////// generation pdf//////////////////////
  Future<Uint8List> generatePdf(String patientName,
      List<Medication> medicationlist, String instructions) async {
    final pdf = pw.Document();
    final formattedDate = DateFormat('d/M/yyyy').format(DateTime.now());
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Clinic Header
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(children: [
                  pw.Text("DR.Mina gerges",
                      style: pw.TextStyle(
                          fontSize: 28, fontWeight: pw.FontWeight.bold)),
                  pw.Text("Master of Otorhinolaryngology ",
                      style: pw.TextStyle(
                          fontSize: 12, fontStyle: pw.FontStyle.italic)),
                ]),
                pw.Column(children: [
                  pw.Text("Patient: $patientName",
                      style: pw.TextStyle(fontSize: 16)),
                  pw.Text("Date: $formattedDate",
                      style: pw.TextStyle(
                          fontSize: 12, fontStyle: pw.FontStyle.italic)),
                ])
              ],
            ),
            pw.Divider(),

            // Patient and Doctor Details

            pw.SizedBox(height: 20),

            ...medicationlist.map((med) => pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(" ${med.medication}",
                        style: pw.TextStyle(fontSize: 16)),
                    pw.Text(" ${med.dosage}",
                        style: pw.TextStyle(fontSize: 16)),
                  ],
                )),
            pw.Text("Instructions: $instructions",
                style: pw.TextStyle(fontSize: 16)),
            pw.SizedBox(height: 24),

            // Footer
            pw.Divider(),
            pw.Text("Clinic Address: 123 Main St, City",
                style: pw.TextStyle(fontSize: 12)),
            pw.Text("Phone: (123) 456-7890", style: pw.TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
    try {
      // Saving the PDF
      final output = await getTemporaryDirectory();
      final file = File("${output.path}/prescription.pdf");
      await file.writeAsBytes(await pdf.save());

      // Opening the PDF
      await OpenFile.open(file.path);
    } catch (e) {
      print("Error opening file: $e");
    }
    return pdf.save();
  }

  var allPrescriptions = <PrescriptionModel>[].obs;
  // Future<void> fetchPrescriptions(String patientId) async {
  //   final snapshots = await FirebaseFirestore.instance
  //       .collection('prescriptions')
  //       .where('patientId', isEqualTo: patientId)
  //       .get();

  //   allPrescriptions.value = snapshots.docs.map((doc) {
  //     return PrescriptionModel.fromFirestore(doc.data(), doc.id);
  //   }).toList();

  //   update();
  // }

  Future<void> fetchPrescriptions(String patientId) async {
    allPrescriptions.value =
        await prescriptionRepository.fetchPrescriptions(patientId);
    update();
  }

  // Future<void> deletePrescription(String prescriptionId) async {
  //   try {
  //     // Delete the document from Firestore
  //     await FirebaseFirestore.instance
  //         .collection('prescriptions')
  //         .doc(prescriptionId)
  //         .delete();

  //     // Remove the prescription from the observable list
  //     allPrescriptions
  //         .removeWhere((prescription) => prescription.id == prescriptionId);

  //     print("Prescription deleted successfully!");
  //   } catch (e) {
  //     print("Failed to delete prescription: $e");
  //   }
  // }

  Future<void> deletePrescription(String prescriptionId) async {
    await prescriptionRepository.deletePrescription(prescriptionId);
    allPrescriptions
        .removeWhere((prescription) => prescription.id == prescriptionId);
  }

  void isFilter() {
    selectFilter.value = !selectFilter.value;
  }
}
