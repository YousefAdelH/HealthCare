import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/common/inkwell_.dart';
import 'package:dental_app/core/utlis/helper_function.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/patient/mobile_widget/user_info_mob.dart';
import 'package:dental_app/features/store/controller/store_controller.dart';
import 'package:dental_app/features/store/model/material_model.dart';
import 'package:dental_app/features/store/widget/add_material_screen.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CardMaterialMob extends StatelessWidget {
  CardMaterialMob({Key? key, required this.material}) : super(key: key);
  final DentalMaterial material;
  @override
  Widget build(BuildContext context) {
    var materialExpirationDate = DateTime.parse(material.expirationDate);
    return GetBuilder<MaterialController>(
        init: MaterialController(),
        builder: (con) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: InkWellCustom(
                onTap: () {
                  Get.to(AddMaterialScreen(material: material));
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
                                        con.deleteMaterial(material.id);
                                      },
                                      child: SizedBox(
                                        child: Icon(
                                          Icons.delete,
                                          size: 15.h,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    CustomText(
                                      textAlign: TextAlign.start,
                                      text: material.name ?? "",
                                      size: 12.sp,
                                      fontWeight: FontWeight.w700,
                                      height: 1,
                                      color: AppColors.primary,
                                    ),
                                    Row(
                                      children: [
                                        UserInfoMob(
                                          subtitle: S.of(context).quantity,
                                          title: material.quantity
                                              .toStringAsFixed(2),
                                          icone: Icon(
                                              Icons.production_quantity_limits),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.remove),
                                          onPressed: () {
                                            if (material.quantity > 0) {
                                              con.adjustQuantity(
                                                  material.id,
                                                  1,
                                                  false,
                                                  material.wholesalePrice
                                                      .toStringAsFixed(2));
                                            }
                                          },
                                        ),
                                      ],
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
                                      subtitle: S.of(context).wholesalePrice,
                                      title: " ${material.wholesalePrice}",
                                      icone: Icon(Icons.money),
                                    ),
                                    UserInfoMob(
                                      subtitle: S.of(context).expirationDate,
                                      title: HelperFunction.formatDate(
                                          material.expirationDate),
                                      icone: Icon(Icons.date_range_sharp),
                                    ),
                                    materialExpirationDate.isBefore(
                                            DateTime.now()
                                                .add(Duration(days: 30)))
                                        ? Icon(
                                            Icons.warning,
                                            color: Colors.red,
                                            size: 15.h,
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    UserInfoMob(
                                      subtitle: S.of(context).sellingPrice,
                                      title: material.sellingPrice
                                          .toStringAsFixed(2),
                                      icone: Icon(Icons.money),
                                    ),
                                    UserInfoMob(
                                      subtitle: S.of(context).gainPrice,
                                      title:
                                          material.gainPrice.toStringAsFixed(2),
                                      icone: Icon(Icons.money_off_rounded),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ))),
          );
        });
  }
}
