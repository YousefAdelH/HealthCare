import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/common/inkwell_.dart';
import 'package:dental_app/core/utlis/app_string.dart';
import 'package:dental_app/core/utlis/assets_paths.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/patien_details/widget_mob/patient_details_mob.dart';
import 'package:dental_app/features/patient/controller/patient_controller.dart';
import 'package:dental_app/features/patient/mobile_widget/card_date_mobile.dart';
import 'package:dental_app/features/patient/mobile_widget/user_info_mob.dart';
import 'package:dental_app/features/patient/widget/card_date.dart';
import 'package:dental_app/features/appointment/widget/circle_price_amount.dart';
import 'package:dental_app/features/patien_details/patient_details_screen.dart';
import 'package:dental_app/features/patient/widget/user_info.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PatientCardMobile extends StatelessWidget {
  const PatientCardMobile({Key? key, required this.item}) : super(key: key);
  final PatientModel item;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaientCtrl>(
        init: PaientCtrl(),
        builder: (con) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: InkWellCustom(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PatientDetailsMob(item: item)));
                },
                child: Container(
                    padding:
                        EdgeInsets.only(bottom: 10.h, left: 10.w, right: 10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: AppColors.black,
                        width: 1.0, // You can adjust the width as needed
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        //+++++++++++++++++++++++++++++ profile circle image
                        CircleAvatar(
                          radius: 20.r, // Adjust the radius as needed
                          backgroundImage: AssetImage(
                            (item.gender == "Male" ||
                                    item.gender == "ذكر" ||
                                    item.gender == "")
                                ? AssetPath.male
                                : AssetPath.female,
                          ),
                        ),
                        SizedBox(width: 7.w),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    CustomText(
                                      textAlign: TextAlign.start,
                                      text: item.name ?? "",
                                      size: 10.sp,
                                      fontWeight: FontWeight.w700,
                                      height: 1,
                                      color: AppColors.primary,
                                    ),
                                    UserInfoMob(
                                      subtitle: S.of(context).patientCode,
                                      title: item.code ?? "",
                                      icone: Icon(Icons.numbers_outlined,
                                          size: 10.h),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    UserInfoMob(
                                        title: item.age ?? "",
                                        subtitle: S.of(context).age,
                                        icone: Icon(Icons.person, size: 10.h)),
                                    UserInfoMob(
                                      icone: Icon(Icons.phone, size: 10.h),
                                      title: item.number ?? "",
                                      subtitle: S.of(context).number,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                MobileCardDates(
                                  itemcard: item,
                                )
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWellCustom(
                              onTap: () {
                                con.showDeleteConfirmationDialog(
                                    context, item.id!);
                              },
                              child: SizedBox(
                                child: Icon(
                                  Icons.delete,
                                  size: 15.h,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward_ios, size: 15.h),
                              onPressed: () {},
                            )
                          ],
                        ),
                      ],
                    ))),
          );
        });
  }
}
