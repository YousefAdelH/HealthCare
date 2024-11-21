import 'package:dental_app/features/patient/model/patiant_model.dart';
import 'package:dental_app/features/prescription/controller/prescription_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PrescriptionScreen extends StatelessWidget {
  final PatientModel patient;
  PrescriptionScreen({required this.patient});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrescriptionCtrl>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Prescriptions"),
          ),
          body: Obx(() {
            if (controller.allPrescriptions.isEmpty) {
              return Center(child: Text("No prescriptions available"));
            }
            return ListView.builder(
              itemCount: controller.allPrescriptions.length,
              itemBuilder: (context, index) {
                final prescription = controller.allPrescriptions[index];
                return ListTile(
                  title: GestureDetector(
                      onTap: () => controller.generatePdf(patient.name!,
                          prescription.medication, prescription.instructions),
                      child: Text("Prescription ${index + 1}")),
                  subtitle: Text("Instructions: ${prescription.instructions}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(DateFormat('yyyy-MM-dd').format(prescription.date)),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          // Show confirmation dialog before deletion
                          final confirm = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Delete Prescription"),
                              content: Text(
                                  "Are you sure you want to delete this prescription?"),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: Text("Delete"),
                                ),
                              ],
                            ),
                          );
                          if (confirm == true) {
                            await controller
                                .deletePrescription(prescription.id);
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }));
    });
  }
}

    










    
    //  GetBuilder<PrescriptionCtrl>(
    //   init: PrescriptionCtrl()..fetchPrescriptions(patientId),
    //   builder: (con) {
    //     return Scaffold(
          