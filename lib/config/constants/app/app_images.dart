import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AppImages {
  static const _assetsDir = 'assets/svg/';
  static Widget notStartedIcon({double? height, double? width, Color? color}) {
    return SvgPicture.asset(
      '${_assetsDir}not_started.svg',
      semanticsLabel: 'Not Started',
      width: width ?? 22.sp,
      height: height ?? 22.sp,
      colorFilter: ColorFilter.mode(color ?? Colors.black, BlendMode.srcIn),
    );
  }

  static Widget atWorkIcon({double? height, double? width, Color? color}) {
    return SvgPicture.asset(
      '${_assetsDir}at_work.svg',
      semanticsLabel: 'Not Started',
      width: width ?? 22.sp,
      height: height ?? 22.sp,
      colorFilter: ColorFilter.mode(color ?? Colors.black, BlendMode.srcIn),
    );
  }

  static Widget atTestingIcon({double? height, double? width, Color? color}) {
    return SvgPicture.asset(
      '${_assetsDir}at_testing.svg',
      semanticsLabel: 'Not Started',
      width: width ?? 22.sp,
      height: height ?? 22.sp,
      colorFilter: ColorFilter.mode(color ?? Colors.black, BlendMode.srcIn),
    );
  }

  static Widget deliveredIcon({double? height, double? width, Color? color}) {
    return SvgPicture.asset(
      '${_assetsDir}delivered.svg',
      semanticsLabel: 'Not Started',
      width: width ?? 22.sp,
      height: height ?? 22.sp,
      colorFilter: ColorFilter.mode(color ?? Colors.black, BlendMode.srcIn),
    );
  }

  static Widget receivedIcon({double? height, double? width, Color? color}) {
    return SvgPicture.asset(
      '${_assetsDir}received.svg',
      semanticsLabel: 'Not Started',
      width: width ?? 22.sp,
      height: height ?? 22.sp,
      colorFilter: ColorFilter.mode(color ?? Colors.black, BlendMode.srcIn),
    );
  }
}
