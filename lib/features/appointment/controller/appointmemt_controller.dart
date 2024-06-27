import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/appointment/model/class_session.dart';
import 'package:dental_app/features/appointment/model/patiant_model.dart';
import 'package:dental_app/features/appointment/widget/show_add_new_note.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AppointmemtCtrl extends GetxController {
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
  var isLoading = false.obs;
  var hasMore = true.obs;

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

  String remainingamount(String totalprice, String amount) {
    double total = double.tryParse(totalprice) ?? 0.0;
    double paid = double.tryParse(amount) ?? 0.0;
    return (total - paid).toStringAsFixed(2);
  }

  void addMember(BuildContext context) {
    final docRef = membersCollection.doc();
    final remainingAmount =
        remainingamount(totalpriceController.text, amountController.text);
    final session = Session(
      date: sessionDate!.toString(),
      time: sessionTime!.format(context),
      note: sessionNoteController.text,
    );
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
      sessions: [session],
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

  void showFullWidthBottomSheet(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('New Session'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 1,
            width: MediaQuery.of(context).size.width / 2,
            child: ShowAddNewNote(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('save'),
            ),
          ],
        );
      },
    );
  }
}
