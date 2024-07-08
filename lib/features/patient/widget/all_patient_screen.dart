import 'dart:io';

import 'package:dental_app/common/custom_text_form_field.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/appointment/widget/calender_screen.dart';
import 'package:dental_app/features/patient/controller/patient_controller.dart';
import 'package:dental_app/features/patient/widget/add_new_patient.dart';
import 'package:dental_app/features/patient/widget/patient_list.dart';
import 'package:dental_app/features/patient/widget/search_screen.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class AllPatientScreen extends StatelessWidget {
  AllPatientScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaientCtrl>(
        init: PaientCtrl(),
        builder: (con) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Obx(() {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: CustomTextFormField(
                                label: "Name or Username",
                                onChange: (value) {
                                  con.searchController.text = value;
                                  con.searchPatientsByName();
                                },
                                controller: searchController,
                                prefixIconPath:
                                    const Icon(Icons.person_search_outlined),
                                suffix: (con.isSearch.value == true)
                                    ? GestureDetector(
                                        onTap: () {
                                          con.searchController.clear();
                                          con.setSearch(false);
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.all(12),
                                            child: Icon(Icons.clear)),
                                      )
                                    : GestureDetector(
                                        onTap: () {},
                                        child: const Padding(
                                            padding: EdgeInsets.all(12),
                                            child: Icon(Icons.search)),
                                      ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor:
                                    AppColors.primary, // Background color
                                backgroundColor: Colors.white, // Text color
                                side: const BorderSide(
                                    color: AppColors.primary,
                                    width: 2), // Border color and width
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      12), // Border radius
                                ),
                                minimumSize: Size(150.w, 60.h),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.add),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(S.of(context).addPatient),
                                ],
                              ),
                              onPressed: () {
                                // Handle button press
                                // For example, you can navigate to another screen or show a dialog
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddNewPatient()),
                                );
                              },
                            )
                          ],
                        ),
                        SizedBox(height: 20.h),
                        (con.isSearch.value == true)
                            ? SearchScreen()
                            : const DisplayAllpatientList(),
                      ],
                    );
                  }),
                ),
                SizedBox(width: 20.w),
                (Platform.isAndroid)
                    ? const SizedBox()
                    : Expanded(
                        flex: 1,
                        child: Container(),
                      ),
              ],
            ),
          );
        });
  }
}
