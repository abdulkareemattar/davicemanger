import 'package:hive/hive.dart';
part '../hive_adapters/device_type_enums.g.dart';

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
