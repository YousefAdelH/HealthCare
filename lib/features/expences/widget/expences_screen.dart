import 'package:dental_app/core/utlis/assets_paths.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/expences/controller/expences_controller.dart';
import 'package:dental_app/features/expences/widget/add_new_expences.dart';
import 'package:dental_app/features/expences/widget/card_expences.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ExpencesScreen extends StatelessWidget {
  ExpencesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExpenseController>(
        init: ExpenseController(),
        builder: (controller) {
          return SafeArea(
            child: Stack(children: [
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(AssetPath
                      .background2), // Your background image asset path
                  fit: BoxFit.contain,
                )),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(title: Text(S.of(context).expenses)),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor:
                                AppColors.primary, // Background color
                            backgroundColor: Colors.white, // Text color
                            side: const BorderSide(
                                color: AppColors.primary,
                                width: 2), // Border color and width
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // Border radius
                            ),
                            // minimumSize: Size(150.w, 60.h),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.filter_alt_sharp),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(S.of(context).filterExpenses),
                              // S.of(context).addPatient
                            ],
                          ),
                          onPressed: () async {
                            DateTime? selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                                initialDatePickerMode: DatePickerMode.year);

                            if (selectedDate != null) {
                              controller.isFilter();
                              controller.filterExpensesByDate(selectedDate);
                            }
                          },
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: Obx(() {
                          if (controller.isLoading.value) {
                            return Center(child: CircularProgressIndicator());
                          }

                          var expenseslist = controller.selectFilter.value
                              ? controller.filteredExpenses
                              : controller.expenses;
                          return Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: ListView.builder(
                              itemCount: expenseslist.length,
                              itemBuilder: (context, index) {
                                return CardExpences(
                                    expensesItem: expenseslist[index]);
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () => Get.to(AddNewExpences()),
                ),
              ),
            ]),
          );
        });
  }
}
