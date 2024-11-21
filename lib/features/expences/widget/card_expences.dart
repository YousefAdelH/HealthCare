import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/common/inkwell_.dart';
import 'package:dental_app/core/utlis/helper_function.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/expences/controller/expences_controller.dart';
import 'package:dental_app/features/expences/model/expences_model.dart';
import 'package:dental_app/features/expences/widget/add_new_expences.dart';
import 'package:dental_app/features/expences/widget/matial_info.dart';
import 'package:dental_app/features/patient/widget/user_info.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CardExpences extends StatelessWidget {
  CardExpences({Key? key, required this.expensesItem}) : super(key: key);
  final ExpenseModel expensesItem;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExpenseController>(
        init: ExpenseController(),
        builder: (con) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SizedBox(
              child: InkWellCustom(
                  onTap: () {
                    Get.to(AddNewExpences(
                      expense: expensesItem,
                    ));
                  },
                  child: Container(
                      padding: EdgeInsets.only(
                          bottom: 10.h, left: 10.w, right: 10.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: AppColors.black,
                            width: 1.0, // You can adjust the width as needed
                          ),
                          color: (expensesItem.type == 'Electricity' ||
                                  expensesItem.type == 'الكهرباء')
                              ? AppColors.color3
                              : (expensesItem.type == 'Rent' ||
                                      expensesItem.type == 'الايجار')
                                  ? AppColors.color2
                                  : (expensesItem.type == 'Water bill' ||
                                          expensesItem.type == "فاتورة المياه")
                                      ? AppColors.color1
                                      : (expensesItem.type == 'employees' ||
                                              expensesItem.type == 'الموظفين')
                                          ? AppColors.color5
                                          : (expensesItem.type == "Other" ||
                                                  expensesItem.type == "أخرى")
                                              ? AppColors.color4
                                              : Colors.white),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      InkWellCustom(
                                        onTap: () {
                                          con.deleteExpense( context,expensesItem.id);
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
                                        text: expensesItem.name ?? "",
                                        size: 12.sp,
                                        fontWeight: FontWeight.w700,
                                        height: 1,
                                        color: AppColors.black,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      UserInfo2(
                                        subtitle: S.of(context).type,
                                        title: expensesItem.type ?? "",
                                        icone:
                                            const Icon(Icons.bookmark_rounded),
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
                                      UserInfo2(
                                        subtitle: S.of(context).priceExpenses,
                                        title:
                                            expensesItem.expensesPrice ?? "0.0",
                                        icone: const Icon(Icons.attach_money),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      UserInfo2(
                                        subtitle: S.of(context).date,
                                        title: HelperFunction.formatDate(
                                            expensesItem.date),
                                        icone: const Icon(Icons.date_range),
                                      ),
                                    ],
                                  ),
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
            ),
          );
        });
  }
}
