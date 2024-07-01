import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/all_patient/widget/appointment_show.dart';
import 'package:dental_app/features/patient/widget/add_new_patient.dart';
import 'package:dental_app/features/appointment/widget/appointment_screen.dart';
import 'package:dental_app/features/home/widget/home_screen.dart';
import 'package:dental_app/features/patient/widget/all_patient_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sidebarx/sidebarx.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final _controller = SidebarXController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SidebarX(
            controller: _controller,
            theme: SidebarXTheme(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              selectedIconTheme: const IconThemeData(color: AppColors.primary),
              textStyle: const TextStyle(color: Colors.white),
              selectedTextStyle: const TextStyle(color: AppColors.primary),
              itemTextPadding: const EdgeInsets.only(left: 30),
              selectedItemTextPadding: const EdgeInsets.only(left: 30),
              itemDecoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primary,
                ),
              ),
              selectedItemDecoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                border: Border.all(
                  color: AppColors.blueA1.withOpacity(0.37),
                ),
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
                  )
                ],
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
                size: 20,
              ),
            ),
            extendedTheme: SidebarXTheme(
              width: MediaQuery.of(context).size.width / 4,
              decoration: BoxDecoration(
                color: AppColors.primary,
              ),
              margin: EdgeInsets.only(right: 10),
            ),
            footerDivider:
                Divider(color: AppColors.whiteff.withOpacity(0.3), height: 1),
            headerBuilder: (context, extended) {
              return SizedBox(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircleAvatar(
                        radius:
                            extended ? 50 : 20, // Adjust the radius as needed
                        backgroundImage: const AssetImage('assets/img/3.png'),
                      ),
                    ),
                    extended
                        ? CustomText(
                            text: "Yousef Adel Habile",
                            size: 14.sp,
                            color: AppColors.whiteff,
                          )
                        : SizedBox()
                  ],
                ),
              );
            },
            items: [
              SidebarXItem(
                icon: Icons.home,
                label: 'Home',
                onTap: () {
                  debugPrint('Hello');
                },
              ),
              const SidebarXItem(
                icon: Icons.calendar_month_outlined,
                label: 'appointment',
              ),
              const SidebarXItem(
                icon: Icons.people,
                label: 'patients',
              ),
              const SidebarXItem(
                icon: Icons.medical_services,
                label: 'equipment',
              ),
              const SidebarXItem(
                icon: Icons.settings,
                label: 'Settings',
              ),
              const SidebarXItem(
                icon: Icons.logout,
                label: 'logout',
              ),
            ],
          ),
          Expanded(
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
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> navigatorKey2 = GlobalKey<NavigatorState>();
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
                      builder = (BuildContext context) => Appointment();
                      break;
                    case '/addNewPatient':
                      builder = (BuildContext context) => AddNewPatient();
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
            return Text(
              'equipment',
            );
          case 4:
            return Text(
              'Settings',
            );
          case 5:
            return Text(
              'logout',
            );
          default:
            return Text(
              'Not found page',
            );
        }
      },
    );
  }
}
