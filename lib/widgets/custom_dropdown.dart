import 'package:flutter/material.dart';
import 'package:untitled8/Functions/get_custom_textstyle.dart';

import '../models/hive_models/device_type_enums.dart';

class CustomDropdown extends StatelessWidget {
  final Icon? icon;
  final DeviceTypesEnums? value;
  final ValueChanged<DeviceTypesEnums?> onChanged;

  const CustomDropdown({
    super.key,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: DropdownButtonFormField<DeviceTypesEnums>(
        icon: icon,
        value: value,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          labelText: 'Select Device Type',
          labelStyle: getTextStyle(
              type: FontTypeEnum.headLineSmall, color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.purple, width: 3),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.purple, width: 3),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        items: dropDownItems,
        onChanged: onChanged,
        validator: (value) {
          return value == null ? "Please select a device type" : null;
        },
      ),
    );
  }
}

List<DropdownMenuItem<DeviceTypesEnums>> dropDownItems = [
  DropdownMenuItem(
    value: DeviceTypesEnums.PC,
    child: Text(DeviceTypesEnums.PC.name),
  ),
  DropdownMenuItem(
    value: DeviceTypesEnums.Playstation,
    child: Text(DeviceTypesEnums.Playstation.name),
  ),
  DropdownMenuItem(
    value: DeviceTypesEnums.Xbox,
    child: Text(DeviceTypesEnums.Xbox.name),
  ),
  DropdownMenuItem(
    value: DeviceTypesEnums.Laptop,
    child: Text(DeviceTypesEnums.Laptop.name),
  ),
  DropdownMenuItem(
    value: DeviceTypesEnums.NintendoSwitch,
    child: Text(DeviceTypesEnums.NintendoSwitch.name),
  ),
];
