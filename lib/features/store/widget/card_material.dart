import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/common/inkwell_.dart';
import 'package:dental_app/core/utlis/helper_function.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/patient/widget/user_info.dart';
import 'package:dental_app/features/store/controller/store_controller.dart';
import 'package:dental_app/features/store/model/material_model.dart';
import 'package:dental_app/features/store/widget/add_material_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CardMaterial extends StatelessWidget {
  CardMaterial({Key? key, required this.material}) : super(key: key);
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
                                      child: const SizedBox(
                                        child: Icon(Icons.delete),
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
                                    SizedBox(
                                      width: 80.w,
                                    ),
                                    UserInfo(
                                      subtitle: "quantity",
                                      title:
                                          material.quantity.toStringAsFixed(2),
                                      icone: Icon(Icons.person),
                                    ),
                                    UserInfo(
                                      subtitle: "expirationDate",
                                      title: HelperFunction.formatDate(
                                          material.expirationDate),
                                      icone: Icon(Icons.person),
                                    ),
                                    materialExpirationDate.isBefore(
                                            DateTime.now()
                                                .add(Duration(days: 30)))
                                        ? Icon(Icons.warning, color: Colors.red)
                                        : SizedBox(),
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
                                    UserInfo(
                                      subtitle: "wholesale Price",
                                      title: " ${material.wholesalePrice}",
                                      icone: Icon(Icons.money),
                                    ),
                                    UserInfo(
                                      subtitle: "selling Price",
                                      title: material.sellingPrice
                                          .toStringAsFixed(2),
                                      icone: Icon(Icons.money),
                                    ),
                                    UserInfo(
                                      subtitle: "Gain Price",
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

                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            if (material.quantity > 0) {
                              con.adjustQuantity(material.id, 1, false);
                            }
                          },
                        ),
                      ],
                    ))),
          );
        });
  }
}
