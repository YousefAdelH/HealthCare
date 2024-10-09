import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/core/utlis/helper_function.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/patien_details/widget_mob/add_new_session_mob.dart';
import 'package:dental_app/features/patien_details/widget_mob/patient_details_mob.dart';
import 'package:dental_app/features/patien_details/widget_mob/update_session_mob.dart';
import 'package:dental_app/features/setting/model/model_operations.dart';
import 'package:dental_app/features/patien_details/widget/update_add_session.dart';
import 'package:dental_app/features/patient/model/class_session.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';
import 'package:dental_app/features/patien_details/widget/show_add_new_note.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class PaientDetailsCtrl extends GetxController {
  final Rx<double> totalAmount = Rx<double>(0.0);
  var itemobserval = PatientModel().obs;
  final _db = FirebaseFirestore.instance;
  final CollectionReference membersCollection =
      FirebaseFirestore.instance.collection('patient');
  final TextEditingController idController = TextEditingController();
  // DateTime? sessionDate;
  // TimeOfDay? sessionTime;
  DateTime? sessionDate;
  TimeOfDay? sessionTime;
  var isDateValid = true.obs;
  var istimeValid = true.obs;
  final TextEditingController sessionNoteController = TextEditingController();
  final TextEditingController sessionPriceController = TextEditingController();
  var sessions = <Session>[].obs;
  var patients = <PatientModel>[].obs;
  var docRef;
  // bool?  = true;
  var isEdit = true.obs;
  var mainScreenIndex = 0.obs;
  changeIndex(int indx) {
    mainScreenIndex.value = indx;
    update();
  }

  List<Widget> mainScreenList = [
    Container(
      color: Colors.black,
    ),
    Container(
      color: Colors.red,
    )
  ];

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
      itemobserval.refresh;

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

    // sessions.clear();
  }

  void showDeleteSessionDialog(BuildContext context, String sessionId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.of(context).deleteSession),
          content: Text(S.of(context).deleteSessionConfirmation),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).cancel),
            ),
            TextButton(
              onPressed: () {
                deleteSession(sessionId);
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).delete),
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
      S.of(Get.context!).delete,
      S.of(Get.context!).sessionDeletedSuccessfully,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  var operations = <OperationModel>[].obs;
  var selectedOperation = Rx<OperationModel?>(null);
  void fetchOperations() {
    _db.collection('operations').snapshots().listen((snapshot) {
      operations.value = snapshot.docs
          .map((doc) => OperationModel.fromMap(doc.data(), doc.id))
          .toList();
      if (operations.isNotEmpty && selectedOperation.value == null) {
        selectedOperation.value = operations.first;
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    fetchOperations();
  }

/////////////////////////////add session
  var isOperations = false.obs;
  void setOperations() {
    isOperations.value = !isOperations.value;
    if (!isOperations.value) {
      selectedOperation.value = null;
    }
    // selectedOperation.value = OperationModel();
  }

  void addSession(BuildContext context, String patientId) async {
    final uuid = Uuid();
    final sessionId = uuid.v4();
    double? priceitems;

    if (isOperations.value) {
      priceitems = selectedOperation.value!.price ?? operations.first.price;
      // selectedOperation.value!.numOfTime += 1;
      final operation = selectedOperation.value!;
      operation.numOfTime = (operation.numOfTime ?? 0) + 1;
      operation.completedDates?.add(
          DateFormat('yyyy-MM-dd', 'en').format(sessionDate ?? DateTime.now()));

      await _db
          .collection('operations')
          .doc(operation.id)
          .set(operation.toMap());

      // Update operation in Firestore
    }
    final session = Session(
      operations: (selectedOperation.value != null &&
              selectedOperation.value!.name != "No operations available ")
          ? selectedOperation.value!.name
          : "",
      id: sessionId, // Assign the unique ID to the session
      date: DateFormat('yyyy-MM-dd', 'en').format(sessionDate!),
      note: sessionNoteController.text,
      time: sessionTime!.format(context),
      price: (isOperations.value &&
              selectedOperation.value!.name != "No operations available " &&
              selectedOperation.value != null)
          ? priceitems!.toStringAsFixed(2)
          : sessionPriceController.text,
    );

    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      final patientData = docSnapshot.data() as Map<String, dynamic>;
      final patient = PatientModel.fromJson(patientData);

      final newSessions = patient.session ?? [];
      newSessions.add(session);
      double totalPrice = 0.0;

      // for (var s in newSessions) {
      //   totalPrice += double.tryParse(s.price!) ?? 0.0;
      // }
      String total =
          HelperFunction.totalamount(session.price!, patient.totalPrice!);
      totalAmount.value += totalPrice;
      patientData['totalPrice'] = "0.00";
      patientData['totalPrice'] = total;
      patientData['session'] = newSessions.map((s) => s.toJson()).toList();

      String updateRemainamount =
          HelperFunction.remainingamount(total, patient.amountPaid ?? "0.0");
      patientData['remainingAmount'] = updateRemainamount;

      docRef.update(patientData).then((_) {
        clearsession();
        update();
      });

      // Update local sessions list and the observable patient model
      sessions.assignAll(newSessions);
      itemobserval.update((val) {
        val?.session = newSessions;
        val?.totalPrice = "0.00";
        val?.totalPrice = total;
        val?.remainingAmount = updateRemainamount;
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
            title: Text(S.of(context).newSession),
            content: Text(S.of(context).newSessionAddedSuccessfully),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(S.of(context).close),
              ),
            ],
          );
        },
      );
    }
  }

  void setSessionDate(DateTime date) {
    sessionDate = date;
    isDateValid.value = true;
    update();
  }

  void setSessionTime(TimeOfDay time) {
    sessionTime = time;
    istimeValid.value = true;
    update();
  }

  void validateDate() {
    if (sessionDate == null) {
      isDateValid.value = false;
    } else {
      isDateValid.value = true;
    }
  }

  void validateTime() {
    if (sessionDate == null) {
      isDateValid.value = false;
    } else {
      isDateValid.value = true;
    }
  }

  void showScreenAddSession(BuildContext context1, String id) {
    showDialog(
      context: context1,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.primary,
          title: Text(S.of(context).newSession),
          content: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width / 2,
            child: ShowAddNewNote(id: id),
          ),
          actions: [
            TextButton(
              onPressed: () {
                validateDate();
                if (isDateValid.value && istimeValid.value) {
                  addSession(context1, id);
                  Navigator.of(context).pop();
                }
              },
              child: Text(S.of(context).save),
            ),
          ],
        );
      },
    );
  }

  // add session mob/////////////////////
  void showScreenAddSessionMob(BuildContext context1, String id) {
    showModalBottomSheet<void>(
      backgroundColor: AppColors.primary,
      isScrollControlled: true,
      context: context1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14.r),
          topRight: Radius.circular(14.r),
        ),
      ),
      builder: (BuildContext context) {
        return ShowAddNewNoteMob(id: id);
      },
    );
    // showDialog(
    //   context: context1,
    //   builder: (context) {
    //     return AlertDialog(
    //       backgroundColor: AppColors.primary,
    //       title: Text(S.of(context).newSession),
    //       content: SizedBox(
    //         height: MediaQuery.of(context).size.height,
    //         width: MediaQuery.of(context).size.width / 2,
    //         child: ShowAddNewNote(id: id),
    //       ),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             addSession(context1, id);
    //             Navigator.of(context).pop();
    //           },
    //           child: Text(S.of(context).save),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  ////////////////////update session
  ///
  void clearsession() {
    // selectedOperation.value = OperationModel();
    setOperations();
    sessionDate = null;
    sessionTime = null;
    sessionNoteController.clear();
    sessionPriceController.clear();
  }

  void initializeSessionData(Session session) {
    sessionDate = DateFormat('yyyy-MM-dd').parse(session.date!);
    sessionTime =
        HelperFunction.sessionTimeFromFormatted(session.time!, DateTime.now());

    sessionNoteController.text = session.note!;
    sessionPriceController.text = session.price!;
    selectedOperation.value = operations
        .firstWhereOrNull((operation) => operation.name == session.operations);
    isOperations.value = selectedOperation.value != null;
  }

  Future<void> updateSession(
      BuildContext context, String patientId, String sessionId) async {
    final sessionIndex = sessions.indexWhere((s) => s.id == sessionId);
    if (sessionIndex == -1) return;

    double? priceitems;
    if (isOperations.value) {
      priceitems = selectedOperation.value!.price ?? operations.first.price;
      if (isOperations.value) {
        priceitems = selectedOperation.value!.price ?? operations.first.price;
        // selectedOperation.value!.numOfTime += 1;
        final operation = selectedOperation.value!;
        operation.numOfTime = (operation.numOfTime ?? 0) + 1;
        operation.completedDates?.add(DateFormat('yyyy-MM-dd', 'en')
            .format(sessionDate ?? DateTime.now()));

        await _db
            .collection('operations')
            .doc(operation.id)
            .set(operation.toMap());

        // Update operation in Firestore
      }
    }

    final updatedSession = Session(
      operations: selectedOperation.value?.name ?? "",
      id: sessionId,
      date:
          DateFormat('yyyy-MM-dd', 'en').format(sessionDate ?? DateTime.now()),
      note: sessionNoteController.text,
      time: sessionTime!.toString(),
      price: selectedOperation.value != null
          ? priceitems!.toStringAsFixed(2)
          : sessionPriceController.text,
    );

    sessions[sessionIndex] = updatedSession;

    final docRef = _db.collection('patients').doc(patientId);
    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      final patientData = docSnapshot.data() as Map<String, dynamic>;
      final patient = PatientModel.fromJson(patientData);

      final newSessions = patient.session ?? [];
      newSessions[sessionIndex] = updatedSession;
      patientData['session'] = newSessions.map((s) => s.toJson()).toList();

      String total = HelperFunction.totalamount(
          updatedSession.price!, patient.totalPrice!);
      totalAmount.value += double.parse(updatedSession.price!);
      patientData['totalPrice'] = total;

      String updateRemainamount =
          HelperFunction.remainingamount(total, patient.amountPaid ?? "0.0");
      patientData['remainingAmount'] = updateRemainamount;

      await docRef.update(patientData);

      sessions.assignAll(newSessions);
      itemobserval.update((val) {
        val?.session = newSessions;
        val?.totalPrice = total;
        val?.remainingAmount = updateRemainamount;
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
            title: Text("update"),
            content: Text(S.of(context).newSessionAddedSuccessfully),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(S.of(context).close),
              ),
            ],
          );
        },
      );
    }
  }

  void showScreenEditSession(BuildContext context1, String patientId,
      {Session? session}) {
    initializeSessionData(session!);

    showDialog(
      context: context1,
      builder: (context) {
        return PopScope(
          onPopInvoked: (didPop) {
            // clearsession();
          },
          child: AlertDialog(
            backgroundColor: AppColors.primary,
            title: Text(session == null
                ? S.of(context).newSession
                : S.of(context).editSession),
            content: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 2,
              child: ShowAddUpdateNewsession(
                id: patientId,
                sessionId: session?.id,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  bool shouldClearData =
                      await showClearDataConfirmationDialog(context);
                  if (shouldClearData) {
                    clearsession();
                    Navigator.of(context).pop();
                  }
                },
                child: Text(S.of(context).close),
              ),
              TextButton(
                onPressed: () {
                  updateSession(context1, patientId, session.id!);

                  Navigator.of(context).pop();
                },
                child: Text(S.of(context).save),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<bool> showClearDataConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(S.of(context).confirm),
              content: Text(S.of(context).Doyouwanttosavethechanges),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Clear data
                  },
                  child: Text(S.of(context).no),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // Do not clear data
                  },
                  child: Text(S.of(context).yes),
                ),
              ],
            );
          },
        ) ??
        false; // Return false if dialog is dismissed without selection
  }
// add or update session mob //////////////////
  // showBottomSheet(BuildContext context, Widget bottomSheet) {
  //   return showModalBottomSheet<void>(
  //     backgroundColor: AppColors.bottomSheetGrey,
  //     isScrollControlled: true,
  //     context: context,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(14.r),
  //         topRight: Radius.circular(14.r),
  //       ),
  //     ),
  //     builder: (BuildContext context) {
  //       return bottomSheet;
  //     },
  //   );
  // }

  void showScreenAddOrEditSessionMob(BuildContext context1, String patientId,
      {Session? session}) {
    if (session != null) {
      initializeSessionData(session);
    }
    showModalBottomSheet<void>(
      backgroundColor: AppColors.primary,
      isScrollControlled: true,
      context: context1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14.r),
          topRight: Radius.circular(14.r),
        ),
      ),
      builder: (BuildContext context) {
        return ShowAddNewNoteMob(
          id: patientId,
        );
      },
    );
  }

  //  controller edit      //
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController medicalController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController totalpriceController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  var selectedGender = ''.obs;
  void setSelectedGender(String gender) {
    selectedGender.value = gender;
    update();
  }

  Future<PatientModel> fetchPatienttoedit(String id) async {
    if (itemobserval.value.id == id) {
      return itemobserval.value;
    }
    // Get the patient document from Firestore
    docRef = membersCollection.doc(id);

    // Check if the document exists
    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      var patientData = docSnapshot.data() as Map<String, dynamic>;
      var patient = PatientModel.fromJson(patientData);
      return itemobserval.value = patient;

      // Update sessions list
    } else {
      // Handle the case where the document does not exist
      throw Exception("patient not found");
    }
  }

  void setEdit(String id) async {
    await fetchPatienttoedit(id);
    // isEdit.value = !isEdit.value;
    // update();
    if (isEdit.value) {
      // Enter edit mode: load existing data into controllers

      nameController.text = itemobserval.value.name ?? "";
      codeController.text = itemobserval.value.code ?? "";
      ageController.text = itemobserval.value.age ?? "";
      medicalController.text = itemobserval.value.medicalhistory ?? "";
      numberController.text = itemobserval.value.number ?? "";
      totalpriceController.text = itemobserval.value.totalPrice ?? "";
      amountController.text = itemobserval.value.amountPaid ?? "";
      selectedGender.value = itemobserval.value.gender ?? "";
    } else {
      // Exit edit mode: save changes
      saveEditedPatient(id);
    }
    isEdit.value = !isEdit.value;
    update();
  }

  void saveEditedPatient(id) async {
    PatientModel updatedPatient = PatientModel(
        id: itemobserval.value.id,
        name: nameController.text,
        code: codeController.text,
        age: ageController.text,
        medicalhistory: medicalController.text,
        number: numberController.text,
        totalPrice: totalpriceController.text,
        amountPaid: amountController.text,
        remainingAmount: HelperFunction.remainingamount(
            totalpriceController.text, amountController.text),
        gender: selectedGender.value,
        session: sessions
        // Include other necessary fields if there are any
        );

    itemobserval.value = updatedPatient;
    // Refresh the observable to reflect the changes

    final updatedData = updatedPatient.toJson();
    await docRef.update(updatedData).then((value) {
      print("DocumentSnapshot successfully updated!");
    }).catchError((e) {
      print("Error updating document: $e");
    });

    update();
  }

  // var images = <String>[].obs;

  // Future<void> uploadImage() async {
  //   FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //     allowMultiple: true,
  //   );

  //   if (pickedFile != null && itemobserval.value != null) {
  //     for (PlatformFile imageFile in pickedFile.files) {
  //       String fileName =
  //           'images/${itemobserval.value.id}/${DateTime.now().millisecondsSinceEpoch}_${imageFile.name}';

  //       try {
  //         // Upload image to Firebase Storage
  //         await FirebaseStorage.instance
  //             .ref(fileName)
  //             .putFile(File(imageFile.path!));
  //         print('Selected file path: ${imageFile.path}');

  //         // Get download URL of the uploaded image
  //         String downloadURL =
  //             await FirebaseStorage.instance.ref(fileName).getDownloadURL();

  //         // Add the URL to the images list
  //         images.add(downloadURL);

  //         // Update the patient model
  //         itemobserval.value.images!.add(downloadURL);

  //         // Save the URL in Firestore under the current patient document
  //         await FirebaseFirestore.instance
  //             .collection('patient')
  //             .doc(itemobserval.value.id)
  //             .update({
  //           'images': FieldValue.arrayUnion([downloadURL]),
  //         });
  //       } catch (e) {
  //         print('Error uploading image: $e');
  //       }
  //     }
  //   }
  // }

  // Future<void> fetchImages() async {
  //   if (itemobserval.value != null) {
  //     var doc = await FirebaseFirestore.instance
  //         .collection('patient')
  //         .doc(itemobserval.value.id)
  //         .get();
  //     if (doc.exists) {
  //       var data = doc.data() as Map<String, dynamic>;
  //       if (data.containsKey('images')) {
  //         images.value = List<String>.from(data['images']);
  //         itemobserval.value.images = images.value;
  //       }
  //     }
  //   }
  // }
  //  detailsMob
}
