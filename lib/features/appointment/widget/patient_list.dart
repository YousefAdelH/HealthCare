import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_app/features/appointment/controller/appointmemt_controller.dart';
import 'package:dental_app/features/appointment/widget/patient_card.dart';
import 'package:dental_app/features/appointment/model/patiant_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class DisplayAllpatient extends StatelessWidget {
//   const DisplayAllpatient({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('patient').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(child: Text('Something went wrong'));
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(child: Text('No patients found'));
//           }
//           List<PatientModel> patients = snapshot.data!.docs.map((doc) {
//             Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//             return PatientModel.fromJson(data);
//           }).toList();
//           return Expanded(
//             child: ListView.builder(
//               scrollDirection: Axis.vertical,
//               padding: EdgeInsets.zero,
//               itemCount: patients.length,
//               itemBuilder: (context, index) {
//                 return PatientCard(
//                   item: patients[index],
//                 );
//               },
//             ),
//           );
//         });
//   }
// }

class DisplayAllpatient extends StatelessWidget {
  const DisplayAllpatient({super.key});

  @override
  Widget build(BuildContext context) {
    final con = Get.put(AppointmemtCtrl());
    return Obx(
      () => Expanded(
        child: Scrollbar(
          controller: con.scrollController,
          // isAlwaysShown: true,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: con.scrollController,
            itemCount: con.patients.length + 1,
            itemBuilder: (context, index) {
              if (index == con.patients.length) {
                return con.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : con.hasMore.value
                        ? SizedBox.shrink()
                        : Center(child: Text('No more patients'));
              }

              return PatientCard(item: con.patients[index]);
            },
          ),
        ),
      ),
    );
  }
}
