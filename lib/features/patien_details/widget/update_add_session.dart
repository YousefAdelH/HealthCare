import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/common/custom_text_form_field.dart';
import 'package:dental_app/core/utlis/app_string.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/appointment/controller/appointmemt_controller.dart';
import 'package:dental_app/features/patien_details/controller/patient_details_controller.dart';
import 'package:dental_app/features/patien_details/model/model_operations.dart';
import 'package:dental_app/features/patient/controller/patient_controller.dart';
import 'package:dental_app/features/setting/controller/setting_controller.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';

class ShowAddUpdateNewsession extends StatelessWidget {
  final String id;

  final bool isEditMode;
  final String? sessionId;
  ShowAddUpdateNewsession({
    super.key,
    required this.id,
    this.isEditMode = false,
    this.sessionId,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaientDetailsCtrl>(
        init: PaientDetailsCtrl(),
        builder: (con) {
          return Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.whiteF7,
                        borderRadius: BorderRadius.circular(18.0),
                        border: Border.all(
                          color: AppColors.primary,
                          width: 1.w, // You can adjust the width as needed
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                            '  ${con.sessionDate != null ? DateFormat.yMd().format(con.sessionDate!) : 'Select Session Date'}'),
                        trailing: Icon(Icons.calendar_today),
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: con.sessionDate ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null && picked != con.sessionDate) {
                            con.setSessionDate(picked);
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.whiteF7,
                        borderRadius: BorderRadius.circular(18.0),
                        border: Border.all(
                          color: AppColors.primary,
                          width: 1.w, // You can adjust the width as neede
                        ),
                      ),
                      child: ListTile(
                        title: Text(con.sessionTime == null
                            ? S.of(context).selectTime
                            : '${S.of(context).time}: ${con.sessionTime?.format(context)}'),
                        trailing: const Icon(Icons.access_time),
                        onTap: () async {
                          TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: con.sessionTime ?? TimeOfDay.now(),
                          );
                          if (picked != null && picked != con.sessionTime) {
                            con.setSessionTime(picked);
                          }
                        },
                      ),
                    ),
                  ),

                  //adding operations/////////////////////////////////
                  Obx(
                    () => (!con.isOperations.value)
                        ? Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: AppColors.blueA1,
                                backgroundColor: AppColors.blueA1,
                                side: const BorderSide(
                                  color: AppColors.primary,
                                  width: 2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                minimumSize: Size(150.w, 40.h),
                              ),
                              onPressed: () {
                                con.setOperations();
                              },
                              child: CustomText(
                                text: "operation ",
                                fontWeight: FontWeight.w500,
                                bolUnderline: false,
                                color: AppColors.whiteff,
                                size: 10.sp,
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: " Adding operations",
                                fontWeight: FontWeight.w500,
                                bolUnderline: false,
                                color: AppColors.whiteff,
                                size: 15.sp,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteF7,
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: AppColors.black,
                                        width:
                                            1, // You can adjust the width as needed
                                      ),
                                    ),
                                    child: DropdownButton<String>(
                                      padding: EdgeInsetsDirectional.all(8),
                                      underline: Container(
                                        height: 1,
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.zero,
                                      icon: Icon(Icons.shopping_bag,
                                          color: Colors.black),
                                      onChanged: (String? operationName) {
                                        if (operationName != null) {
                                          con.selectedOperation.value = con
                                              .operations
                                              .firstWhere((operation) =>
                                                  operation.name ==
                                                  operationName);
                                        }
                                      },
                                      value:
                                          con.selectedOperation.value?.name ??
                                              (con.operations.isNotEmpty
                                                  ? con.operations.first.name
                                                  : ""),
                                      items: con.operations
                                          .map<DropdownMenuItem<String>>(
                                              (operation) {
                                        return DropdownMenuItem<String>(
                                          value: operation.name,
                                          child: Text(
                                              '${operation.name} (\$${operation.price.toStringAsFixed(2)})'),
                                        );
                                      }).toList(),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: AppColors.blueA1,
                                    backgroundColor: AppColors.blueA1,
                                    side: const BorderSide(
                                      color: AppColors.primary,
                                      width: 2,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    minimumSize: Size(100.w, 40.h),
                                  ),
                                  onPressed: () {
                                    con.setOperations();
                                  },
                                  child: CustomText(
                                    text: "close operation ",
                                    fontWeight: FontWeight.w500,
                                    bolUnderline: false,
                                    color: AppColors.whiteff,
                                    size: 10.sp,
                                  ),
                                ),
                              )
                            ],
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: CustomTextFormField(
                      label: S.of(context).sessionNote,
                      controller: con.sessionNoteController,
                      maxLines: 10,
                    ),
                  ),
                  Obx(() => (!con.isOperations.value)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: SizedBox(
                                width: 100.w,
                                child: CustomTextFormField(
                                  label: S.of(context).price,
                                  controller: con.sessionPriceController,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox()),
                ],
              ),
            ),
          );
        });
  }
}
