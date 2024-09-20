import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data/devices.dart';

Icon? getDeviceIcon({required DeviceTypesEnums type}) {
  switch (type) {
    case DeviceTypesEnums.Laptop:
      return Icon(FontAwesomeIcons.laptop, color: Color(0xFF6A5ACD));
    case DeviceTypesEnums.NintendoSwitch:
      return Icon(FontAwesomeIcons.gamepad, color: Color(0xFFFF4500));
    case DeviceTypesEnums.Xbox:
      return Icon(FontAwesomeIcons.xbox, color: Color(0xFF32CD32));
    case DeviceTypesEnums.Playstation:
      return Icon(FontAwesomeIcons.playstation, color: Color(0xFF1E90FF));
    case DeviceTypesEnums.PC:
      return Icon(FontAwesomeIcons.desktop, color: Color(0xFF20B2AA));
    default:
      return Icon(FontAwesomeIcons.questionCircle, color: Color(0xFF808080));
  }
}