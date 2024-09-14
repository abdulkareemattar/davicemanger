import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'devices.dart';


Icon ? getDeviceIcon({required DeviceTypesEnums type}) {
  switch (type) {
    case DeviceTypesEnums.Laptop:
      return Icon(FontAwesomeIcons.laptop);
    case DeviceTypesEnums.NintendoSwitch:
      return Icon(FontAwesomeIcons.gamepad);
    case DeviceTypesEnums.Xbox:
      return Icon(FontAwesomeIcons.xbox);
    case DeviceTypesEnums.Playstation:
      return Icon(FontAwesomeIcons.playstation);
    case DeviceTypesEnums.PC:
      return Icon(FontAwesomeIcons.desktop);
    default: return Icon(FontAwesomeIcons.desktop);
  }
}