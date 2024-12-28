import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showCustomSnackBar({required BuildContext context, required String txt}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.purpleAccent,
      content: Text(
        txt,
        style:  TextStyle(color: Colors.black ,fontSize: 12.sp,),
      ),
    ),
  );
}
