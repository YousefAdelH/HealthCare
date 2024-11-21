import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/common/custom_text_form_field.dart';
import 'package:dental_app/common/formulas.dart';
import 'package:dental_app/core/utlis/app_string.dart';
import 'package:dental_app/core/utlis/assets_paths.dart';
import 'package:dental_app/core/utlis/helper_function.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/patien_details/controller/patient_details_controller.dart';
import 'package:dental_app/features/patien_details/widget/all_medical_history.dart';
import 'package:dental_app/features/patien_details/widget/codation_edit.dart';
import 'package:dental_app/features/patien_details/widget/display_image_and_upload.dart';
import 'package:dental_app/features/patien_details/widget/image_view_single.dart';
import 'package:dental_app/features/patien_details/widget/section_add_note.dart';
import 'package:dental_app/features/patient/widget/user_info.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PatientScreenDetails extends StatelessWidget {
  PaientDetailsCtrl con = Get.put(PaientDetailsCtrl());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                    ? const Icon(Icons.edit_square)
                    : const Icon(Icons.save),
                onPressed: () {
                  if (con.itemobserval.value.name == null) {
                  } else {
                    if (formKey.currentState!.validate()) {
                      con.setEdit(item.id!);
                    }
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
                  child: Form(
                    key: formKey,
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
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else {
                              return SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CircleAvatar(
                                        radius:
                                            50, // Adjust the radius as needed
                                        backgroundImage: AssetImage(
                                          (con.itemobserval.value.gender ==
                                                      "Male" ||
                                                  con.itemobserval.value
                                                          .gender ==
                                                      "ذكر" ||
                                                  con.itemobserval.value
                                                          .gender ==
                                                      "")
                                              ? AssetPath.male
                                              : AssetPath.female,
                                        ),
                                      ),
                                    ),
                                    //////////////////////////////code//////////////////////
                                    (con.isEdit.value)
                                        ? UserInfo(
                                            subtitle: S.of(context).patientCode,
                                            title: con
                                                    .itemobserval.value.code ??
                                                "", // Replace this with item.age if available
                                            icone: const Icon(Icons.numbers),
                                          )
                                        : SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CustomTextFormField(
                                                validate: (value) =>
                                                    FormValidators
                                                        .validateNumber(
                                                  value,
                                                  S
                                                      .of(context)
                                                      .pleaseEnterValidNumber,
                                                ),
                                                label:
                                                    S.of(context).patientCode,
                                                controller: con.codeController,

                                                // decoration: const InputDecoration(
                                                //     labelText: AppStrings.age),
                                              ),
                                            ),
                                          ),
                                    ////////////////////name//////////
                                    (con.isEdit.value)
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: CustomText(
                                              text:
                                                  con.itemobserval.value.name ??
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child:
                                                        DropdownButton<String>(
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
                                                      value: con.selectedGender
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
                                                      hint: const Text(
                                                          AppStrings
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
                                            icone: const Icon(Icons.cake),
                                          )
                                        : SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CustomTextFormField(
                                                validate: (value) =>
                                                    FormValidators
                                                        .validateNumber(
                                                  value,
                                                  S
                                                      .of(context)
                                                      .pleaseEnterValidNumber,
                                                ),
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
                                            icone: const Icon(Icons.phone),
                                          )
                                        : SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CustomTextFormField(
                                                controller:
                                                    con.numberController,
                                                label: AppStrings.number,
                                              ),
                                            ),
                                          ),
                                    ////////////////////medical hostory ///////////
                                    AllmedicalHistory(con: con),

                                    SizedBox(
                                      height: 50.h,
                                    ),
                                    MangeAmountScreenDesktop(con: con),
                                  ],
                                ),
                              );
                            }
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
      ),
    );
  }
}

class MangeAmountScreenDesktop extends StatelessWidget {
  const MangeAmountScreenDesktop({
    super.key,
    required this.con,
  });

  final PaientDetailsCtrl con;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ////////////////////total amount ///////////
        (con.isEdit.value)
            ? UserInfo(
                subtitle: S.of(context).totalAmount,
                title: con.itemobserval.value.totalPrice ?? "",
                icone: const Icon(Icons.attach_money),
              )
            : SizedBox(
                height: 80.h,
                width: MediaQuery.of(context).size.width / 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormField(
                    validate: (value) => FormValidators.validateNumber(
                      value,
                      S.of(context).pleaseEnterValidNumber,
                    ),
                    label: S.of(context).totalAmount,
                    controller: con.totalpriceController,
                    // decoration: const InputDecoration(
                    //     labelText: AppStrings.totalAmount),
                  ),
                ),
              ),
        ////////////////////total amount ///////////
        (con.isEdit.value)
            ? UserInfo(
                subtitle: S.of(context).amountPaid,
                title: con.itemobserval.value.amountPaid ?? "",
                icone: const Icon(Icons.money_off),
              )
            : SizedBox(
                height: 80.h,
                width: MediaQuery.of(context).size.width / 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormField(
                    label: S.of(context).amountPaid,
                    controller: con.amountController,
                    validate: (value) => FormValidators.validateNumber(
                      value,
                      S.of(context).pleaseEnterValidNumber,
                    ),
                  ),
                ),
              ),
        SizedBox(
          height: 80.h,
          child: UserInfo(
            subtitle: S.of(context).remainingAmount,
            title: con.itemobserval.value.remainingAmount ?? "",
            icone: const Icon(Icons.attach_money),
          ),
        ),

        UploadImageAndDisplay(con: con)
      ],
    );
  }
}

// Widget buildPatientImages(BuildContext context) {
//   return GridView.builder(
//     shrinkWrap: true,
//     physics: NeverScrollableScrollPhysics(),
//     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 3,
//       mainAxisSpacing: 10,
//       crossAxisSpacing: 10,
//     ),
//     itemCount: con.itemobserval.value.images!.length,
//     itemBuilder: (context, index) {
//       return GestureDetector(
//         onTap: () => con.viewPatientImages(context),
//         child: Image.network(
//           con.itemobserval.value.images![index],
//           fit: BoxFit.cover,
//         ),
//       );
//     },
//   );
// }
