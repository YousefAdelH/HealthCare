import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:flutter/material.dart';

class MyPortfolioText extends StatelessWidget {
  const MyPortfolioText({super.key, required this.start, required this.end});
  final double start;
  final double end;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedTextKit(
        animatedTexts: [
          TyperAnimatedText(
            'Yousef Adel Habil',
            textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
            speed: const Duration(milliseconds: 100),
          ),
        ],
        totalRepeatCount: 1,
      ),
    );
  }
}
