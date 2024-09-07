import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/data/devices.dart';
import 'package:untitled8/services/hive_service.dart';
import 'package:uuid/uuid.dart';

class AddDevice extends StatelessWidget {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _price = TextEditingController();
  String type = 'PC';
  final uuid = Uuid();
  final _formKey = GlobalKey<FormState>();

  String get name => _name.text;

  @override
  Widget build(BuildContext context) {
    final MyHiveService = Provider.of<HiveService>(context);

    return SizedBox(
      height: 900.h,
      child: Form(
        key: _formKey,
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
                controller: _name,
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a device name';
                  } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                    return 'Please enter only letters';
                  }
                  return null;
                },
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
                  labelText: 'Price per hour',
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green, width: 3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green, width: 3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Please enter only numbers';
                  }
                  return null;
                },
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
                    value: 'Xbox',
                    child: Text('Xbox'),
                  ),
                  DropdownMenuItem(
                    value: 'Laptop',
                    child: Text('Laptop'),
                  ),
                ],
                onChanged: (value) {
                  type = value!;
                },
                hint: Text(
                  'Select a device type',
                  style: TextStyle(color: Colors.green),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a device type';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    side: BorderSide(color: Colors.grey, width: 1)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    MyHiveService.addDevice(
                      device: MyDevice(
                          type: type,
                          reserved: false,
                          name: _name.text,
                          ID: uuid.v4(),
                          price: _price.text),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Device added successfully'),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Add Device',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
