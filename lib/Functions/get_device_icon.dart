import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data/devices.dart';

Icon getDeviceIcon({required DeviceTypesEnums type}) {
  switch (type) {
    case DeviceTypesEnums.Laptop:
      return  const Icon(FontAwesomeIcons.laptop, color: Color(0xFF6A5ACD),);
    case DeviceTypesEnums.NintendoSwitch:
      return const Icon(FontAwesomeIcons.gamepad, color: Color(0xFFFF4500));
    case DeviceTypesEnums.Xbox:
      return const Icon(FontAwesomeIcons.xbox, color: Color(0xFF32CD32));
    case DeviceTypesEnums.Playstation:
      return const Icon(FontAwesomeIcons.playstation, color: Color(0xFF1E90FF));
    case DeviceTypesEnums.PC:
      return const Icon(FontAwesomeIcons.desktop, color: Color(0xFF20B2AA));
    default:
      return const Icon(FontAwesomeIcons.circleQuestion, color: Color(0xFF808080));
  }
}
