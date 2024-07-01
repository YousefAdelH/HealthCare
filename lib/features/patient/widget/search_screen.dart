import 'package:dental_app/features/patient/controller/patient_controller.dart';
import 'package:dental_app/features/patient/widget/patient_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final searchFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaientCtrl>(
      builder: (con) {
        return Form(
          key: searchFormKey,
          child: Obx(() {
            return Expanded(
              child: Scrollbar(
                controller: con.scrollController,
                // isAlwaysShown: true,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: con.scrollController,
                  itemCount: con.patientsearch.length + 1,
                  itemBuilder: (context, index) {
                    if (index == con.patientsearch.length) {
                      return con.isLoading.value
                          ? Center(child: CircularProgressIndicator())
                          : con.hasMore.value
                              ? SizedBox.shrink()
                              : Center(child: Text('No more patients'));
                    }

                    return PatientCard(item: con.patientsearch[index]);
                  },
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
