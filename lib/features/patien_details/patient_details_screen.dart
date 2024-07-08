import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/common/custom_text_form_field.dart';
import 'package:dental_app/core/utlis/app_string.dart';
import 'package:dental_app/core/utlis/assets_paths.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/patien_details/controller/patient_details_controller.dart';
import 'package:dental_app/features/patient/widget/section_add_note.dart';
import 'package:dental_app/features/patient/widget/user_info.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PatientScreenDetails extends StatelessWidget {
  PaientDetailsCtrl con = Get.put(PaientDetailsCtrl());

  PatientScreenDetails({Key? key, required this.item}) : super(key: key) {
    con.getPatientId(id: item.id!);
    print("idselected ?????????");
    print(con.itemobserval.value.name);
  }
  PatientModel item;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        Get.delete<PaientDetailsCtrl>();
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Obx(() {
              return IconButton(
                icon: (con.isEdit.value)
                    ? Icon(Icons.edit_square)
                    : Icon(Icons.save),
                onPressed: () {
                  if (con.itemobserval.value.name == null) {
                  } else {
                    con.setEdit(item.id!);
                  }
                },
              );
            }),
          ],
          title: Text(S.of(context).patientDetails),
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
                          if (con.itemobserval.value.name == null) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: CircleAvatar(
                                      radius: 50, // Adjust the radius as needed
                                      backgroundImage: AssetImage(
                                        (con.itemobserval.value.gender ==
                                                    "Male" ||
                                                con.itemobserval.value.gender ==
                                                    "ذكر" ||
                                                con.itemobserval.value.gender ==
                                                    "")
                                            ? AssetPath.male
                                            : AssetPath.female,
                                      ),
                                    ),
                                  ),
                                  ////////////////////name//////////
                                  (con.isEdit.value)
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: CustomText(
                                            text: con.itemobserval.value.name ??
                                                "",
                                            size: 14.sp,
                                            color: AppColors.black,
                                            underLineColor: AppColors.whiteff,
                                          ),
                                        )
                                      : SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
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
                                          subtitle: S.of(context).gender,
                                          title:
                                              con.itemobserval.value.gender ??
                                                  "",
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
                                                      BorderRadius.circular(
                                                          18.0),
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
                                                    borderRadius:
                                                        BorderRadius.zero,
                                                    dropdownColor:
                                                        AppColors.whiteff,
                                                    elevation: 0,
                                                    underline: Container(
                                                      height: 1,
                                                      color: AppColors
                                                          .whiteff, // Replace with your underline color
                                                    ),
                                                    value: con.selectedGender!
                                                            .value.isEmpty
                                                        ? null
                                                        : con.selectedGender
                                                            .value,
                                                    onChanged:
                                                        (String? newValue) {
                                                      con.setSelectedGender(
                                                          newValue!);
                                                    },
                                                    items: <String>[
                                                      S.of(context).male,
                                                      S.of(context).female
                                                    ].map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                    hint: const Text(AppStrings
                                                        .selectGender),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  ////////////////////age ///////////
                                  (con.isEdit.value)
                                      ? UserInfo(
                                          subtitle: S.of(context).age,
                                          title: con.itemobserval.value.age ??
                                              "", // Replace this with item.age if available
                                          icone: Icon(Icons.cake),
                                        )
                                      : SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomTextFormField(
                                              validate: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
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
                                              label: S.of(context).age,
                                              controller: con.ageController,

                                              // decoration: const InputDecoration(
                                              //     labelText: AppStrings.age),
                                            ),
                                          ),
                                        ),

                                  ////////////////////number ///////////
                                  (con.isEdit.value)
                                      ? UserInfo(
                                          subtitle: S.of(context).number,
                                          title:
                                              con.itemobserval.value.number ??
                                                  "",
                                          icone: Icon(Icons.phone),
                                        )
                                      : SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomTextFormField(
                                              controller: con.numberController,
                                              label: AppStrings.number,
                                              validate: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
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
                                  ////////////////////medical hostory ///////////
                                  (con.isEdit.value)
                                      ? UserInfo(
                                          subtitle:
                                              S.of(context).medicalHistory,
                                          title: con.itemobserval.value
                                                  .medicalhistory ??
                                              "",
                                          icone: Icon(Icons.text_fields),
                                        )
                                      : SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CustomTextFormField(
                                              controller: con.medicalController,
                                              label:
                                                  S.of(context).medicalHistory,
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
                                              subtitle:
                                                  S.of(context).totalAmount,
                                              title: con.itemobserval.value
                                                      .totalPrice ??
                                                  "",
                                              icone: const Icon(
                                                  Icons.attach_money),
                                            )
                                          : SizedBox(
                                              height: 80.h,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  6,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CustomTextFormField(
                                                  validate: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
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
                                                  label:
                                                      S.of(context).totalAmount,
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
                                              subtitle:
                                                  S.of(context).amountPaid,
                                              title: con.itemobserval.value
                                                      .amountPaid ??
                                                  "",
                                              icone:
                                                  const Icon(Icons.money_off),
                                            )
                                          : SizedBox(
                                              height: 80.h,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  6,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CustomTextFormField(
                                                  label:
                                                      S.of(context).amountPaid,
                                                  controller:
                                                      con.amountController,
                                                  validate: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
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
                                        height: 80.h,
                                        child: UserInfo(
                                          subtitle:
                                              S.of(context).remainingAmount,
                                          title: con.itemobserval.value
                                                  .remainingAmount ??
                                              "",
                                          icone: const Icon(Icons.attach_money),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }
                        },
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
      ),
    );
  }
}
