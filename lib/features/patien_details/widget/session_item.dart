import 'dart:io';

import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/common/inkwell_.dart';
import 'package:dental_app/core/utlis/app_string.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/patien_details/controller/patient_details_controller.dart';
import 'package:dental_app/features/patient/model/class_session.dart';
import 'package:dental_app/features/patient/widget/user_info.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class PatientSessionItem extends StatelessWidget {
  var textBoxhController = TextEditingController();

  PatientSessionItem({
    super.key,
    this.itemsession,
  });
  Session? itemsession;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaientDetailsCtrl>(
        init: PaientDetailsCtrl(),
        builder: (con) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Container(
              padding: const EdgeInsets.all(16.0),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: S.of(context).sessionNote,
                        size: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                        underLineColor: AppColors.whiteff,
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: itemsession!.time ?? "",
                            size: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                            underLineColor: AppColors.whiteff,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          CustomText(
                            text: itemsession!.date ?? "",
                            size: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                            underLineColor: AppColors.whiteff,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          InkWellCustom(
                            onTap: () {
                              con.showDeleteSessionDialog(
                                  context, itemsession!.id!);
                            },
                            child: const SizedBox(
                              child: Icon(Icons.delete),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          InkWellCustom(
                            onTap: () {
                              if (Platform.isAndroid || Platform.isIOS) {
                                con.showScreenAddOrEditSessionMob(
                                    session: itemsession,
                                    context,
                                    itemsession!.id!);
                              } else {
                                con.showScreenEditSession(
                                    session: itemsession,
                                    context,
                                    itemsession!.id!);
                              }
                            },
                            child: SizedBox(
                              child: Icon(Icons.edit_document),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  CustomText(
                    text: S.of(context).note,
                    size: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                    underLineColor: AppColors.whiteff,
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  CustomText(
                    text: itemsession!.note ?? "",
                    size: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                    underLineColor: AppColors.whiteff,
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  UserInfo(
                    subtitle: S.of(context).price,
                    title: itemsession!.price ?? "",
                    icone: Icon(Icons.person),
                  ),
                  // CustomTextFormField(
                  //   label: "Enter your notes here",
                  //   controller: textBoxhController,
                  //   maxLines: 6,
                  // ),
                ],
              ),
            ),
          );
        });
  }
}
