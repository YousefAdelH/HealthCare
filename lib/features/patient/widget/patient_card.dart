import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/common/inkwell_.dart';
import 'package:dental_app/core/utlis/app_string.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/patient/controller/patient_controller.dart';
import 'package:dental_app/features/patient/widget/card_date.dart';
import 'package:dental_app/features/appointment/widget/circle_price_amount.dart';
import 'package:dental_app/features/patien_details/patient_details_screen.dart';
import 'package:dental_app/features/patient/widget/user_info.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({Key? key, required this.item}) : super(key: key);
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
                          builder: (context) =>
                              PatientScreenDetails(item: item)));
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
                          backgroundImage: const AssetImage('assets/img/3.png'),
                        ),
                        SizedBox(width: 7.w),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    InkWellCustom(
                                      onTap: () {
                                        con.showDeleteConfirmationDialog(
                                            context, item.id!);
                                      },
                                      child: const SizedBox(
                                        child: Icon(Icons.delete),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    CustomText(
                                      textAlign: TextAlign.start,
                                      text: item.name ?? "",
                                      size: 12.sp,
                                      fontWeight: FontWeight.w700,
                                      height: 1,
                                      color: AppColors.primary,
                                    ),
                                    SizedBox(
                                      width: 80.w,
                                    ),
                                    UserInfo(
                                      subtitle: AppStrings.gender,
                                      title: item.gender ?? "",
                                      icone: Icon(Icons.person),
                                    ),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     SizedBox(
                                    //       width: 10.w,
                                    //     ),
                                    //     CirclePriceAmount(
                                    //       amount: double.tryParse(
                                    //               item.remainingAmount ?? "") ??
                                    //           0.0,
                                    //       total: double.tryParse(
                                    //               item.totalPrice ?? "") ??
                                    //           1.0,
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                EventCardDates(
                                  itemcard: item,
                                )
                              ],
                            ),
                          ),
                        ),

                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios, size: 18.h),
                          onPressed: () {},
                        )
                      ],
                    ))),
          );
        });
  }
}
