import 'package:hive/hive.dart';

import 'Device_Types_Enums.dart';

part 'devices.g.dart';
@HiveType(typeId: 1)
enum DeviceTypesEnums {
  @HiveField(0)
  PC,
  @HiveField(1)
  NintendoSwitch,
  @HiveField(2)
  Xbox,
  @HiveField(3)
  Playstation,
  @HiveField(4)
  Laptop,
}

@HiveType(typeId: 0)
class MyDevice extends HiveObject {
  @HiveField(0)
  late String ID;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late DeviceTypesEnums type;
  @HiveField(3)
  late bool reserved;
  @HiveField(4)
  late String price;

  MyDevice({
    this.ID = '', this.type = DeviceTypesEnums
        .PC, this.name = '', this.reserved = false, this.price = '0',
  });
}

