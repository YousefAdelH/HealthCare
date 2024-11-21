import 'dart:io';

import 'package:dental_app/common/formulas.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';
import 'package:dental_app/features/prescription/controller/prescription_controller.dart';
import 'package:dental_app/features/prescription/model/medication_model.dart';
import 'package:dental_app/features/prescription/widget/edit_prescription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class AddPrescription extends StatelessWidget {
  final PatientModel patient;
  AddPrescription({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrescriptionCtrl>(
      init: PrescriptionCtrl(),
      builder: (con) {
        return Scaffold(
          appBar: AppBar(title: Text("Add Prescription")),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: TypeAheadField<String>(
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: con.medicationController,
                              decoration: const InputDecoration(
                                  labelText: "Medication"),
                            ),
                            suggestionsCallback: (pattern) async {
                              // Ensure the return type is Future<List<String>>
                              return MedicalFormulas.medicalFormulas
                                  .where((formula) => formula
                                      .toLowerCase()
                                      .contains(pattern.toLowerCase()))
                                  .toList();
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: Text(suggestion),
                              );
                            },
                            onSuggestionSelected: (suggestion) {
                              // Set the selected suggestion to the controller's text field
                              con.medicationController.text = suggestion;
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: TypeAheadField<String>(
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: con.dosageController,
                              decoration:
                                  const InputDecoration(labelText: "Dosage"),
                            ),
                            suggestionsCallback: (pattern) async {
                              // Ensure the return type is Future<List<String>>
                              return MedicalFormulas.dosageformulas
                                  .where((formula) => formula
                                      .toLowerCase()
                                      .contains(pattern.toLowerCase()))
                                  .toList();
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: Text(suggestion),
                              );
                            },
                            onSuggestionSelected: (suggestion) {
                              // Set the selected suggestion to the controller's text field
                              con.dosageController.text = suggestion;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: TextField(
                            controller: con.instructionsController,
                            decoration: const InputDecoration(
                                labelText: "Instructions"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30.w,
                    ),
                    (Platform.isAndroid || Platform.isIOS)
                        ? ElevatedButton(
                            onPressed: con.addNewMedication,
                            child: const Text("Add"),
                          )
                        : ElevatedButton(
                            onPressed: con.addNewMedication,
                            child: const Text("Add New Medication"),
                          ),
                  ],
                ),

                // Display the list of medications using Obx
                Expanded(
                  child: Obx(() {
                    return ListView.builder(
                      itemCount: con.medications.length,
                      itemBuilder: (context, index) {
                        Medication medication = con.medications[index];
                        return ListTile(
                          title: Text(medication.medication ?? ''),
                          subtitle: Text(medication.dosage!),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              con.medications.removeAt(index);
                            },
                          ),
                        );
                      },
                    );
                  }),
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await con.generateAndUploadPrescription(patient, context);
                  },
                  child: const Text("Save & Download Prescription"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    con.fetchPrescriptions(patient.id!);
                    Get.to(() => PrescriptionScreen(patient: patient!));
                  },
                  child: const Text("All Prescriptions"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
