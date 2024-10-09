import 'package:dental_app/common/custom_text_form_field.dart';
import 'package:dental_app/core/utlis/assets_paths.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/expences/controller/expences_controller.dart';
import 'package:dental_app/features/expences/model/expences_model.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddNewExpencesMob extends StatelessWidget {
  AddNewExpencesMob({Key? key, this.expense}) : super(key: key);
  final ExpenseModel? expense;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExpenseController>(
      init: ExpenseController(),
      builder: (con) {
        con.clearControllers();
        if (expense != null) {
          con.expensesname.value = expense!.name;
          con.expensesdate.value = DateTime.parse(expense!.date);
          con.expensestype.value =
              con.mapTypeToLocalizedString(context, expense!.type);
          con.expensesPrice.text = expense!.expensesPrice!;
        }

        return SafeArea(
            child: Stack(children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                  AssetPath.mobMaster), // Your background image asset path
              fit: BoxFit.fill,
            )),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: Text(expense == null
                    ? S.of(context).addExpense
                    : S.of(context).editExpense)),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomTextFormField(
                                label: S.of(context).name,
                                controller: TextEditingController(
                                  text: con.expensesname.value,
                                ),
                                onChange: (value) =>
                                    con.expensesname.value = value,
                                // decoration: const InputDecoration(
                                //     labelText: AppStrings.age),
                              ),
                            ),
                          ),
                          Obx(() {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomTextFormField(
                                  label: S.of(context).date,
                                  controller: TextEditingController(
                                    text: DateFormat('yyyy-MM-dd', 'en')
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
                            width: MediaQuery.of(context).size.width / 1.2,
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
                                  final numberRegExp = RegExp(r'^\d+$');
                                  if (!numberRegExp.hasMatch(value)) {
                                    return S.of(context).pleaseEnterValidNumber;
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Obx(() {
                            return Container(
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                color: AppColors.whiteF7,
                                borderRadius: BorderRadius.circular(18.0),
                                border: Border.all(
                                  color: AppColors.primary,
                                  width:
                                      1, // You can adjust the width as needed
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
                              if (formKey.currentState!.validate()) {
                                if (expense == null) {
                                  con.addExpense(context);
                                } else {
                                  con.updateExpense(expense!, context);
                                }

                                Get.back();
                              }
                            },
                            child: Text(expense == null
                                ? S.of(context).addExpense
                                : S.of(context).updateExpense),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]));
      },
    );
  }
}
