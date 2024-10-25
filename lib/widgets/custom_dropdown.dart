import 'package:flutter/material.dart';

import '../data/devices.dart';
import '../data/dropdown_items.dart';

class CustomDropdown extends StatelessWidget {
  final Icon ? icon;
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
        decoration: InputDecoration(border:  OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.green, width: 3),
        borderRadius: BorderRadius.circular(8),
      ),
          labelText: 'Select Device Type',
          labelStyle: const TextStyle(color: Colors.green),
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
        onChanged: onChanged,

        validator: (value) {
          return value == null ? "Please select a device type" : null;
        },
      ),
    );
  }
}
