import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/hive_models/device_type_enums.dart';

 getDeviceIcon({required DeviceTypesEnums type}) {
  switch (type) {
    case DeviceTypesEnums.Laptop:
      return Icon(
        Icons.laptop,
        color: const Color(0xFF6A5ACD),
        size: 20.sp,
      );
    case DeviceTypesEnums.NintendoSwitch:
      return Icon(Icons.gamepad,
          color: const Color(0xFFFF4500), size: 20.sp);
    case DeviceTypesEnums.Xbox:
      return Icon(FontAwesomeIcons.xbox,
          color: const Color(0xFF32CD32), size: 20.sp);
    case DeviceTypesEnums.Playstation:
      return Icon(FontAwesomeIcons.playstation,
          color: const Color(0xFF1E90FF), size: 20.sp);
    case DeviceTypesEnums.PC:
      return Icon(FontAwesomeIcons.desktop,
          color: const Color(0xFF20B2AA), size: 20.sp);
    default:
      return Icon(FontAwesomeIcons.circleQuestion,
          size: 20.sp, color: const Color(0xFF808080));
  }
}
