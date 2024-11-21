import 'dart:io';

import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/common/inkwell_.dart';
import 'package:dental_app/core/utlis/assets_paths.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/appointment/widget_mob/appointment_mob.dart';
import 'package:dental_app/features/auth/controller/auth_controller.dart';
import 'package:dental_app/features/badget_mangment/widget_mob/screen_badget_mob.dart';
import 'package:dental_app/features/expences/widget/add_new_expences.dart';
import 'package:dental_app/features/expences/widget_mob/add_expenses_mob.dart';
import 'package:dental_app/features/expences/widget_mob/expenses_screen_mob.dart';
import 'package:dental_app/features/home/controller/home_controller.dart';
import 'package:dental_app/features/home/controller/operation_controller.dart';
import 'package:dental_app/features/home/widget/home_screen.dart';
import 'package:dental_app/features/home/widget_mobile/home_screen.dart';
import 'package:dental_app/features/patient/mobile_widget/add_patient_mob.dart';
import 'package:dental_app/features/patient/mobile_widget/all_patient_mobile.dart';
import 'package:dental_app/features/setting/widget_mob/setting_mob.dart';
import 'package:dental_app/features/store/widget/add_material_screen.dart';
import 'package:dental_app/features/store/widget/strore_screen.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';

class HomeViewMobile extends StatelessWidget {
  HomeViewMobile({Key? key}) : super(key: key);

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthCtrl con2 = Get.put(AuthCtrl());
  final OperationController operationController =
      Get.put(OperationController());
  HomeCtrl con = Get.put(HomeCtrl());
  @override
  Widget build(BuildContext context) {
    // Mobile layout
    return SafeArea(
        child: Stack(children: [
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
              AssetPath.mobMaster), // Your background image asset path
          fit: BoxFit.fill,
        )),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        appBar: AppBar(
          title: Obx(() => Text(con.titleAppBar.value)),
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(Icons.menu_rounded),
          ),
        ),
        drawer: Drawer(
          child: SidebarX(
            showToggleButton: false,
            controller: _controller,
            theme: SidebarXTheme(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
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
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
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
            // extendedTheme: SidebarXTheme(
            //   decoration: const BoxDecoration(
            //     color: AppColors.primary,
            //   ),
            //   margin: const EdgeInsets.only(right: 5),
            // ),
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
        ),
        body: Expanded(
          child: Center(
            child: _ScreensExample(controller: _controller),
          ),
        ),
      ),
    ]));
  }
}

class _ScreensExample extends StatelessWidget {
  _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> navigatorKey2 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> navigatorKey3 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> navigatorKey4 = GlobalKey<NavigatorState>();
  final SidebarXController controller;

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
                      builder = (BuildContext context) => AppointmentMob();
                      break;
                    case '/AddNewPatientMob':
                      builder =
                          (BuildContext context) => const AddNewPatientMob();
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
                      builder = (BuildContext context) => AllPatientMobile();
                      break;
                    case '/AddNewPatientMob':
                      builder =
                          (BuildContext context) => const AddNewPatientMob();
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
                      builder = (BuildContext context) => ExpencesScreenMob();
                      break;
                    case '/AddNewExpencesMob':
                      builder = (BuildContext context) => AddNewExpencesMob();
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
            return const ScreenBadgetMob();
          case 6:
            return AppSettingMob();
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
