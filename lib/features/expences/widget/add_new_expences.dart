import 'package:dental_app/common/custom_text_form_field.dart';
import 'package:dental_app/core/utlis/helper_function.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/expences/controller/expences_controller.dart';
import 'package:dental_app/features/expences/model/expences_model.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';

class AddNewExpences extends StatelessWidget {
  AddNewExpences({Key? key, this.expense}) : super(key: key);
  final ExpenseModel? expense;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExpenseController>(
      init: ExpenseController(),
      builder: (con) {
        if (expense != null) {
          con.expensesname.value = expense!.name;
          con.expensesdate.value = DateTime.parse(expense!.date);
          con.expensestype.value = expense!.type;
          con.expensesPrice.text = expense!.expensesPrice!;
        }

        return Scaffold(
          appBar: AppBar(
              title: Text(expense == null
                  ? S.of(context).addExpense
                  : S.of(context).editExpense)),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextFormField(
                          label: S.of(context).name,
                          controller: TextEditingController(
                            text: con.expensesname.value,
                          ),
                          onChange: (value) => con.expensesname.value = value,
                          // decoration: const InputDecoration(
                          //     labelText: AppStrings.age),
                        ),
                      ),
                    ),
                    Obx(() {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextFormField(
                            label: S.of(context).date,
                            controller: TextEditingController(
                              text: DateFormat('yyyy-MM-dd')
                                  .format(con.expensesdate.value),
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: con.expensesdate.value,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (pickedDate != null &&
                                  pickedDate != con.expensesdate.value) {
                                con.expensesdate.value = pickedDate;
                              }
                            },
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextFormField(
                          textInputType: TextInputType.number,
                          label: S.of(context).price,
                          controller: con.expensesPrice,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).pleaseEnterNumber;
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return S.of(context).pleaseEnterValidNumber;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Obx(() {
                      return Container(
                        width: MediaQuery.of(context).size.width / 6,
                        decoration: BoxDecoration(
                          color: AppColors.whiteF7,
                          borderRadius: BorderRadius.circular(18.0),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 1, // You can adjust the width as needed
                          ),
                        ),
                        child: Center(
                          child: DropdownButton<String>(
                            underline: Container(
                              height: 1,
                              color: AppColors
                                  .whiteff, // Replace with your underline color
                            ),
                            value: con.expensestype.value.isEmpty
                                ? null
                                : con.expensestype.value,
                            hint: Text(S.of(context).selectType),
                            items: [
                              S.of(context).electricity,
                              S.of(context).rent,
                              S.of(context).waterBill,
                              S.of(context).employees,
                              S.of(context).other,
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              con.expensestype.value = value ?? '';
                            },
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (expense == null) {
                          con.addExpense(context);
                        } else {
                          con.updateExpense(expense!, context);
                        }
                        Get.back();
                      },
                      child: Text(expense == null
                          ? S.of(context).addExpense
                          : S.of(context).updateExpense),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
//  Container(
//                                             decoration: BoxDecoration(
//                                               color: AppColors.whiteF7,
//                                               borderRadius:
//                                                   BorderRadius.circular(18.0),
//                                               border: Border.all(
//                                                 color: AppColors.primary,
//                                                 width:
//                                                     1, // You can adjust the width as needed
//                                               ),
//                                             ),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(8.0),
//                                               child: DropdownButton<String>(
//                                                 borderRadius: BorderRadius.zero,
//                                                 dropdownColor:
//                                                     AppColors.whiteff,
//                                                 elevation: 0,
//                                                 underline: Container(
//                                                   height: 1,
//                                                   color: AppColors
//                                                       .whiteff, // Replace with your underline color
//                                                 ),
//                                                 value: con.selectedGender,
//                                                 onChanged: (String? newValue) {
//                                                   con.setSelectedGender(
//                                                       newValue!);
//                                                 },
//                                                 items: <String>[
//                                                   S.of(context).male,
//                                                   S.of(context).female
//                                                 ].map<DropdownMenuItem<String>>(
//                                                     (String value) {
//                                                   return DropdownMenuItem<
//                                                       String>(
//                                                     value: value,
//                                                     child: Text(value),
//                                                   );
//                                                 }).toList(),
//                                                 hint: Text(
//                                                     S.of(context).selectGender),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width:
//                                           MediaQuery.of(context).size.width / 4,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: CustomTextFormField(
//                                           label: S.of(context).age,
//                                           controller: con.ageController,

//                                           // decoration: const InputDecoration(
//                                           //     labelText: AppStrings.age),
//                                         ),
//                                       ),
//                                     ),

