import 'package:dental_app/common/firebase_options.dart';
import 'package:dental_app/features/home/widget/home_view.dart';
import 'package:dental_app/features/main/widget/main_view.dart';
import 'package:dental_app/features/setting/controller/setting_controller.dart';
import 'package:dental_app/features/setting/widget/operation_setting.dart';
import 'package:dental_app/features/setting/widget/setting_screen.dart';
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

Future<void> main() async {
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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Size designSize = _getDesignSize(context);
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

              //  OperationSetting(),
              home: isDeviceRegistered == false ? MainView() : HomeView(),
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

  Size _getDesignSize(BuildContext context) {
    if (kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // Use larger design size for web or desktop
      return const Size(1024, 768);
    } else {
      // Use mobile design size
      return const Size(390, 843);
    }
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
