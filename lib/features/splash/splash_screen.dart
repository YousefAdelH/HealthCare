// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_project/core/utlis/assets_paths.dart';
// import 'package:flutter_project/features/auth/widget/login.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// // import '../../helper/cash_helper/keys_name.dart';
// // import '../../helper/cash_helper/shared_pref.dart';

// class PartenersSplashScreen extends StatefulWidget {
//   const PartenersSplashScreen({Key? key}) : super(key: key);

//   @override
//   State<PartenersSplashScreen> createState() => _SplashScreen();
// }

// class _SplashScreen extends State<PartenersSplashScreen> {
//   double value = 0.0;
//   double opacity = 0;
//   bool isFirstTime = true;

//   @override
//   void initState() {
//     super.initState();
//     changeOpacity();
//     // getHomeActivitiesCategoriesData();
//     // getHomeTypesListData();
//     // getHomeCapacitiesListData();
//   }

//   Future<Widget> getHomePage() async {
//     // bool firstOpenApp = CacheHelper.getData(KeysName.firstTimeOpenApp) == null;
//     // String? isLoggedBefore = CacheHelper.getData(KeysName.accessToken);
//     // if (firstOpenApp == true) {
//     //   return const OnboardingScreen();
//     // } else if (isLoggedBefore != null) {
//     //   return const MainScreen();
//     // } else {
//     return const Login();
//     //}
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   changeOpacity() {
//     if (value < 1.0) {
//       Timer.periodic(const Duration(seconds: 1), (timer) {
//         if (mounted) {
//           setState(() {
//             value += 0.3;
//           });
//         }
//       });
//       Timer.periodic(const Duration(seconds: 2), (timer) {
//         if (mounted) {
//           setState(() {
//             opacity = 1 - opacity;
//             changeOpacity();
//           });
//         }
//       });
//     } else {
//       opacity = 1.0;
//       if (isFirstTime) {
//         navigate();
//         setState(() {
//           isFirstTime = false;
//         });
//       }
//     }
//   }

//   navigate() async {
//     Widget widget = await getHomePage();
//     if (context.mounted) {
//       navigateAndFinish(context, widget);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SizedBox(
//         width: double.infinity,
//         height: MediaQuery.of(context).size.height,
//         child: Center(
//           child: SvgPicture.asset(
//             AssetPath.handWithTextSvg,
//             width: 0.48.sw,
//             fit: BoxFit.fitWidth,
//           ),
//         ),
//       ),
//     );
//   }
// }
