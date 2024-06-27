import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/core/utlis/app_string.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:dental_app/features/patient/widget/session_item.dart';
import 'package:dental_app/features/patient/widget/user_info.dart';
import 'package:dental_app/features/appointment/model/patiant_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatientScreen extends StatelessWidget {
  PatientScreen({Key? key, required this.item}) : super(key: key);
  final PatientModel item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.bluewhite,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: AppColors.whiteff,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4.0,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            radius: 50, // Adjust the radius as needed
                            backgroundImage: AssetImage('assets/img/3.png'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CustomText(
                            text: item.name ?? "",
                            size: 14.sp,
                            color: AppColors.black,
                            underLineColor: AppColors.whiteff,
                          ),
                        ),
                        UserInfo(
                          subtitle: AppStrings.gender,
                          title: item.gender ?? "",
                          icone: Icon(Icons.person),
                        ),
                        const UserInfo(
                          subtitle: AppStrings.age,
                          title:
                              "35", // Replace this with item.age if available
                          icone: Icon(Icons.cake),
                        ),
                        UserInfo(
                          subtitle: AppStrings.number,
                          title: item.number ?? "",
                          icone: Icon(Icons.phone),
                        ),
                        const Spacer(),
                        Expanded(
                          child: Column(
                            children: [
                              UserInfo(
                                subtitle: AppStrings.totalAmount,
                                title: item.totalPrice ?? "",
                                icone: const Icon(Icons.attach_money),
                              ),
                              UserInfo(
                                subtitle: AppStrings.amountPaid,
                                title: item.amountPaid ?? "",
                                icone: const Icon(Icons.money_off),
                              ),
                              UserInfo(
                                subtitle: AppStrings.remainingAmount,
                                title: item.remainingAmount ?? "",
                                icone: const Icon(Icons.account_balance_wallet),
                              ),
                            ],
                          ),
                        ),

                        //   UserInfo(title: ,subtitle: ,),
                        //     UserInfo(title: ,subtitle: ,),
                        //       UserInfo(title: ,subtitle: ,)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return PatientSessionItem();
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
