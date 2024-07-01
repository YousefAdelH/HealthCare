import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/common/custom_text_form_field.dart';
import 'package:dental_app/core/utlis/app_string.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/patien_details/controller/patient_details_controller.dart';
import 'package:dental_app/features/patient/widget/section_add_note.dart';
import 'package:dental_app/features/patient/widget/user_info.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class PatientScreenDetails extends StatelessWidget {
  PaientDetailsCtrl con = Get.put(PaientDetailsCtrl());

  PatientScreenDetails({Key? key, required this.item}) : super(key: key) {
    con.getPatientId(id: item.id!);
    print("idselected ?????????");
    print(con.itemobserval.value.name);
  }
  PatientModel item;

  // PatientModel item =  sessionController.itemobserval ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon:
                (con.isEdit.value) ? Icon(Icons.edit_square) : Icon(Icons.save),
            onPressed: () {
              con.setEdit();
            },
          ),
        ],
        title: const Text("Patient Details"),
      ),
      body: Container(
        color: AppColors.bluewhite,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: AppColors.whiteff,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4.0,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Obx(
                        () {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: CircleAvatar(
                                  radius: 50, // Adjust the radius as needed
                                  backgroundImage:
                                      AssetImage('assets/img/3.png'),
                                ),
                              ),
                              ////////////////////name//////////
                              (con.isEdit.value)
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: CustomText(
                                        text: con.itemobserval.value.name ?? "",
                                        size: 14.sp,
                                        color: AppColors.black,
                                        underLineColor: AppColors.whiteff,
                                      ),
                                    )
                                  : SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CustomTextFormField(
                                          controller: con.nameController,
                                          label: AppStrings.name,
                                          // decoration: const InputDecoration(
                                          //     labelText: AppStrings.name),
                                        ),
                                      ),
                                    ),
                              ////////////////////gender ///////////
                              (con.isEdit.value)
                                  ? UserInfo(
                                      subtitle: AppStrings.gender,
                                      title:
                                          con.itemobserval.value.gender ?? "",
                                      icone: const Icon(Icons.person),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Row(
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: DropdownButton<String>(
                                                borderRadius: BorderRadius.zero,
                                                dropdownColor:
                                                    AppColors.whiteff,
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
                                                  AppStrings.male,
                                                  AppStrings.female
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                hint: const Text(
                                                    AppStrings.selectGender),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              ////////////////////age ///////////
                              (con.isEdit.value)
                                  ? UserInfo(
                                      subtitle: AppStrings.age,
                                      title: con.itemobserval.value.age ??
                                          "", // Replace this with item.age if available
                                      icone: Icon(Icons.cake),
                                    )
                                  : SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CustomTextFormField(
                                          label: AppStrings.age,
                                          controller: con.ageController,

                                          // decoration: const InputDecoration(
                                          //     labelText: AppStrings.age),
                                        ),
                                      ),
                                    ),

                              ////////////////////number ///////////
                              (con.isEdit.value)
                                  ? UserInfo(
                                      subtitle: AppStrings.number,
                                      title:
                                          con.itemobserval.value.number ?? "",
                                      icone: Icon(Icons.phone),
                                    )
                                  : SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CustomTextFormField(
                                          controller: con.numberController,
                                          label: AppStrings.number,
                                          // decoration: const InputDecoration(
                                          //     labelText: AppStrings.number),
                                        ),
                                      ),
                                    ),
                              ////////////////////medical hostory ///////////
                              (con.isEdit.value)
                                  ? UserInfo(
                                      subtitle: AppStrings.medicalhistory,
                                      title: con.itemobserval.value
                                              .medicalhistory ??
                                          "",
                                      icone: Icon(Icons.text_fields),
                                    )
                                  : SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CustomTextFormField(
                                          controller: con.medicalController,
                                          label: AppStrings.medicalhistory,
                                          // decoration: const InputDecoration(
                                          //     labelText: AppStrings.number),
                                        ),
                                      ),
                                    ),

                              SizedBox(
                                height: 50.h,
                              ),
                              Column(
                                children: [
                                  ////////////////////total amount ///////////
                                  (con.isEdit.value)
                                      ? UserInfo(
                                          subtitle: AppStrings.totalAmount,
                                          title: con.itemobserval.value
                                                  .totalPrice ??
                                              "",
                                          icone: const Icon(Icons.attach_money),
                                        )
                                      : SizedBox(
                                          height: 80.h,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              6,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomTextFormField(
                                              label: AppStrings.totalAmount,
                                              controller:
                                                  con.totalpriceController,
                                              // decoration: const InputDecoration(
                                              //     labelText: AppStrings.totalAmount),
                                            ),
                                          ),
                                        ),
                                  ////////////////////total amount ///////////
                                  (con.isEdit.value)
                                      ? UserInfo(
                                          subtitle: AppStrings.amountPaid,
                                          title: con.itemobserval.value
                                                  .amountPaid ??
                                              "",
                                          icone: const Icon(Icons.money_off),
                                        )
                                      : SizedBox(
                                          height: 80.h,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              6,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomTextFormField(
                                              label: AppStrings.totalAmount,
                                              controller: con.amountController,
                                              // decoration: const InputDecoration(
                                              //     labelText: AppStrings.totalAmount),
                                            ),
                                          ),
                                        ),
                                  SizedBox(
                                    height: 80.h,
                                    child: UserInfo(
                                      subtitle: AppStrings.remainingAmount,
                                      title: con.itemobserval.value
                                              .remainingAmount ??
                                          "",
                                      icone: const Icon(Icons.attach_money),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              Obx(() {
                return Expanded(
                  flex: 2,
                  child: SectionAddNote(
                    item: con.itemobserval.value,
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
