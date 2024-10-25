import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../screens/end_reservation.dart';
import '../screens/device_reservation.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.isReserved,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.index,
    required this.onTapOnTrailing,
    required this.id, required RoundedRectangleBorder shape,
  });

  final VoidCallback onTapOnTrailing;
  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Color color;
  final int index;
  final bool isReserved;
  final String id;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: double.infinity,
      child: Card(
        elevation: 10,
        shadowColor: Colors.grey.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: EdgeInsets.all(5.h),
        child: InkWell(
          onTap: () => (!isReserved)
              ? showDeviceReservationDialog(context: context, index: index, isFromHomePage: true)
              : showDialogEndReservation(context: context, index: index),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                leading,
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: title,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: subtitle,
                ),
                GestureDetector(
                  onTap: onTapOnTrailing,
                  child: Container(
                    width: 30.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(200.r),
                    ),
                    child: Icon(Icons.power_settings_new_sharp, size: 20.sp, color: Colors.white), // أيقونة في الزاوية
                  ),
                ),
                Text(" ID : $id", style: TextStyle(fontSize: 5.sp,overflow: TextOverflow.ellipsis)),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
