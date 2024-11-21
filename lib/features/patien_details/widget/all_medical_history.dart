import 'package:dental_app/common/formulas.dart';
import 'package:dental_app/features/patien_details/controller/patient_details_controller.dart';
import 'package:dental_app/features/patien_details/widget/codation_edit.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllmedicalHistory extends StatelessWidget {
  const AllmedicalHistory({
    super.key,
    required this.con,
  });

  final PaientDetailsCtrl con;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConditionalFormType(
          controller: con.habitsController,
          isVisible: con.isEdit.value,
          label: S.of(context).habits,
          onSuggestionSelected: (suggestion) {
            con.habitsController.text = suggestion;
          },
          suggestionsCallback: (pattern) async {
            return MedicalFormulas.habitsFormulas
                .where((formula) =>
                    formula.toLowerCase().contains(pattern.toLowerCase()))
                .toList();
          },
          value: con.itemobserval.value.habits ?? "",
          widthFactor: 0.5.w,
        ),
        ConditionalFormType(
          controller: con.medicalController,
          isVisible: con.isEdit.value,
          label: S.of(context).medicalHistory,
          onSuggestionSelected: (suggestion) {
            con.medicalController.text = suggestion;
          },
          suggestionsCallback: (pattern) async {
            return MedicalFormulas.medicalHistoryFormulas
                .where((formula) =>
                    formula.toLowerCase().contains(pattern.toLowerCase()))
                .toList();
          },
          value: con.itemobserval.value.medicalhistory ?? "",
          widthFactor: 0.5.w,
        ),
        ConditionalFormType(
          controller: con.surgicalhistoryController,
          isVisible: con.isEdit.value,
          label: S.of(context).surgicalHistory,
          onSuggestionSelected: (suggestion) {
            con.surgicalhistoryController.text = suggestion;
          },
          suggestionsCallback: (pattern) async {
            return MedicalFormulas.surgicalHistoryFormulas
                .where((formula) =>
                    formula.toLowerCase().contains(pattern.toLowerCase()))
                .toList();
          },
          value: con.itemobserval.value.surgicalhistory ?? "",
          widthFactor: 0.5.w,
        ),
        ConditionalFormType(
          controller: con.labController,
          isVisible: con.isEdit.value,
          label: S.of(context).lab,
          onSuggestionSelected: (suggestion) {
            con.labController.text = suggestion;
          },
          suggestionsCallback: (pattern) async {
            return MedicalFormulas.labFormulas
                .where((formula) =>
                    formula.toLowerCase().contains(pattern.toLowerCase()))
                .toList();
          },
          value: con.itemobserval.value.lab ?? "",
          widthFactor: 0.5.w,
        ),
        ConditionalFormType(
          controller: con.diagnosisController,
          isVisible: con.isEdit.value,
          label: S.of(context).diagnosis,
          onSuggestionSelected: (suggestion) {
            con.diagnosisController.text = suggestion;
          },
          suggestionsCallback: (pattern) async {
            return MedicalFormulas.diagnosisFormulas
                .where((formula) =>
                    formula.toLowerCase().contains(pattern.toLowerCase()))
                .toList();
          },
          value: con.itemobserval.value.diagnosis ?? "",
          widthFactor: 0.5.w,
        ),
        ConditionalFormField(
          controller: con.notesController,
          isVisible: con.isEdit.value,
          label: S.of(context).notes,
          value: con.itemobserval.value.notes ?? "",
          widthFactor: 0.5.w,
        ),
      ],
    );
  }
}
