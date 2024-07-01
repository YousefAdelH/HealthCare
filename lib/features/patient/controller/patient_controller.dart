import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/core/utlis/helper_function.dart';
import 'package:dental_app/features/patient/widget/show_add_new_note.dart';
import 'package:dental_app/features/patient/model/class_session.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

class PaientCtrl extends GetxController {
  final Rx<double> totalAmount = Rx<double>(0.0);
  var searchController = TextEditingController();
  final CollectionReference membersCollection =
      FirebaseFirestore.instance.collection('patient');
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController medicalhistoryController =
      TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController totalpriceController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  // DateTime? selectedDate;
  // TimeOfDay? selectedTime;
  String? selectedGender;
  DateTime? sessionDate;
  TimeOfDay? sessionTime;
  final TextEditingController sessionNoteController = TextEditingController();
  final TextEditingController sessionPriceController = TextEditingController();

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

  Future<void> fetchPatients() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;

    Query query = membersCollection.orderBy('name').limit(limit);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument!);
    }

    final QuerySnapshot querySnapshot = await query.get();

    if (querySnapshot.docs.length < limit) {
      hasMore.value = false;
    }

    if (querySnapshot.docs.isNotEmpty) {
      lastDocument = querySnapshot.docs.last;

      List<PatientModel> newPatients = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return PatientModel.fromJson(data);
      }).toList();

      patients.addAll(newPatients);
    }

    isLoading.value = false;
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

  void addMember(BuildContext context) {
    final docRef = membersCollection.doc();
    final remainingAmount = HelperFunction.remainingamount(
        totalpriceController.text, amountController.text);

    final member = PatientModel(
      id: docRef.id,
      name: nameController.text,
      number: numberController.text,
      age: ageController.text,
      medicalhistory: medicalhistoryController.text,
      totalPrice: totalpriceController.text,
      amountPaid: amountController.text,
      remainingAmount: remainingAmount,
      // date: selectedDate?.toString(),
      // time: selectedTime?.format(context),
      gender: selectedGender,
      // session: [session],
    );

    docRef.set(member.toJson()).then((_) {
      // Clear the text fields after adding the member
      nameController.clear();
      numberController.clear();
      medicalhistoryController.clear();
      ageController.clear();
      totalpriceController.clear();
      amountController.clear();
      sessionNoteController.clear();

      update();
    });
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('New Patient'),
          content: Text('New patient added successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void addSession(BuildContext context, String patientId) async {
    final docRef = membersCollection.doc(patientId);

    final session = Session(
      date: DateFormat('yyyy-MM-dd').format(sessionDate!),
      note: sessionNoteController.text,
      time: sessionTime!.format(context),
      price: sessionPriceController.text,
    );

    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      final patientData = docSnapshot.data() as Map<String, dynamic>;
      final patient = PatientModel.fromJson(patientData);

      final sessions = patient.session ?? [];
      sessions.add(session);
      double totalPrice = 0.0;
      for (var session in sessions) {
        totalPrice += double.tryParse(session.price!) ?? 0.0;
      }
      totalAmount.value = totalPrice;

      patientData['session'] = sessions.map((s) => s.toJson()).toList();
      patientData['totalPrice'] = totalAmount.toStringAsFixed(2);
      String updateRemainamount = HelperFunction.remainingamount(
          totalPrice.toStringAsFixed(2), patient.amountPaid ?? "0.0");
      patientData['remainingAmount'] = updateRemainamount;

      docRef.update(patientData).then((_) {
        sessionNoteController.clear();
        sessionPriceController.clear();
        update();
      });
      var patientIndex = patients.indexWhere((p) => p.id == patientId);
      if (patientIndex != -1) {
        patients[patientIndex] = PatientModel.fromJson(patientData);
        patients.refresh(); // Refresh the observable list
      }

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New Session'),
            content: Text('New session added successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  void showScreenAddSession(BuildContext context1, String id) {
    showDialog(
      context: context1,
      builder: (context) {
        return AlertDialog(
          title: Text('New Session'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 1,
            width: MediaQuery.of(context).size.width / 2,
            child: ShowAddNewNote(id: id),
          ),
          actions: [
            TextButton(
              onPressed: () {
                addSession(context1, id);
                Navigator.of(context).pop();
              },
              child: Text('save'),
            ),
          ],
        );
      },
    );
  }

  void deletePatient(String patientId) async {
    try {
      await membersCollection.doc(patientId).delete();
      patients.removeWhere((patient) => patient.id == patientId);
      update();

      Get.snackbar(
        'Success',
        'Patient deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete patient: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Method to show confirmation dialog
  void showDeleteConfirmationDialog(BuildContext context, String patientId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Patient'),
          content:
              Text('Are you sure to permanently delete this patient\'s data?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deletePatient(patientId);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
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

  void searchPatientsByName() {
    String query = searchController.text.trim();
    if (query.isEmpty) {
      isSearch.value = false;
      // fetchPatients();
      print(query);
    } else {
      isSearch.value = true;
      searchPatients(query);
      print(query);
    }
  }

  Future<void> searchPatients(String name) async {
    isLoading.value = true;
    patientsearch.clear();
    Query query = membersCollection.where('name', isEqualTo: name);

    final QuerySnapshot querySnapshot = await query.get();

    if (querySnapshot.docs.isNotEmpty) {
      List<PatientModel> searchedPatients = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return PatientModel.fromJson(data);
      }).toList();

      patientsearch.addAll(searchedPatients);
      patientsearch.refresh;
      update();
    } else {
      hasMore.value = false;
    }

    isLoading.value = false;
  }
}
