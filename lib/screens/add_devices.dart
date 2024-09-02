import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddDevices extends StatelessWidget {
  AddDevices({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 900.h,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h),
            child: Title(
                color: Colors.grey,
                child: Text(
                  'Add Devices',
                  style: TextStyle(color: Colors.green, fontSize: 20.sp),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              decoration: InputDecoration(
                labelStyle: const TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                ),
                labelText: 'Device Name', // اضغط على labelText بدلاً من label
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 3),
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 3),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              decoration: InputDecoration(
                labelStyle: const TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                ),
                labelText: 'price per hour',
// اضغط على labelText بدلاً من label
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 3),
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 3),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Device Type',
                labelStyle: TextStyle(color: Colors.green),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: [
                DropdownMenuItem(
                  value: 'PC',
                  child: Text('PC'),
                ),
                DropdownMenuItem(
                  value: 'PS',
                  child: Text('PS'),
                ),
                DropdownMenuItem(
                  value: 'XBOX',
                  child: Text('XBOX'),
                ),
              ],
              onChanged: (value) {
                print('Selected: $value'); // يمكنك إضافة المعالجة التي تحتاجها
              },
              hint: Text(
                'Select a device type',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  side: BorderSide(color: Colors.grey, width: 1)),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Save device',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
