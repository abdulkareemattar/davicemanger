import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle getTextStyle(
    {required FontTypeEnum type,
    required Color color,
    double? size,
    bool withShadow = true}) {
  switch (type) {
    case FontTypeEnum.headLineLarge:
      return TextStyle(
          shadows: (withShadow)
              ? const [
                  BoxShadow(
                      color: Colors.black, blurRadius: 1, offset: Offset(1, 1))
                ]
              : null,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: color);
    case FontTypeEnum.headLineMid:
      return TextStyle(
          shadows: (withShadow)
              ? const [
                  BoxShadow(
                      color: Colors.black, blurRadius: 1, offset: Offset(1, 1))
                ]
              : null,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: color);
    case FontTypeEnum.headLineSmall:
      return TextStyle(
          shadows: (withShadow)
              ? const [
                  BoxShadow(
                      color: Colors.black, blurRadius: 1, offset: Offset(1, 1))
                ]
              : null,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: color);
    default:
      return TextStyle(
          shadows: (withShadow)
              ? const [
                  BoxShadow(
                      color: Colors.black, blurRadius: 1, offset: Offset(1, 1))
                ]
              : null,
          fontSize: size,
          fontWeight: FontWeight.bold,
          color: color);
  }
}

enum FontTypeEnum { headLineLarge, headLineMid, headLineSmall , customHeadLine}
