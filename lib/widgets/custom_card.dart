import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled8/screens/home_screen.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.color,
  }) : super(key: key);

  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:  EdgeInsets.symmetric(vertical: 8.h),
      child: ListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: Container(
          width: 20.w,
          height: 20.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}
