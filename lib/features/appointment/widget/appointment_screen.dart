import 'package:dental_app/common/custom_text_form_field.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/appointment/widget/add_new_patient.dart';
import 'package:dental_app/features/appointment/widget/calender_screen.dart';
import 'package:dental_app/features/appointment/widget/patient_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:universal_io/io.dart';

class Appointment extends StatelessWidget {
  Appointment({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomTextFormField(
                        label: "Name or Username",
                        controller: searchController,
                        prefixIconPath: Icon(Icons.person_search_outlined),
                        suffix: GestureDetector(
                          child: const Padding(
                              padding: EdgeInsets.all(12),
                              child: Icon(Icons.search)),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.primary, // Background color
                        backgroundColor: Colors.white, // Text color
                        side: BorderSide(
                            color: AppColors.primary,
                            width: 2), // Border color and width
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12), // Border radius
                        ),
                        minimumSize: Size(150.w, 60.h),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text("Add new patient"),
                        ],
                      ),
                      onPressed: () {
                        // Handle button press
                        // For example, you can navigate to another screen or show a dialog
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddNewPatient()),
                        );
                      },
                    )
                  ],
                ),
                SizedBox(height: 20.h),
                DisplayAllpatient(),
              ],
            ),
          ),
          SizedBox(width: 20.w),
          (Platform.isAndroid)
              ? SizedBox()
              : Expanded(
                  flex: 1,
                  child: const Calenderscreen(),
                ),
        ],
      ),
    );
  }
}
