import 'package:flutter/material.dart';

class InkWellCustom extends StatelessWidget {
  final Function()? onTap;
  final Widget child;
  final BorderRadius? borderRadius;
  const InkWellCustom({
    super.key,
    this.onTap,
    required this.child,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: borderRadius,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: child,
    );
  }
}
