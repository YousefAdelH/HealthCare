import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/patiant_model.dart';
import 'package:flutter/material.dart';
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
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedGender;

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    update();
  }

  void setSelectedTime(TimeOfDay time) {
    selectedTime = time;
    update();
  }

  void setSelectedGender(String gender) {
    selectedGender = gender;
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
    final member = PatientModel(
      id: docRef.id,
      name: nameController.text,
      number: numberController.text,
      age: ageController.text,
      medicalhistory: medicalhistoryController.text,
      totalPrice: totalpriceController.text,
      amountPaid: amountController.text,
      remainingAmount: remainingAmount ?? "",
      date: selectedDate?.toString(),
      time: selectedTime?.format(context),
      gender: selectedGender,
    );

    docRef.set(member.toJson()).then((_) {
      // Clear the text fields after adding the member
      nameController.clear();
      numberController.clear();
      medicalhistoryController.clear();
      ageController.clear();
      totalpriceController.clear();
      amountController.clear();
      selectedDate = null;
      selectedTime = null;
      selectedGender = null;
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
}
