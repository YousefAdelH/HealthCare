import 'package:flutter/material.dart';
import 'package:dental_app/common/inkwell_.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'custom_text.dart';

class CustomLargeButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool? stopBtnActivity;
  final bool? noIcon;
  final Color? primeColor;
  final Color? backColor;
  final Color? iconColor;
  final bool animatedBtn;
  final Duration? duration;
  final double? radius;
  final double? height;
  final double? widthicone;
  final double? highticone;
  final String? iconePath;

  const CustomLargeButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.stopBtnActivity,
    this.noIcon,
    this.height,
    this.primeColor,
    this.backColor,
    this.iconColor,
    this.animatedBtn = false,
    this.duration,
    this.radius,
    this.iconePath,
    this.widthicone,
    this.highticone,
  });

  @override
  State<CustomLargeButton> createState() => _CustomLargeButtonState();
}

class _CustomLargeButtonState extends State<CustomLargeButton> {
  bool isLoading = false;
  final costDuration = const Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return InkWellCustom(
      borderRadius: BorderRadius.circular(widget.radius ?? 18.r),
      onTap: widget.onPressed,
      // onTap: () {
      //   // if (widget.stopBtnActivity != true) {
      //   //   setState(() => isLoading = true);

      //   //   setState(() {
      //   //     isLoading = false;
      //   //   });
      //   // }
      // },
      child: Container(
        height: widget.height ?? 44.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          border: Border.all(
              color: widget.stopBtnActivity == true
                  ? AppColors.mediumGrey
                  : widget.backColor ?? AppColors.primary,
              width: 1.sp),
          color: widget.stopBtnActivity == true
              ? AppColors.mediumGrey
              : widget.backColor ?? AppColors.primary,
        ),
        child: Center(
          child: (widget.animatedBtn && isLoading)
              ? SizedBox(
                  width: (widget.height ?? 55.h) * 0.6,
                  height: (widget.height ?? 55.h) * 0.6,
                  child: const CircularProgressIndicator(
                    color: AppColors.black00,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.noIcon != true && widget.iconePath != null)
                      SvgPicture.asset(
                        widget.iconePath!,
                        width: widget.widthicone ?? 12.w,
                        fit: BoxFit.fitWidth,
                      ),
                    if (widget.noIcon != true && widget.iconePath != null)
                      SizedBox(width: 5.w),
                    CustomText(
                      textAlign: TextAlign.center,
                      text: widget.text,
                      color: widget.stopBtnActivity == true
                          ? AppColors.grey99
                          : widget.primeColor ?? AppColors.whiteF0,
                      size: 16.sp,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
