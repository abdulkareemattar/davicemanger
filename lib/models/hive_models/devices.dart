import 'package:hive/hive.dart';

import 'device_type_enums.dart';

part '../hive_adapters/devices.g.dart';

@HiveType(typeId: 2)
class MyDevice extends HiveObject {
  Duration get duration => startTime!.difference(endTime!).abs();

  @HiveField(0)
  late String id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late DeviceTypesEnums type;
  @HiveField(3)
  late bool reserved;
  @HiveField(4)
  late String price;
  @HiveField(5)
  late bool? isActive;
  @HiveField(6)
  late String? customerName;
  @HiveField(7)
  late DateTime? startTime;
  @HiveField(8)
  late DateTime? endTime;

  MyDevice(
      {this.isActive = false,
      this.id = '',
      this.type = DeviceTypesEnums.PC,
      this.name = '',
      this.reserved = false,
      this.price = '0',
      required this.customerName,
      required this.startTime,
      required this.endTime});
}
