import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/common/inkwell_.dart';
import 'package:dental_app/core/utlis/app_string.dart';
import 'package:dental_app/core/utlis/assets_paths.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/appointment/widget/circle_price_amount.dart';
import 'package:dental_app/features/appointment/widget/date_card.dart';
import 'package:dental_app/features/patient/model/patiant_model.dart';
import 'package:dental_app/features/patient/widget/card_date.dart';
import 'package:dental_app/features/patien_details/patient_details_screen.dart';
import 'package:dental_app/features/patient/widget/user_info.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PatientCardAppointment extends StatelessWidget {
  PatientCardAppointment({Key? key, required this.item}) : super(key: key);
  PatientModel item;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWellCustom(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PatientScreenDetails(item: item)));
          },
          child: Container(
              padding: EdgeInsets.only(bottom: 10.h, left: 10.w, right: 10.w),
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
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                textAlign: TextAlign.start,
                                text: item.name ?? "",
                                size: 12.sp,
                                fontWeight: FontWeight.w700,
                                height: 1,
                                color: AppColors.primary,
                              ),
                              UserInfo(
                                subtitle: S.of(context).gender,
                                title: item.gender ?? "",
                                icone: Icon(Icons.person),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  UserInfo(
                                    subtitle: S.of(context).price,
                                    title:
                                        item.selectedSession!.price ?? " 0.00",
                                    icone:
                                        const Icon(Icons.attach_money_outlined),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          CardDates(
                            itemcard: item,
                          )
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, size: 18.h),
                    onPressed: () {},
                  ),
                ],
              ))),
    );
  }
}
