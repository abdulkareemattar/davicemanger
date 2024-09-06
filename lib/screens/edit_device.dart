import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/data/devices.dart';
import 'package:untitled8/services/hive_service.dart';
import 'package:uuid/uuid.dart';

import '../data/DropDown_Items.dart';

class EditDevice extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  String type = '';
  var uuid = Uuid();
  int index;

  EditDevice({required this.index});

  @override
  Widget build(BuildContext context) {
    final MyHiveService = Provider.of<HiveService>(context);

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
              controller: name,
              decoration: InputDecoration(
                labelStyle: const TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                ),
                labelText: 'Device Name',
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
              controller: price,
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
              value: type,
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
              items: dropdownitems,
              onChanged: (value) {
                type = value!;
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
              onPressed: () => MyHiveService.updateDevice(
                  index: index,
                  device: MyDevice(
                      type: type,
                      reserved: false,
                      name: name.text,
                      ID: MyHiveService.devices[index].ID)),
              child: Text(
                'Update Device',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
