import 'package:dental_app/core/utlis/constants.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/splash/view/description_pages.dart';
import 'package:dental_app/features/splash/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteff,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 95,
            ),
            const Text(
              'About',
              style: TextStyle(
                  fontFamily: kRoboto, fontSize: 24, color: Color(0xff525252)),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Health Care',
              style: TextStyle(
                  fontFamily: 'Lora', fontSize: 32, color: Color(0xff222222)),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Center(
                child: Text(
                  'Health Care Our comprehensive software is designed to streamline the management of dental clinics, available on desktop, mobile, and web platforms.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17,
                      color: Color(0xff434242),
                      fontFamily: kRoboto,
                      height: 1.7),
                ),
              ),
            ),
            const SizedBox(
              height: 62,
            ),
            Image.asset(
              'assets/img/aboutus_description.gif',
              width: 350,
            ),
            const SizedBox(
              height: 13,
            ),
            CustomButton(
              borderRadius: 8,
              color: AppColors.primary,
              width: 320,
              height: 40,
              onTap: () {
                Get.to(() => DescriptionPages());
              },
              text: 'Get started !',
              size: 18,
              textColor: AppColors.whiteff,
              borderColor: AppColors.primary,
            )
          ],
        ),
      ),
    );
  }
}
