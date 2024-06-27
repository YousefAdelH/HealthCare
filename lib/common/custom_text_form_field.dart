import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dental_app/core/utlis/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final Widget? prefixIconPath;
  final Widget? suffix;
  final double? radius;
  final TextInputType? textInputType;
  final TextEditingController controller;
  final validate;
  final Function()? onSuffixPressed;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final Function(PointerDownEvent)? onTapOutside;
  final bool isPassword;
  final Function(String)? onChange;
  final bool? autoValidate;
  final bool? readOnly;
  final FocusNode? focusNode;
  final bool? autofocus;
  final int? maxLines;
  final int? maxLength;
  final Color? fillColor;
  final TextAlign? textAlign;
  final String? textFont;
  final double? fontSize;
  final double? hicone;
  final double? wicone;
  final Color? colorhint;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormField(
      {super.key,
      required this.label,
      this.radius,
      this.textInputType,
      required this.controller,
      this.validate,
      this.isPassword = false,
      this.prefixIconPath,
      this.suffix,
      this.onSuffixPressed,
      this.onTap,
      this.onEditingComplete,
      this.onTapOutside,
      this.onChange,
      this.autoValidate,
      this.focusNode,
      this.autofocus,
      this.readOnly,
      this.maxLines,
      this.maxLength,
      this.fillColor,
      this.textAlign,
      this.textFont,
      this.fontSize,
      this.inputFormatters,
      this.hicone,
      this.wicone,
      this.colorhint});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // focusNode: widget.focusNode ?? focus,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus ?? false,
      maxLines: widget.maxLines ?? 1,
      readOnly: widget.readOnly ?? false,
      autovalidateMode: widget.autoValidate == true
          ? AutovalidateMode.onUserInteraction
          : null,
      onChanged: widget.onChange,
      obscureText: widget.isPassword,
      obscuringCharacter: "*",
      validator: widget.validate,
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      onTapOutside: widget.onTapOutside,
      maxLength: widget.maxLength,
      cursorColor: AppColors.black,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        alignLabelWithHint: true,
        filled: true,
        fillColor: widget.fillColor ?? AppColors.whiteF7,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(
            widget.radius ?? 18.0.r,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.primary,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: widget.prefixIconPath,
        //  != null
        //     ? Padding(
        //         padding: EdgeInsets.all(14.w),
        //         child: SvgPicture.asset(
        //           widget.prefixIconPath!,

        //           // color: focus.hasFocus ? AppColors.grey2 : AppColors.greyA3,
        //         ),
        //       )
        //     : null,
        suffixIcon: widget.suffix,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? 18.0.r),
          borderSide: const BorderSide(
            width: 2,
            color: AppColors.blueA1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? 18.0.r),
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.error,
          ),
        ),
        hintText: widget.label,
        // hintStyle: TextStyle(
        //   color: widget.colorhint ?? AppColors.greyA3,
        //   fontSize: widget.fontSize ?? 14.sp,
        //   fontFamily: AppFontNames.outfit,
        //   fontWeight: FontWeight.w400,
        // ),
        counter: const SizedBox(),
      ),
      controller: widget.controller,
      keyboardType: widget.textInputType ?? TextInputType.name,
      inputFormatters: widget.inputFormatters,
      textAlign: widget.textAlign ?? TextAlign.start,
      // style: TextStyle(
      //   color: AppColors.grey2,
      //   fontFamily: widget.textFont ?? AppFontNames.outfit,
      //   fontSize: widget.fontSize ?? 14.sp,
      // ),
    );
  }
}
