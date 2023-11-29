import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../main.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.elevation,
    required this.onTap,
    this.radius,
    required this.icon,
  });

  final double? elevation;
  final GestureTapCallback onTap;
  final double? radius;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: elevation ?? 0.0,
        borderRadius: BorderRadius.circular(radius ?? 18.r),
        child: CircleAvatar(
          backgroundColor: orangeAccent,
          radius: radius ?? 18.r,
          child: Icon(
            icon,
            color: orange,
          ),
        ),
      ),
    );
  }
}
