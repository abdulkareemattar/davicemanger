import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled8/models/hive_models/devices.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.leading,
    required this.device,
    required this.onTap,
    required this.title,
    required this.subtitle,
    required this.colorOfReservedCircle,
    required this.index,
    required this.onTapOnTrailing,
    required this.id,
    required RoundedRectangleBorder shape,
    required this.isReserved,
    required this.colorOfCard,
  });

  final MyDevice device;
  final VoidCallback onTapOnTrailing;
  final VoidCallback onTap;
  final Widget leading;
  final Text title;
  final Widget subtitle;
  final Color colorOfReservedCircle;
  final Color colorOfCard;
  final int index;
  final bool isReserved;
  final String id;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: colorOfCard,
        elevation: 10,
        shadowColor: Colors.grey.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: EdgeInsets.all(5.h),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 0,
                  child: CircleAvatar(
                    backgroundColor: const Color(0xff141218),
                    maxRadius: 25,
                    child: Center(
                      child: leading,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Chip(
                      label: SizedBox(
                          height: 50, width: double.infinity, child: Center(child: title)),
                      backgroundColor: const Color(0xff141218),
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Chip(
                        label:
                            SizedBox(width: double.infinity, child: subtitle)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: GestureDetector(
                    onTap: onTapOnTrailing,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.sp),
                          border: Border.all(color: Colors.black)),
                      child: CircleAvatar(
                        backgroundColor: colorOfReservedCircle,
                        child: Icon(Icons.power_settings_new_sharp,
                            size: 16.sp,
                            color: Colors.black), // أيقونة في الزاوية
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
