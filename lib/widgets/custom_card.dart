import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/services/hive_service.dart';

class CustomCard extends StatelessWidget {
  CustomCard({
    Key? key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.color, required this.index,
  }) : super(key: key);

  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Color color;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: ListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: GestureDetector(
          onTap: () {
            final hiveservice = Provider.of<HiveService>(context,listen: false);
            hiveservice.changereserved(index: index);
          },
          child: Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      ),
    );
  }
}
