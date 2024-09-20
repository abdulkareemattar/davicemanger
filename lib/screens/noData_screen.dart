import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled8/screens/add_devices.dart';

class NoDataScreen extends StatelessWidget {
  const NoDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset('lib/assets/lottie/devices.json',
              width: 200.w, height: 200.h),
          SizedBox(height: 20.h),
          Text(
            'No Data Available',
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: Colors.amber[800],
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'Start by adding new devices!',
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.green[600],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30.h),
          ElevatedButton(
            onPressed: () {
              _openBottomSheet(context,AddDevice());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber[700],
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              textStyle: TextStyle(fontSize: 16.sp),
            ),
            child: const Text(
              'Add New Device',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
  void _openBottomSheet(BuildContext context, Widget wid) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: wid,
          ),
        );
      },
    );
  }
}