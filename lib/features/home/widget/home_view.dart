import 'dart:io';

import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/common/inkwell_.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/all_patient/widget/appointment_show.dart';
import 'package:dental_app/features/auth/controller/auth_controller.dart';
import 'package:dental_app/features/badget_mangment/screen_badget.dart';
import 'package:dental_app/features/expences/widget/add_new_expences.dart';
import 'package:dental_app/features/expences/widget/expences_screen.dart';
import 'package:dental_app/features/home/controller/home_controller.dart';
import 'package:dental_app/features/main/widget/main_view.dart';
import 'package:dental_app/features/patient/widget/add_new_patient.dart';
import 'package:dental_app/features/appointment/widget/appointment_screen.dart';
import 'package:dental_app/features/home/widget/home_screen.dart';
import 'package:dental_app/features/patient/widget/all_patient_screen.dart';
import 'package:dental_app/features/setting/widget/setting_screen.dart';
import 'package:dental_app/features/store/widget/add_material_screen.dart';
import 'package:dental_app/features/store/widget/strore_screen.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final _controller = SidebarXController(selectedIndex: 0);
  final AuthCtrl con2 = Get.put(AuthCtrl());
  HomeCtrl con = Get.put(HomeCtrl());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SidebarX(
            controller: _controller,
            theme: SidebarXTheme(
              margin: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(0),
              ),
              hoverIconTheme: const IconThemeData(color: AppColors.whiteff),
              selectedIconTheme: const IconThemeData(color: AppColors.primary),
              textStyle: const TextStyle(color: Colors.white),
              selectedTextStyle: const TextStyle(color: AppColors.primary),
              itemTextPadding: const EdgeInsets.only(left: 10),
              selectedItemTextPadding: const EdgeInsets.only(left: 10),
              itemDecoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
              ),
              selectedItemDecoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                ),
                border: Border.all(color: AppColors.blueA1.withOpacity(0.37)),
                gradient: LinearGradient(
                  colors: [
                    AppColors.whiteff,
                    AppColors.whiteff.withOpacity(0.37),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.28),
                    blurRadius: 30,
                  ),
                ],
              ),
              iconTheme: const IconThemeData(
                color: AppColors.whiteff,
                size: 20,
              ),
            ),
            extendedTheme: SidebarXTheme(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 6,
              decoration: const BoxDecoration(
                color: AppColors.primary,
              ),
              margin: const EdgeInsets.only(right: 0),
            ),
            footerDivider:
                Divider(color: AppColors.whiteff.withOpacity(0.3), height: 1),
            headerBuilder: (context, extended) {
              return SizedBox(
                  child: Column(children: [
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.grey[300],
                          child: ClipOval(
                            child: Image.file(
                              File(con.currentImage
                                  .value), // Display current image path
                              fit: BoxFit
                                  .cover, // Adjust the image fit as needed
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.error,
                                  size: 50,
                                  color: Colors.red,
                                );
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 35,
                          right: 0,
                          child: InkWellCustom(
                            onTap: () => con.pickImage(),
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[400],
                              radius: 11,
                              child: const Icon(
                                Icons.camera_alt,
                                size: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                //  CircleAvatar(
                //       radius: extended ? 50 : 20,
                //       backgroundImage: AssetImage(con.currentImage.value),
                //     )),
                const SizedBox(height: 20),
                extended
                    ? Obx(() => InkWellCustom(
                          onTap: () => con.showChangeName(context),
                          child: CustomText(
                            text: con.currentName.value,
                            size: 14.sp,
                            color: AppColors.whiteff,
                          ),
                        ))
                    : const SizedBox(),
                const SizedBox(height: 20),
                // (extended)
                //     ? ElevatedButton(
                //         onPressed: () => con.showChangeDialog(context),
                //         child: Text('Change Name and Image'),
                //       )
                //     : const SizedBox()
              ]));
            },
            items: [
              SidebarXItem(
                icon: Icons.home,
                label: S.of(context).sidebar_home,
                onTap: () {
                  con.changeTitle(S.of(context).sidebar_home);
                },
              ),
              SidebarXItem(
                icon: Icons.calendar_month_outlined,
                label: S.of(context).sidebar_appointment,
                onTap: () {
                  con.changeTitle(S.of(context).sidebar_appointment);
                },
              ),
              SidebarXItem(
                icon: Icons.people,
                label: S.of(context).sidebar_patients,
                onTap: () {
                  con.changeTitle(S.of(context).sidebar_patients);
                },
              ),
              SidebarXItem(
                icon: Icons.medical_services,
                label: S.of(context).sidebar_medications,
                onTap: () {
                  con.changeTitle(S.of(context).sidebar_medications);
                },
              ),
              SidebarXItem(
                icon: Icons.manage_accounts,
                label: S.of(context).sidebar_expenses,
                onTap: () {
                  con.changeTitle(S.of(context).sidebar_expenses);
                },
              ),
              SidebarXItem(
                icon: Icons.account_balance_sharp,
                label: S.of(context).sidebar_budget_management,
                onTap: () {
                  con.changeTitle(S.of(context).sidebar_budget_management);
                },
              ),
              SidebarXItem(
                icon: Icons.settings,
                label: S.of(context).setting,
                onTap: () {
                  con.changeTitle(S.of(context).setting);
                },
              ),
              SidebarXItem(
                onTap: () {
                  con2.logout();
                },
                icon: Icons.logout,
                label: S.of(context).sidebar_logout,
              ),
            ],
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: _ScreensExample(controller: _controller),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScreensExample extends StatelessWidget {
  _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> navigatorKey2 = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> navigatorKey3 = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> navigatorKey4 = GlobalKey<NavigatorState>();
  SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        switch (controller.selectedIndex) {
          case 0:
            return HomeScreen();
          case 1:
            return Stack(children: [
              Navigator(
                key: navigatorKey,
                onGenerateRoute: (RouteSettings settings) {
                  WidgetBuilder builder;
                  switch (settings.name) {
                    case '/':
                      builder = (BuildContext context) => Appointment();
                      break;
                    case '/addNewPatient':
                      builder = (BuildContext context) => const AddNewPatient();
                      break;
                    default:
                      throw Exception('Invalid route: ${settings.name}');
                  }
                  return MaterialPageRoute(
                      builder: builder, settings: settings);
                },
              ),
            ]);
          case 2:
            return Stack(children: [
              Navigator(
                key: navigatorKey2,
                onGenerateRoute: (RouteSettings settings) {
                  WidgetBuilder builder;
                  switch (settings.name) {
                    case '/':
                      builder = (BuildContext context) => AllPatientScreen();
                      break;
                    case '/addNewPatient':
                      builder = (BuildContext context) => const AddNewPatient();
                      break;
                    default:
                      throw Exception('Invalid route: ${settings.name}');
                  }
                  return MaterialPageRoute(
                      builder: builder, settings: settings);
                },
              ),
            ]);
          case 3:
            return Stack(children: [
              Navigator(
                key: navigatorKey3,
                onGenerateRoute: (RouteSettings settings) {
                  WidgetBuilder builder;
                  switch (settings.name) {
                    case '/':
                      builder = (BuildContext context) => StroreScreen();
                      break;
                    case '/AddMaterialScreen':
                      builder = (BuildContext context) => AddMaterialScreen();
                      break;
                    default:
                      throw Exception('Invalid route: ${settings.name}');
                  }
                  return MaterialPageRoute(
                      builder: builder, settings: settings);
                },
              ),
            ]);
          case 4:
            return Stack(children: [
              Navigator(
                key: navigatorKey4,
                onGenerateRoute: (RouteSettings settings) {
                  WidgetBuilder builder;
                  switch (settings.name) {
                    case '/':
                      builder = (BuildContext context) => ExpencesScreen();
                      break;
                    case '/AddNewExpences':
                      builder = (BuildContext context) => AddNewExpences();
                      break;
                    default:
                      throw Exception('Invalid route: ${settings.name}');
                  }
                  return MaterialPageRoute(
                      builder: builder, settings: settings);
                },
              ),
            ]);
          case 5:
            return const ScreenBadget();
          case 6:
            return AppSetting();
          case 7:
            return const Text(
              '',
            );
          default:
            return const Text(
              'Not found page',
            );
        }
      },
    );
  }
}
