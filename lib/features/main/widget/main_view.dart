import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/core/utlis/assets_paths.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/main/comtroller/main_controller.dart';
import 'package:dental_app/features/main/widget/line_tap_bar.dart';
import 'package:dental_app/features/main/widget/tab_bar_item.dart';
import 'package:dental_app/features/setting/controller/setting_controller.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class MainView extends StatelessWidget {
  MainView({Key? key}) : super(key: key);
  final LocalizationController con2 = Get.put(LocalizationController());

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
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.whiteF7,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: AppColors.black,
                              width: 1, // You can adjust the width as needed
                            ),
                          ),
                          child: DropdownButton<Locale>(
                            padding: EdgeInsetsDirectional.all(8),
                            underline: Container(
                              height: 1,
                              color: Colors
                                  .transparent, // Replace with your underline color
                            ),
                            borderRadius: BorderRadius.zero,
                            icon: Icon(Icons.language, color: Colors.black),
                            onChanged: (Locale? locale) {
                              if (locale != null) {
                                con2.changeLocale(locale);
                              }
                            },
                            value: con2.locale.value,
                            items: const [
                              DropdownMenuItem(
                                value: Locale('en'),
                                child: Text('English'),
                              ),
                              DropdownMenuItem(
                                value: Locale('ar'),
                                child: Text('العربية'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TapBarItem(
                                  text: S.of(context).login,
                                  index: 0,
                                ),
                                SizedBox(
                                  width: 30.w,
                                ),
                                TapBarItem(
                                  index: 1,
                                  text: S.of(context).signup,
                                )
                              ],
                            ),
                            SizedBox(height: 8.h),
                            LineTapBar(index: con.mainScreenIndex),
                            SizedBox(height: 15.h),
                            Row(
                              children: [
                                con.mainScreenList[con.mainScreenIndex]
                              ],
                            )
                          ],
                        ),
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
