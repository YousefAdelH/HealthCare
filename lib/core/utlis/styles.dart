import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColors {
  static const black = Color(0xFF000000);
  static const primary = Color(0XFF5aa0de);
  static const secondary = Color(0xFFB6EC1D);
  static const mainGrey = Color(0xFF191A1B);
  static const grey = Color(0xFFBDBDBD);
  static const mediumGrey = Color(0xFF4C4E53);
  static const lightMediumGrey = Color(0xFF6F7175);
  static const bottomSheetGrey = Color(0xFF3A3C41);
  static const white94 = Color(0xFF94A3B8);
  static const whiteF0 = Color(0xFFF0F0F0);
  static const whiteF7 = Color(0xFFF7FBFF);
  static const whiteFE = Color(0xFFF7FBFF);
  static const error = Color(0xFF9A2929);
  static const reject = Color(0xFFD80027);
  static const redE9 = Color(0xFFFBE6E9);
  static const bluewhite = Color(0xFFe8f5fe);

  static const success2 = Color(0xFF00CD43);
  static const grey99 = Color(0xFF999CA3);
  static const grey20 = Color(0xFF201F1F);
  static const grey04 = Color(0xFF040507);
  static const grey12 = Color(0xFF121212);
  static const greyF2 = Color(0xFFF2F2F2);
  static const greyD9D9 = Color(0xFFD9D9D9);
  static const grey6 = Color(0xFFF2F2F2);
  static const grey2 = Color(0xff4f4f4f);
  static const greyA3 = Color(0xFFA3A3A3);
  static const black00 = Color(0xFF000000);
  static const blackopacity4 = Color(0x0A000000);

  static const grayotp = Color(0xFFF0F7FF);
  static const whiteff = Color(0xFFFFFFFF);
  static const blueblack = Color(0xFF030D45);
  static const grayAA8 = Color(0xFF8F9AA8);
  static const blueA1 = Color(0xFF6880A1);
  static const grayfe = Color(0xFFE9F4FE);
  static const color1 = Color(0xFF668eff);
  static const color2 = Color(0xFF95d72d);
  static const color3 = Color(0xFFf673b9);
  static const color4 = Color(0xFF9e66fd);
  static const color5 = Color(0xFFccc725);
  static const blue2 = Color(0xFF5AB2FF);
  static const blue3 = Color(0xFFA0DEFF);
  static const blue4 = Color(0xFFCAF4FF);
  static const matchblue = Color(0xFFFFF9D0);
  static const Color primary2 = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}

class AppFontNames {
  static const outfit = "Outfit";
  static const ralway = "Ralway";
}

final customThemeData = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: Colors.white,
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white),
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: AppColors.black.withOpacity(0.2),
    cursorColor: AppColors.black,
    selectionHandleColor: AppColors.black,
  ),
  appBarTheme: const AppBarTheme(
    // iconTheme: IconThemeData(color: Colors.white),
    // titleTextStyle: TextStyle(
    //     color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
    backgroundColor: Colors.white,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: AppColors.mainGrey,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
    //actionsIconTheme: IconThemeData(color: Colors.black),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.black,
    selectedItemColor: Colors.white,
    unselectedItemColor: AppColors.lightMediumGrey,
  ),
);

class AppStyles {
  static final bottomNavTxxtStyle = TextStyle(
    fontFamily: AppFontNames.outfit,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
}
