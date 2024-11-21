import 'package:dental_app/common/responsive.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:flutter/material.dart';

class AnimatedDescriptionText extends StatelessWidget {
  const AnimatedDescriptionText(
      {super.key, required this.start, required this.end});
  final double start;
  final double end;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: start, end: end),
      duration: const Duration(milliseconds: 500),
      builder: (context, value, child) {
        return Text(
          'I\'m capable of creating excellent mobile apps, handling${Responsive.isLargeMobile(context) ? '\n' : ''}every step from ${!Responsive.isLargeMobile(context) ? '\n' : ''}concept to deployment.',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: AppColors.black, wordSpacing: 2, fontSize: value),
        );
      },
    );
  }
}
