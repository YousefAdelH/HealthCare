import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/core/utlis/helper_function.dart';
import 'package:dental_app/features/patient/model/class_session.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';
import 'package:dental_app/features/patient/widget/show_add_new_note.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class PaientDetailsCtrl extends GetxController {
  final Rx<double> totalAmount = Rx<double>(0.0);
  var itemobserval = PatientModel().obs;

  final CollectionReference membersCollection =
      FirebaseFirestore.instance.collection('patient');
  final TextEditingController idController = TextEditingController();
  DateTime? sessionDate;
  TimeOfDay? sessionTime;
  final TextEditingController sessionNoteController = TextEditingController();
  final TextEditingController sessionPriceController = TextEditingController();
  var sessions = <Session>[].obs;
  var patients = <PatientModel>[].obs;
  var docRef;
  // bool?  = true;
  var isEdit = true.obs;

  void getPatientId({required String id}) async {
    // Fetch patient details from Firestore
    clearPatientData();
    fetchPatientFromFirestore(id);

    // Update the observed patient model
  }

  void fetchPatientFromFirestore(String id) async {
    // Get the patient document from Firestore
    docRef = membersCollection.doc(id);

    // Check if the document exists
    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      var patientData = docSnapshot.data() as Map<String, dynamic>;
      var patient = PatientModel.fromJson(patientData);
      itemobserval.value = patient;

      // Update sessions list
      sessions.assignAll(patient.session ?? []);
    } else {
      // Handle the case where the document does not exist
      throw Exception("Patient not found");
    }
  }

// fetch patient id
  void clearPatientData() {
    itemobserval.value = PatientModel();
  }

  void setEdit() {
    isEdit.value = !isEdit.value;
    update();
    if (isEdit.value) {
      // Enter edit mode: load existing data into controllers
      print(itemobserval.value);
      nameController.text = itemobserval.value.name ?? "";
      ageController.text = itemobserval.value.age ?? "";
      medicalController.text = itemobserval.value.medicalhistory ?? "";
      numberController.text = itemobserval.value.number ?? "";
      totalpriceController.text = itemobserval.value.totalPrice ?? "";
      amountController.text = itemobserval.value.amountPaid ?? "";
      selectedGender = itemobserval.value.gender;
    } else {
      // Exit edit mode: save changes
      saveEditedPatient();
    }
    update();
  }

  void saveEditedPatient() async {
    PatientModel updatedPatient = PatientModel(
        id: itemobserval.value.id,
        name: nameController.text,
        age: ageController.text,
        medicalhistory: medicalController.text,
        number: numberController.text,
        totalPrice: totalpriceController.text,
        amountPaid: amountController.text,
        remainingAmount: HelperFunction.remainingamount(
            totalpriceController.text, amountController.text),
        gender: selectedGender,
        session: sessions
        // Include other necessary fields if there are any
        );

    itemobserval.value = updatedPatient;
    // Refresh the observable to reflect the changes

    print(itemobserval.value.name);
    final updatedData = updatedPatient.toJson();
    await docRef.update(updatedData).then((value) {
      print("DocumentSnapshot successfully updated!");
    }).catchError((e) {
      print("Error updating document: $e");
    });

    update();
    print(itemobserval.value.name);
  }

  void showDeleteSessionDialog(BuildContext context, String sessionId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Session'),
          content: Text(
              'Are you sure you want to permanently delete this session ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteSession(sessionId);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void deleteSession(String sessionId) async {
    final patient = itemobserval.value;

    // Remove the session from the patient's session list
    patient.session?.removeWhere((session) => session.id == sessionId);

    // Update the patient's data in Firestore
    final updatedData = {
      'session': patient.session?.map((s) => s.toJson()).toList(),
    };

    await docRef.update(updatedData);

    // Update local sessions list and the observable patient model
    sessions.assignAll(patient.session ?? []);
    itemobserval.update((val) {
      val?.session = patient.session;
    });

    // Update total amount and remaining amount
    double totalPrice = 0.0;
    for (var s in sessions) {
      totalPrice += double.tryParse(s.price!) ?? 0.0;
    }
    totalAmount.value = totalPrice;
    String updateRemainamount = HelperFunction.remainingamount(
        totalPrice.toStringAsFixed(2), patient.amountPaid ?? "0.0");
    itemobserval.update((val) {
      val?.totalPrice = totalAmount.toStringAsFixed(2);
      val?.remainingAmount = updateRemainamount;
    });

    update();

    Get.snackbar(
      'Success',
      'Session deleted successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

/////////////////////////////add session
  void addSession(BuildContext context, String patientId) async {
    final uuid = Uuid();
    final sessionId = uuid.v4(); // Generate a unique ID for the session

    final session = Session(
      id: sessionId, // Assign the unique ID to the session
      date: DateFormat('yyyy-MM-dd').format(sessionDate!),
      note: sessionNoteController.text,
      time: sessionTime!.format(context),
      price: sessionPriceController.text,
    );

    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      final patientData = docSnapshot.data() as Map<String, dynamic>;
      final patient = PatientModel.fromJson(patientData);

      final newSessions = patient.session ?? [];
      newSessions.add(session);
      double totalPrice = 0.0;
      for (var s in newSessions) {
        totalPrice += double.tryParse(s.price!) ?? 0.0;
      }
      totalAmount.value = totalPrice;

      patientData['session'] = newSessions.map((s) => s.toJson()).toList();
      patientData['totalPrice'] = totalAmount.toStringAsFixed(2);
      String updateRemainamount = HelperFunction.remainingamount(
          totalPrice.toStringAsFixed(2), patient.amountPaid ?? "0.0");
      patientData['remainingAmount'] = updateRemainamount;

      docRef.update(patientData).then((_) {
        sessionNoteController.clear();
        sessionPriceController.clear();
        update();
      });

      // Update local sessions list and the observable patient model
      sessions.assignAll(newSessions);
      itemobserval.update((val) {
        val?.session = newSessions;
      });

      var patientIndex = patients.indexWhere((p) => p.id == patientId);
      if (patientIndex != -1) {
        patients[patientIndex] = PatientModel.fromJson(patientData);
        patients.refresh();
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

  void setSessionDate(DateTime date) {
    sessionDate = date;
    update();
  }

  void setSessionTime(TimeOfDay time) {
    sessionTime = time;
    update();
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

  //  controller edit      //
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController medicalController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController totalpriceController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String? selectedGender;
  void setSelectedGender(String gender) {
    selectedGender = gender;
    update();
  }
}
