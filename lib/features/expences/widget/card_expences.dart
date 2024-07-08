import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/common/inkwell_.dart';
import 'package:dental_app/core/utlis/helper_function.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/expences/controller/expences_controller.dart';
import 'package:dental_app/features/expences/model/expences_model.dart';
import 'package:dental_app/features/expences/widget/add_new_expences.dart';
import 'package:dental_app/features/patient/widget/user_info.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CardExpences extends StatelessWidget {
  CardExpences({Key? key, required this.expencesItem}) : super(key: key);
  final ExpenseModel expencesItem;
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
                      expense: expencesItem,
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
                        color: (expencesItem.type == 'Electricity')
                            ? Color.fromARGB(193, 245, 154, 147)
                            : (expencesItem.type == 'Rent')
                                ? const Color.fromARGB(255, 128, 191, 241)
                                : (expencesItem.type == 'Other')
                                    ? Colors.green
                                    : Colors.white,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      InkWellCustom(
                                        onTap: () {
                                          con.deleteExpense(expencesItem.id);
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
                                        text: expencesItem.name ?? "",
                                        size: 12.sp,
                                        fontWeight: FontWeight.w700,
                                        height: 1,
                                        color: AppColors.primary,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      UserInfo(
                                        subtitle: S.of(context).type,
                                        title: expencesItem.type ?? "",
                                        icone:
                                            Icon(Icons.manage_accounts_sharp),
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
                                      UserInfo(
                                        subtitle: S.of(context).priceExpenses,
                                        title:
                                            expencesItem.expensesPrice ?? "0.0",
                                        icone: Icon(Icons.attach_money),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      UserInfo(
                                        subtitle: S.of(context).date,
                                        title: HelperFunction.formatDate(
                                            expencesItem.date),
                                        icone: Icon(Icons.date_range),
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
