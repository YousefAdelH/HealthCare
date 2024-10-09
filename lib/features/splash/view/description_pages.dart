import 'package:dental_app/features/main/mobile_widget/main_mobile.dart';
import 'package:dental_app/features/main/widget/main_view.dart';
import 'package:dental_app/features/splash/widgets/description_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DescriptionPages extends StatelessWidget {
  DescriptionPages({Key? key}) : super(key: key);

  static String id = 'DescriptionPages';
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      PageView(
        controller: controller,
        children: [
          DescriptionWidget(
            onpressed: () {
              Navigator.pop(context);
            },
            onTap: () {
              Get.offAll(
                () => MainViewMobile(),
                transition: Transition.noTransition, // No transition with GetX
              );
              // // Using PageTransition
              // Navigator.pushReplacement(
              //   context,
              //   PageTransition(
              //     type:
              //         PageTransitionType.fade, // Choose the type of transition
              //     child: MainViewMobile(),
              //     duration: Duration(milliseconds: 300),
              //   ),
              // );
            },
            screenName: 'Patient File',
            buttonText: 'Next',
            screenImage: 'assets/img/diagonsis_dscription.gif',
            description:
                """Complete management of patient files, including medical history, payments made and due, and detailed records of all sessions conducted..""",
          ),
          DescriptionWidget(
            onpressed: () {
              Get.to(() => previousPage());
            },
            onTap: () {
              Get.to(() => MainViewMobile());
            },
            screenName: 'Budget Management',
            buttonText: 'Start',
            screenImage: 'assets/img/medical_analysis_dscription.gif',
            description:
                'Set and manage a comprehensive budget for all clinic expenses and medication costs within a specified period, deducting these from total revenues to calculate net profit..',
          ),
        ],
      ),
      Container(
        alignment: const Alignment(0, .93),
        child: SmoothPageIndicator(
          controller: controller,
          count: 2,
          effect: const ExpandingDotsEffect(
            activeDotColor: Color(0xff8A8A8A),
            spacing: 10,
            dotHeight: 10,
            dotWidth: 25,
            dotColor: Color(0xffD2D0C5),
          ),
        ),
      ),
    ]);
  }

  nextPage() {
    controller.animateToPage(controller.page!.toInt() + 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  previousPage() {
    controller.animateToPage(controller.page!.toInt() - 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }
}
