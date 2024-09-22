import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/Functions/get_device_icon.dart';
import 'package:untitled8/data/devices.dart';
import 'package:untitled8/services/hive_service.dart';
import 'package:untitled8/widgets/custom_switch.dart';
import 'package:untitled8/widgets/custom_textformfield.dart';
import 'package:uuid/uuid.dart';

import '../data/dropdown_items.dart';

class AddDevice extends StatelessWidget {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final uuid = Uuid();
  final _formKey = GlobalKey<FormState>();

  String get name => _name.text;

  @override
  Widget build(BuildContext context) {
    final myHiveService = Provider.of<HiveService>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              CustomTextFormField(
                txt: 'Enter device name :',
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a device name';
                  }
                  return null;
                },
                controller: _name,
                label: 'Device Name',
                keyboard: TextInputType.name,
              ),
              CustomTextFormField(
                txt: 'Enter the price of hour for reservation this device :',
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Please enter only numbers';
                  }
                  return null;
                },
                controller: _price,
                label: 'Price per hour',
                keyboard: TextInputType.number,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DropdownButtonFormField<DeviceTypesEnums>(
                  icon: (myHiveService.type != null)
                      ? getDeviceIcon(type: myHiveService.type!)
                      : Icon(FontAwesomeIcons.desktop, color: Colors.green),
                  value: null,
                  decoration: InputDecoration(
                    labelText: 'Select Device Type',
                    labelStyle: TextStyle(color: Colors.green),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: dropdownitems,
                  onChanged:(value) => myHiveService.dropDownSelectType(value!),
                  hint: const Text(
                    'Select a device type',
                    style: TextStyle(color: Colors.green),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a device type';
                    }
                    return null;
                  },
                ),
              ),
              CustomSwitch(
                value: myHiveService.isReserved,
                onChanged: (value) {
                  myHiveService.setSwitch(value);
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        side: const BorderSide(color: Colors.grey, width: 1)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        myHiveService.addDevice(
                          device: MyDevice(
                              type: myHiveService.type!,
                              reserved: myHiveService.isReserved,
                              name: _name.text,
                              ID: uuid.v4(),
                              price: _price.text),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.amberAccent,
                            content: Text(
                              'Device added successfully',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Add Device',
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
