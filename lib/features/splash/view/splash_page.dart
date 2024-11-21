import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dental_app/core/utlis/assets_paths.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/splash/view/about_us.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);
  static String id = 'SplashPage';
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      animationDuration: const Duration(milliseconds: 2000),
      splashIconSize: 400,
      splash: Column(
        children: [
          SizedBox(
            height: 100.h,
          ),
          Image.asset(
            AssetPath.klogo,
            height: MediaQuery.of(context).size.width / 2,
            width: MediaQuery.of(context).size.width / 2,
          ),
          SizedBox(
            height: 70.h,
          ),
          LoadingAnimationWidget.hexagonDots(
            color: Colors.white,
            size: 30,
          ),
        ],
      ),
      nextScreen: const AboutUs(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: AppColors.primary,
    );
  }
}
