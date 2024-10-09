import 'dart:io';

import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/common/inkwell_.dart';
import 'package:dental_app/core/utlis/assets_paths.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/patien_details/controller/patient_details_controller.dart';
import 'package:dental_app/features/patient/controller/patient_controller.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';
import 'package:dental_app/features/patien_details/widget/session_item.dart';
import 'package:dental_app/features/patien_details/widget/show_add_new_note.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SectionAddNote extends StatelessWidget {
  PaientDetailsCtrl con = Get.put(PaientDetailsCtrl());
  PatientModel item;

  SectionAddNote({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ensure that the controller's sessions list is updated with the patient's sessions.

    return Column(
      children: [
        InkWellCustom(
          onTap: () {
            if (Platform.isAndroid) {
              con.showScreenAddOrEditSessionMob(
                  session: null, context, item.id!);
            } else {
              con.showScreenAddSession(context, item.id!);
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 2.5,
            height: 80.h,
            decoration: BoxDecoration(
              color: AppColors.whiteff,
              borderRadius: BorderRadius.circular(18.0),
              border: Border.all(
                color: AppColors.primary,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                children: [
                  const Icon(
                    Icons.add,
                    size: 30,
                    color: AppColors.blueA1,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomText(
                    text: S.of(context).addNewSession,
                    fontWeight: FontWeight.w500,
                    bolUnderline: false,
                    color: AppColors.blueA1,
                    size: 10.sp,
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(() {
          // var sessions = con.itemobserval.value.session ?? [];
          return Expanded(
            child: (con.sessions.isEmpty)
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Image.asset(AssetPath.pagenotfound2)),
                    ),
                  )
                : ListView.builder(
                    itemCount: con.sessions.length,
                    itemBuilder: (context, index) {
                      print(con.sessions[index]);
                      return PatientSessionItem(
                          itemsession: con.sessions[index]);
                    },
                  ),
          );
        }),
      ],
    );
  }
}
