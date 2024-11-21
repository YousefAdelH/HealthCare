import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/core/utlis/helper_function.dart';
import 'package:dental_app/features/patien_details/widget/show_add_new_note.dart';
import 'package:dental_app/features/patient/model/class_session.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';
import 'package:dental_app/features/patient/repo/paient_repository.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class PaientCtrl extends GetxController {
  final PatientRepository _repository = GetIt.I<PatientRepository>();
  final Rx<double> totalAmount = Rx<double>(0.0);
  var searchController = TextEditingController();
  // final CollectionReference membersCollection =
  //     FirebaseFirestore.instance.collection('patient');
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController habitsController = TextEditingController();
  final TextEditingController surgicalhistoryController =
      TextEditingController();
  final TextEditingController labController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController diagnosisController = TextEditingController();

  TextEditingController medicalhistoryController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController totalpriceController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  // DateTime? selectedDate;
  // TimeOfDay? selectedTime;
  String? selectedGender;
  DateTime? sessionDate;
  TimeOfDay? sessionTime;
  final TextEditingController sessionNoteController = TextEditingController();
  final TextEditingController sessionPriceController = TextEditingController();
  var isSuccess = false.obs;

  void setSuccess() {
    isSuccess.value = !isSuccess.value;
  }

  // void setSelectedDate(DateTime date) {
  //   selectedDate = date;
  //   update();
  // }

  // void setSelectedTime(TimeOfDay time) {
  //   selectedTime = time;
  //   update();
  // }

  final int limit = 5;
  DocumentSnapshot? lastDocument;
  var patients = <PatientModel>[].obs;
  var patientsearch = <PatientModel>[].obs;
  var isLoading = false.obs;
  var hasMore = true.obs;
  var sessions = <Session>[].obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchPatients();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchPatients();
      }
    });
  }

  // Future<void> fetchPatients() async {
  //   if (isLoading.value || !hasMore.value) return;

  //   isLoading.value = true;

  //   Query query = membersCollection.orderBy('name').limit(limit);

  //   if (lastDocument != null) {
  //     query = query.startAfterDocument(lastDocument!);
  //   }

  //   final QuerySnapshot querySnapshot = await query.get();

  //   if (querySnapshot.docs.length < limit) {
  //     hasMore.value = false;
  //   }

  //   if (querySnapshot.docs.isNotEmpty) {
  //     lastDocument = querySnapshot.docs.last;

  //     List<PatientModel> newPatients = querySnapshot.docs.map((doc) {
  //       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //       return PatientModel.fromJson(data);
  //     }).toList();

  //     patients.addAll(newPatients);
  //     patients.refresh();
  //     update();
  //   }

  //   isLoading.value = false;
  // }
  Future<void> fetchPatients() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;
    try {
      final result =
          await _repository.fetchPatients(lastDocument: lastDocument);
      final newPatients = result['patients'] as List<PatientModel>;
      final newLastDocument = result['lastDocument'] as DocumentSnapshot?;

      if (newPatients.length < 5) hasMore.value = false;
      lastDocument = newLastDocument; // Update lastDocument directly

      patients.addAll(newPatients);
      patients.refresh();
      update();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void setSelectedGender(String gender) {
    selectedGender = gender;
    update();
  }

  void setSessionDate(DateTime date) {
    sessionDate = date;
    update();
  }

  void setSessionTime(TimeOfDay time) {
    sessionTime = time;
    update();
  }

  // void addMember(BuildContext context) {
  //   final docRef = membersCollection.doc();
  //   final remainingAmount = HelperFunction.remainingamount(
  //       totalpriceController.text, amountController.text);

  //   final member = PatientModel(
  //     id: docRef.id,
  //     code: codeController.text,
  //     name: nameController.text,
  //     number: numberController.text,
  //     surgicalhistory: surgicalhistoryController.text,
  //     lab: labController.text,
  //     habits: habitsController.text,
  //     diagnosis: diagnosisController.text,
  //     notes: notesController.text,
  //     age: ageController.text,
  //     medicalhistory: medicalhistoryController.text,
  //     totalPrice: totalpriceController.text,
  //     amountPaid: amountController.text,
  //     remainingAmount: remainingAmount,
  //     // date: selectedDate?.toString(),
  //     // time: selectedTime?.format(context),
  //     gender: selectedGender,
  //     // session: [session],
  //   );

  //   docRef.set(member.toJson()).then((_) {
  //     // Clear the text fields after adding the member
  //     nameController.clear();
  //     codeController.clear();
  //     numberController.clear();
  //     surgicalhistoryController.clear();
  //     labController.clear();
  //     habitsController.clear();
  //     diagnosisController.clear();
  //     notesController.clear();
  //     medicalhistoryController.clear();
  //     ageController.clear();
  //     totalpriceController.clear();
  //     amountController.clear();
  //     sessionNoteController.clear();
  //     setSuccess();
  //     update();
  //   });
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text(S.of(context).newPatient),
  //         content: Text(S.of(context).newPatientAddedSuccessfully),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text(S.of(context).close),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  Future<void> addMember(BuildContext context) async {
    final String remainingAmount = HelperFunction.remainingamount(
        totalpriceController.text, amountController.text);

    final member = PatientModel(
      id: _repository.patientsCollection.doc().id,
      code: codeController.text,
      name: nameController.text,
      number: numberController.text,
      surgicalhistory: surgicalhistoryController.text,
      lab: labController.text,
      habits: habitsController.text,
      diagnosis: diagnosisController.text,
      notes: notesController.text,
      age: ageController.text,
      medicalhistory: medicalhistoryController.text,
      totalPrice: totalpriceController.text,
      amountPaid: amountController.text,
      remainingAmount: remainingAmount,
      gender: selectedGender,
    );

    await _repository.addPatient(member).then((_) {
      // Clear the text fields after adding the member
      _clearTextFields();
      setSuccess();
      update();
    });

    _showSuccessDialog(context);
  }

  void _clearTextFields() {
    nameController.clear();
    codeController.clear();
    numberController.clear();
    surgicalhistoryController.clear();
    labController.clear();
    habitsController.clear();
    diagnosisController.clear();
    notesController.clear();
    medicalhistoryController.clear();
    ageController.clear();
    totalpriceController.clear();
    amountController.clear();
    sessionNoteController.clear();
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.of(context).newPatient),
          content: Text(S.of(context).newPatientAddedSuccessfully),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(S.of(context).close),
            ),
          ],
        );
      },
    );
  }

  // void deletePatient(String patientId) async {
  //   try {
  //     await membersCollection.doc(patientId).delete();
  //     patients.removeWhere((patient) => patient.id == patientId);
  //     update();

  //     Get.snackbar(
  //       S.of(Get.context!).success,
  //       S.of(Get.context!).patientDeletedSuccessfully,
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   } catch (e) {
  //     Get.snackbar(
  //       S.of(Get.context!).error,
  //       '${S.of(Get.context!).failedToDeletePatient}$e',
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   }
  // }

  Future<void> deletePatient(String patientId) async {
    await _repository.deletePatient(patientId);
    patients.removeWhere((patient) => patient.id == patientId);
    update();
  }

  // Method to show confirmation dialog
  void showDeleteConfirmationDialog(BuildContext context, String patientId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.of(context).deletePatient),
          content: Text(S.of(context).deletePatientConfirmation),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).cancel),
            ),
            TextButton(
              onPressed: () {
                deletePatient(patientId);
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).delete),
            ),
          ],
        );
      },
    );
  }

  var isSearch = false.obs;

  void setSearch(value) {
    isSearch.value = value;
    update();
  }

  Future<void> searchPatientsByName() async {
    String query = searchController.text.trim();
    if (query.isEmpty) {
      isSearch.value = false;
      // Reset any search-specific state here if necessary
      update();
      return;
    } else {
      isSearch.value = true;
      await _performSearch(query);
    }
  }

  Future<void> _performSearch(String searchTerm) async {
    isLoading.value = true;
    patientsearch.clear();

    try {
      List<PatientModel> searchedPatients =
          await _repository.searchPatients(searchTerm);

      if (searchedPatients.isNotEmpty) {
        patientsearch.addAll(searchedPatients);
      } else {
        // No more patients to fetch
        // Optionally set a flag if needed
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to search patients: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }
///////////////////////
  // void searchPatientsByName() {
  //   String query = searchController.text.trim();
  //   if (query.isEmpty) {
  //     isSearch.value = false;
  //     // fetchPatients();
  //     print(query);
  //   } else {
  //     isSearch.value = true;
  //     searchPatients(query);
  //     print(query);
  //   }
  // }

  // Future<void> searchPatients(String searchTerm) async {
  //   isLoading.value = true;
  //   patientsearch.clear();

  //   // Query to search by name
  //   Query nameQuery = membersCollection
  //       .where('name', isGreaterThanOrEqualTo: searchTerm)
  //       .where('name', isLessThan: searchTerm + 'z');

  //   // Query to search by patient code
  //   Query codeQuery = membersCollection
  //       .where('code', isGreaterThanOrEqualTo: searchTerm)
  //       .where('code', isLessThan: searchTerm + 'z');

  //   // Execute both queries
  //   final QuerySnapshot nameQuerySnapshot = await nameQuery.get();
  //   final QuerySnapshot codeQuerySnapshot = await codeQuery.get();

  //   Set<String> patientIds = {}; // To avoid duplicate patients

  //   List<PatientModel> searchedPatients = [];

  //   // Process name query results
  //   if (nameQuerySnapshot.docs.isNotEmpty) {
  //     for (var doc in nameQuerySnapshot.docs) {
  //       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //       PatientModel patient = PatientModel.fromJson(data);
  //       if (patientIds.add(patient.id!)) {
  //         searchedPatients.add(patient);
  //       }
  //     }
  //   }

  //   // Process code query results
  //   if (codeQuerySnapshot.docs.isNotEmpty) {
  //     for (var doc in codeQuerySnapshot.docs) {
  //       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //       PatientModel patient = PatientModel.fromJson(data);
  //       if (patientIds.add(patient.id!)) {
  //         searchedPatients.add(patient);
  //       }
  //     }
  //   }

  //   // Update patient search list
  //   patientsearch.addAll(searchedPatients);
  //   patientsearch.refresh();
  //   update();

  //   if (searchedPatients.isEmpty) {
  //     hasMore.value = false;
  //   }

  //   isLoading.value = false;
  // }

  ////////////////////////////// upload image //////////////////
//   Future<String?> uploadImage(File imageFile) async {
//     try {
//       final storageRef = FirebaseStorage.instance
//           .ref()
//           .child('patient_images/${DateTime.now()}.jpg');
//       final uploadTask = await storageRef.putFile(imageFile);
//       final downloadUrl = await storageRef.getDownloadURL();
//       return downloadUrl;
//     } catch (e) {
//       print("Error uploading image: $e");
//       return null;
//     }
//   }
// Future<void> searchPatients(String name) async {
  //   isLoading.value = true;
  //   patientsearch.clear();
  //   Query query = membersCollection
  //       .where('name', isGreaterThanOrEqualTo: name)
  //       .where('name', isLessThan: name + 'z');

  //   final QuerySnapshot querySnapshot = await query.get();

  //   if (querySnapshot.docs.isNotEmpty) {
  //     List<PatientModel> searchedPatients = querySnapshot.docs.map((doc) {
  //       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //       return PatientModel.fromJson(data);
  //     }).toList();

  //     patientsearch.addAll(searchedPatients);
  //     patientsearch.refresh;
  //     update();
  //   } else {
  //     hasMore.value = false;
  //   }

  //   isLoading.value = false;
  // }
}
