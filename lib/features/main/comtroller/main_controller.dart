import 'package:dental_app/features/auth/widget/login.dart';
import 'package:flutter/material.dart';
import 'package:dental_app/features/auth/widget/resgister.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MainCtrl extends GetxController {
  var controllerEmail = TextEditingController();
  var controllerPassword = TextEditingController();
  bool isLoadingData = false;
  bool lodaingSessionData = false;
  int mainScreenIndex = 0;
  int bottumNavIndex = 0;
  List<Widget> mainScreenList = const [
    Login(),
    Signup(),
  ];
  changeIndex(int indx) {
    mainScreenIndex = indx;
    update();
  }

  changeBottomNavIndex(int indx) {
    mainScreenIndex = indx;
    update();
  }

  showBottomSheet(BuildContext context, Widget bottomSheet) {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      elevation: 0,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14.r),
          topRight: Radius.circular(14.r),
        ),
      ),
      builder: (BuildContext context) {
        return bottomSheet;
      },
    );
  }
}
