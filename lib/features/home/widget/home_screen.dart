import 'package:dental_app/common/responsive.dart';
import 'package:dental_app/core/utlis/assets_paths.dart';
import 'package:dental_app/core/utlis/constants.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/animation_intro/widget/animation_description.dart';
import 'package:dental_app/features/animation_intro/widget/image_animation.dart';
import 'package:dental_app/features/animation_intro/widget/text_profile_animation.dart';
import 'package:dental_app/features/home/widget/animation_contanier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: size.width,
                height: size.height / 2,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        AssetPath.home), // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              AnimatedContainerWidget(
                text2: "work",
                bottomPosition: 20,
                rightPosition:
                    (!Responsive.isDesktop(context)) ? size.width / 2 : 180.w,
                color: AppColors.bluewhite.withOpacity(0.8),
                text: "Data 1",
              ),
              AnimatedContainerWidget(
                bottomPosition: 20,
                rightPosition: (!Responsive.isDesktop(context)) ? 20.w : 10.w,
                color: AppColors.bluewhite.withOpacity(0.8),
                text: "Data 2",
                text2: "work2",
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                if (Responsive.isDesktop(context))
                  const AnimatedImageContainer(),
                const Spacer(),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Responsive(
                          desktop: MyPortfolioText(start: 40, end: 50),
                          largeMobile: MyPortfolioText(start: 40, end: 35),
                          mobile: MyPortfolioText(start: 35, end: 30),
                          tablet: MyPortfolioText(start: 50, end: 40)),
                      if (kIsWeb && Responsive.isLargeMobile(context))
                        Container(
                          height: defaultPadding,
                          color: Colors.transparent,
                        ),
                      const SizedBox(height: defaultPadding / 2),
                      const Responsive(
                        desktop: AnimatedDescriptionText(start: 14, end: 15),
                        largeMobile:
                            AnimatedDescriptionText(start: 14, end: 12),
                        mobile: AnimatedDescriptionText(start: 14, end: 12),
                        tablet: AnimatedDescriptionText(start: 17, end: 14),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      if (!Responsive.isDesktop(context))
                        SizedBox(
                          height: 200.h,
                          child: Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.23,
                              ),
                              const AnimatedImageContainer(
                                width: 150,
                                height: 200,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                const Spacer()
              ],
            ),
          )
        ],
      ),
    ));
  }
}

 // body: Padding(
        //   padding: EdgeInsets.symmetric(vertical: 20.h),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     mainAxisSize: MainAxisSize.max,
        //     children: [
        //       // Row(
        //       //   crossAxisAlignment: CrossAxisAlignment.start,
        //       //   mainAxisSize: MainAxisSize.max,
        //       //   mainAxisAlignment: MainAxisAlignment.center,
        //       //   children: [
        //       //     // SizedBox(
        //       //     //     width: MediaQuery.of(context).size.width / 3,
        //       //     //     height: MediaQuery.of(context).size.height / 2,
        //       //     //     child: BarChartSample6()),
        //       //     // SizedBox(
        //       //     //   width: 30.w,
        //       //     // ),
        //     SizedBox(
        //         width: MediaQuery.of(context).size.width / 2.5,
        //         height: MediaQuery.of(context).size.height / 2,
        //         child: PieChartOperation()),
        //   ],
        // ),
        //       // Row(
        //       //   mainAxisAlignment: MainAxisAlignment.center,
        //       //   children: [
        //       //     SizedBox(
        //       //       width: MediaQuery.of(context).size.width / 2,
        //       //       height: MediaQuery.of(context).size.height / 3,
        //       //       child:
        //       //           //  Obx(() {
        //       //           //   return controller.totalPatients.isEmpty
        //       //           //       ? Center(child: CircularProgressIndicator())
        //       //           //       : Linebadget(
        //       //           //           patientsData: controller.totalPatients.value,
        //       //           //           expensesData: controller.totalExpenses.value,
        //       //           //           transactionsData: controller.totalMaterial.value,
        //       //           //         );
        //       //           // }),
        //       //           LineChartmain(
        //       //         isShowingMainData: true,
        //       //       ),
        //       //     )
        //       //   ],
        //       // )
        //     ],
        //   ),
        // ),