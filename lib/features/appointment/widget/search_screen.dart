// import 'package:flutter/material.dart';
// import 'package:flutter_project/common/custom_text_form_field.dart';
// import 'package:flutter_project/features/appointment/controller/appointmemt_controller.dart';
// import 'package:flutter_project/features/appointment/widget/patient_card.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';

// class SearchScreen extends StatelessWidget {
//   SearchScreen({Key? key, required this.cardlist}) : super(key: key);
//   final Widget cardlist;
//   final searchFormKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AppointmemtCtrl>(
//       builder: (con) {
//         return SizedBox(
//           height: 65.sh,
//           child: Padding(
//             padding: EdgeInsets.only(
//               left: 10.w,
//               right: 10.w,
//               bottom: MediaQuery.of(context).viewInsets.bottom,
//             ),
//             child: SingleChildScrollView(
//               child: Form(
//                 key: searchFormKey,
//                 child: Column(
//                   children: [
//                     CustomTextFormField(
//                       label: "Name or Username",
//                       controller: con.searchController,
//                       prefixIconPath: const Icon(Icons.verified_user_rounded),
//                       suffix: GestureDetector(
//                         child: const Padding(
//                             padding: EdgeInsets.all(12),
//                             child: Icon(Icons.search)),
//                       ),
//                     ),
//                     AnimationLimiter(
//                       child: ListView.separated(
//                         physics: const BouncingScrollPhysics(),
//                         shrinkWrap: true,
//                         padding: EdgeInsets.zero,
//                         itemCount: 10,
//                         itemBuilder: (BuildContext context, int index) {
//                           return AnimationConfiguration.staggeredList(
//                             position: index,
//                             duration: const Duration(milliseconds: 450),
//                             child: const SlideAnimation(
//                               verticalOffset: 50.0,
//                               child: FadeInAnimation(
//                                 child: PatientCard(),
//                               ),
//                             ),
//                           );
//                         },
//                         separatorBuilder: (context, index) =>
//                             SizedBox(height: 14.h),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
