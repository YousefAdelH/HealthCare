import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/core/utlis/assets_paths.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/main/comtroller/main_controller.dart';
import 'package:dental_app/features/main/widget/line_tap_bar.dart';
import 'package:dental_app/features/main/widget/tab_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile() {
      // Example condition: consider mobile if screen width is less than 600
      return MediaQuery.of(context).size.width < 600;
    }

    return GetBuilder<MainCtrl>(
        init: MainCtrl(),
        builder: (con) {
          return SafeArea(
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(AssetPath
                        .background), // Your background image asset path
                    fit: BoxFit.cover,
                  )),
                ),
                Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Stack(children: [
                    // Positioned(
                    //   top: 30,
                    //   left: 30,
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         height: 20,
                    //         width: 20,
                    //         color: Colors.black,
                    //       )
                    //     ],
                    //   ),
                    // ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 3,
                      right: MediaQuery.of(context).size.width / 8,
                      child: const Column(
                        children: [
                          CustomText(
                            text: "BETTER TEETH",
                            size: 50,
                            color: AppColors.whiteff,
                            fontfamily: AppFontNames.ralway,
                          ),
                          CustomText(
                            text: "BETTER TEETH",
                            size: 50,
                            color: AppColors.whiteff,
                            fontfamily: AppFontNames.ralway,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: isMobile() ? 10.w : 100.w,
                          vertical: isMobile() ? 50.h : 200.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const TapBarItem(
                                text: "Login",
                                index: 0,
                              ),
                              SizedBox(
                                width: 30.w,
                              ),
                              const TapBarItem(
                                index: 1,
                                text: "Sign up",
                              )
                            ],
                          ),
                          SizedBox(height: 8.h),
                          LineTapBar(index: con.mainScreenIndex),
                          SizedBox(height: 15.h),
                          Row(
                            children: [con.mainScreenList[con.mainScreenIndex]],
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          );
        });
  }
}
