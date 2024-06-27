import 'package:flutter/material.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  final String text;
  // final String? fontFamily;
  final Color color;
  final Color? underLineColor;
  final double? size;
  final double? height;
  final TextAlign textAlign;
  final bool bolUnderline;
  final bool? softWrap;
  final bool? underline;
  final bool? isBold;
  final int? maxLines;
  final String? fontfamily;
  final TextOverflow? overflow;
  // final TextStyle? style;
  final FontWeight? fontWeight;

  const CustomText({
    super.key,
    required this.text,
    this.color = AppColors.primary,
    this.size,
    this.fontfamily,
    this.height,
    this.textAlign = TextAlign.center,
    this.bolUnderline = false,
    // this.fontFamily,
    this.softWrap,
    this.underline,
    this.maxLines,
    this.overflow,
    // this.style,
    this.isBold,
    this.fontWeight,
    this.underLineColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        softWrap: softWrap,
        overflow: overflow,
        style: TextStyle(
          height: height,
          color: color,
          fontSize: size ?? 16.sp,
          fontWeight:
              isBold == true ? FontWeight.w700 : fontWeight ?? FontWeight.w400,
          fontFamily: fontfamily ?? AppFontNames.outfit,
          decoration: underline == true ? TextDecoration.underline : null,
          decorationThickness: bolUnderline ? 1.5 : 0.6,
          decorationColor: underLineColor,
        ),
      ),
    );
  }
}
