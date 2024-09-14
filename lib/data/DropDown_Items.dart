import 'package:flutter/material.dart';

import 'Device_Types_Enums.dart';
import 'devices.dart';

List<DropdownMenuItem<DeviceTypesEnums>> dropdownitems= [
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