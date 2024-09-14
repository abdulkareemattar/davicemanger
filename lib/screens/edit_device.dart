import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/data/devices.dart';
import 'package:untitled8/services/hive_service.dart';
import 'package:uuid/uuid.dart';

import '../data/Device_Types_Enums.dart';
import '../data/DropDown_Items.dart';

class EditDevice extends StatelessWidget {

  DeviceTypesEnums type = DeviceTypesEnums.PC;
  final uuid = Uuid();
  int index;

  EditDevice({required this.index});

  @override
  Widget build(BuildContext context) {
    final MyHiveService = Provider.of<HiveService>(context);
    final TextEditingController _name = TextEditingController(text: MyHiveService.devices[index].name);
    final TextEditingController _price = TextEditingController(text: MyHiveService.devices[index].price);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          child: Title(
              color: Colors.grey,
              child: Text(
                'Edit " ${MyHiveService.devices[index].name} " device',
                style: TextStyle(color: Colors.green, fontSize: 20.sp),
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextFormField(
            controller: _name,
            decoration: InputDecoration(
              labelStyle: const TextStyle(
                color: Colors.green,
                fontSize: 20,
              ),
              labelText: 'device name',
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
            controller: _price,
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
          child: DropdownButtonFormField<DeviceTypesEnums>(
            value: MyHiveService.devices[index].type,
            icon: getDeviceIcon(type: MyHiveService.devices[index].type),
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
        Switch(
            value: MyHiveService.devices[index].reserved,
            onChanged:(value) { MyHiveService.changereserved(index: index);},
            ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  side: BorderSide(color: Colors.grey, width: 1)),
              onPressed: () {
                MyHiveService.updateDevice(
                    index: index,
                    device: MyDevice(
                        price: _price.text,
                        type: type,
                        reserved: MyHiveService.devices[index].reserved,
                        name: _name.text,
                        ID: MyHiveService.devices[index].ID));
                Navigator.pop(context);
              },
              child: Text(
                'Update Device',
                style: TextStyle(color: Colors.white),
              )),
        )
      ],
    );
  }
}
