import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjm_pos/main.dart';

class CustomCircularButton extends StatelessWidget {
  const CustomCircularButton({
    Key? key,
    this.icon,
    this.child,
    this.onTap,
    this.size,
    this.backgroundColor,
    this.borderColor,
    this.iconColor,
  }) : super(key: key);

  final IconData? icon;
  final Widget? child;
  final GestureTapCallback? onTap;
  final double? size;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    if (child == null && icon == null) {
      throw ArgumentError("Either 'child' or 'icon' must be provided.");
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(6.sp),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor ?? orangeAccent,
          border: Border.all(color: borderColor ?? orange),
        ),
        child: child != null
            ? child!
            : Icon(
                icon,
                size: size ?? 20.r,
                color: iconColor ?? orange,
              ),
      ),
    );
  }
}
