import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/common/custom_text_form_field.dart';
import 'package:dental_app/common/custom_text_type_field.dart';
import 'package:dental_app/common/formulas.dart';
import 'package:dental_app/core/utlis/app_string.dart';
import 'package:dental_app/core/utlis/assets_paths.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/patient/controller/patient_controller.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddNewPatient extends StatelessWidget {
  const AddNewPatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaientCtrl>(
        init: PaientCtrl(),
        builder: (con) {
          return SafeArea(
            child: Stack(children: [
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(AssetPath
                      .background2), // Your background image asset path
                  fit: BoxFit.contain,
                )),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  title: const Text(AppStrings.patient),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.transparent,
                    child: SingleChildScrollView(
                      child: Obx(() {
                        return (con.isSuccess.value)
                            ? Center(child: Image.asset(AssetPath.successimg))
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomTextFormField(
                                        controller: con.codeController,
                                        label: S.of(context).patientCode,
                                        validate: (value) {
                                          if (value == null || value.isEmpty) {
                                            return S
                                                .of(context)
                                                .pleaseEnterNumber;
                                          }
                                          if (!RegExp(r'^[0-9]+$')
                                              .hasMatch(value)) {
                                            return S
                                                .of(context)
                                                .pleaseEnterValidNumber;
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomTextFormField(
                                        controller: con.nameController,
                                        label: S.of(context).name,
                                        // decoration: const InputDecoration(
                                        //     labelText: AppStrings.name),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.whiteF7,
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            border: Border.all(
                                              color: AppColors.primary,
                                              width:
                                                  1, // You can adjust the width as needed
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DropdownButton<String>(
                                              borderRadius: BorderRadius.zero,
                                              dropdownColor: AppColors.whiteff,
                                              elevation: 0,
                                              underline: Container(
                                                height: 1,
                                                color: AppColors
                                                    .whiteff, // Replace with your underline color
                                              ),
                                              value: con.selectedGender,
                                              onChanged: (String? newValue) {
                                                con.setSelectedGender(
                                                    newValue!);
                                              },
                                              items: <String>[
                                                S.of(context).male,
                                                S.of(context).female
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              hint: Text(
                                                  S.of(context).selectGender),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomTextFormField(
                                        label: S.of(context).age,
                                        controller: con.ageController,
                                        validate: (value) {
                                          if (value == null || value.isEmpty) {
                                            return S
                                                .of(context)
                                                .pleaseEnterNumber;
                                          }
                                          if (!RegExp(r'^[0-9]+$')
                                              .hasMatch(value)) {
                                            return S
                                                .of(context)
                                                .pleaseEnterValidNumber;
                                          }
                                          return null;
                                        },
                                        // decoration: const InputDecoration(
                                        //     labelText: AppStrings.age),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomTextFormField(
                                        controller: con.numberController,
                                        label: S.of(context).number,
                                        validate: (value) {
                                          if (value == null || value.isEmpty) {
                                            return S
                                                .of(context)
                                                .pleaseEnterNumber;
                                          }
                                          if (!RegExp(r'^[0-9]+$')
                                              .hasMatch(value)) {
                                            return S
                                                .of(context)
                                                .pleaseEnterValidNumber;
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  CustomTypeAheadField(
                                    controller: con.habitsController,
                                    label: "habits",
                                    widthFactor: 0.5,
                                    suggestionsCallback: (pattern) async {
                                      return MedicalFormulas.habitsFormulas
                                          .where((formula) => formula
                                              .toLowerCase()
                                              .contains(pattern.toLowerCase()))
                                          .toList();
                                    },
                                    onSuggestionSelected: (suggestion) {
                                      con.habitsController.text = suggestion;
                                    },
                                  ),
                                  CustomTypeAheadField(
                                    controller: con.medicalhistoryController,
                                    label: S.of(context).medicalHistory,
                                    widthFactor: 0.5,
                                    maxLines: 10,
                                    suggestionsCallback: (pattern) async {
                                      return MedicalFormulas
                                          .medicalHistoryFormulas
                                          .where((formula) => formula
                                              .toLowerCase()
                                              .contains(pattern.toLowerCase()))
                                          .toList();
                                    },
                                    onSuggestionSelected: (suggestion) {
                                      con.medicalhistoryController =
                                          suggestion as TextEditingController;
                                    },
                                  ),
                                  CustomTypeAheadField(
                                    controller: con.surgicalhistoryController,
                                    label: "Surgical History",
                                    maxLines: 10,
                                    widthFactor: 0.5,
                                    suggestionsCallback: (pattern) async {
                                      return MedicalFormulas
                                          .surgicalHistoryFormulas
                                          .where((formula) => formula
                                              .toLowerCase()
                                              .contains(pattern.toLowerCase()))
                                          .toList();
                                    },
                                    onSuggestionSelected: (suggestion) {
                                      con.surgicalhistoryController.text =
                                          suggestion;
                                    },
                                  ),
                                  CustomTypeAheadField(
                                    controller: con.labController,
                                    label: "Lab",
                                    maxLines: 10,
                                    widthFactor: 0.5,
                                    suggestionsCallback: (pattern) async {
                                      return MedicalFormulas.labFormulas
                                          .where((formula) => formula
                                              .toLowerCase()
                                              .contains(pattern.toLowerCase()))
                                          .toList();
                                    },
                                    onSuggestionSelected: (suggestion) {
                                      con.labController.text = suggestion;
                                    },
                                  ),
                                  CustomTypeAheadField(
                                    controller: con.diagnosisController,
                                    label: "Diagnosis",
                                    widthFactor: 0.5,
                                    suggestionsCallback: (pattern) async {
                                      return MedicalFormulas.diagnosisFormulas
                                          .where((formula) => formula
                                              .toLowerCase()
                                              .contains(pattern.toLowerCase()))
                                          .toList();
                                    },
                                    onSuggestionSelected: (suggestion) {
                                      con.diagnosisController.text = suggestion;
                                    },
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomTextFormField(
                                        label: "Notes",
                                        maxLines: 10,
                                        controller: con.notesController,
                                        // decoration: const InputDecoration(
                                        //     labelText: AppStrings.medicalhistory),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomTextFormField(
                                        label: S.of(context).totalAmount,
                                        controller: con.totalpriceController,
                                        validate: (value) {
                                          if (value == null || value.isEmpty) {
                                            return S
                                                .of(context)
                                                .pleaseEnterNumber;
                                          }
                                          if (!RegExp(r'^[0-9]+$')
                                              .hasMatch(value)) {
                                            return S
                                                .of(context)
                                                .pleaseEnterValidNumber;
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomTextFormField(
                                        label: S.of(context).amountPaid,
                                        controller: con.amountController,
                                        validate: (value) {
                                          if (value == null || value.isEmpty) {
                                            return S
                                                .of(context)
                                                .pleaseEnterNumber;
                                          }
                                          if (!RegExp(r'^[0-9]+$')
                                              .hasMatch(value)) {
                                            return S
                                                .of(context)
                                                .pleaseEnterValidNumber;
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: AppColors
                                                .success2, // Background color
                                            backgroundColor: AppColors
                                                .success2, // Text color
                                            side: const BorderSide(
                                                color: AppColors.primary,
                                                width:
                                                    2), // Border color and width
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      12), // Border radius
                                            ),
                                            minimumSize: Size(150.w, 80.h),
                                          ),
                                          onPressed: () {
                                            con.addMember(context);
                                          },
                                          child: CustomText(
                                            text: S.of(context).addPatient,
                                            fontWeight: FontWeight.w500,
                                            bolUnderline: false,
                                            color: AppColors.whiteff,
                                            size: 10.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              );
                      }),
                    ),
                  ),
                ),
              ),
            ]),
          );
        });
  }
}
