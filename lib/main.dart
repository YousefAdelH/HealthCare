import 'package:dental_app/core/utlis/service_lecator.dart';
import 'package:dental_app/features/home/widget/home_view.dart';
import 'package:dental_app/features/home/widget_mobile/home_view_mobile.dart';
import 'package:dental_app/features/main/mobile_widget/main_mobile.dart';
import 'package:dental_app/features/main/widget/main_view.dart';
import 'package:dental_app/features/setting/controller/setting_controller.dart';
import 'package:dental_app/features/setting/widget/operation_setting.dart';
import 'package:dental_app/features/splash/view/splash_page.dart';
import 'package:dental_app/firebase_options.dart';
import 'package:dental_app/generated/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_io/io.dart' show Platform;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:ui' as ui;

Future<void> main() async {
  setupDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isDeviceRegistered = prefs.getBool('isDeviceRegistered') ?? false;

  runApp(MyApp(isDeviceRegistered: isDeviceRegistered));
}

class MyApp extends StatelessWidget {
  final bool isDeviceRegistered;
  MyApp({super.key, required this.isDeviceRegistered});
  final LocalizationController localizationController =
      Get.put(LocalizationController());

  @override
  Widget build(BuildContext context) {
    final Size designSize = _getDesignSize();
    return ScreenUtilInit(
        designSize: designSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Obx(() {
            return GetMaterialApp(
              locale: localizationController.locale.value,
              scrollBehavior: MyCustomScrollBehavior(),
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: _getHomeScreen(designSize, isDeviceRegistered),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
            );
          });
        });
  }

  Widget _getHomeScreen(Size designSize, bool isDeviceRegistered) {
    if (designSize.width > 843) {
      return isDeviceRegistered ? HomeView() : MainView();
    } else {
      return isDeviceRegistered ? HomeViewMobile() : SplashPage();
    }
  }

  Size _getDesignSize() {
    if (kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      var window = ui.window;
      final screenSize = window.physicalSize / window.devicePixelRatio;
      return Size(screenSize.width, screenSize.height);
    } else {
      // Use mobile design size
      return const Size(390, 843);
    }
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
