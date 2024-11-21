import 'package:dental_app/common/custom_text.dart';
import 'package:dental_app/common/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedContainerWidget extends StatefulWidget {
  final double bottomPosition;
  final double rightPosition;
  final Color color;
  final String text;
  final String text2;

  const AnimatedContainerWidget({
    Key? key,
    required this.bottomPosition,
    required this.rightPosition,
    required this.color,
    required this.text,
    required this.text2,
  }) : super(key: key);

  @override
  _AnimatedContainerWidgetState createState() =>
      _AnimatedContainerWidgetState();
}

class _AnimatedContainerWidgetState extends State<AnimatedContainerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Define the slide animation
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 2), // Starts just below the screen
      end: Offset.zero, // Ends at its original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: widget.bottomPosition,
      right: widget.rightPosition,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(30),
          ),
          width: (Responsive.isDesktop(context))
              ? 150.w
              : MediaQuery.of(context).size.width / 3,
          height: 100.h,
          child: Column(
            children: [
              Center(
                child: CustomText(
                  text: widget.text,
                ),
              ),
              Center(
                child: CustomText(
                  text: widget.text2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
