import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../main.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40.h,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      color: orange,
      onPressed: onPressed,
      child: Text(
        label,
        style: styles.f14Bold(color: Colors.white),
      ),
    );
  }
}