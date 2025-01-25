import 'package:hive/hive.dart';
import 'package:untitled8/models/hive_models/reservation_model.dart';
import 'device_type_enums.dart';

part 'devices.g.dart';

@HiveType(typeId: 2)
class MyDevice extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late DeviceTypesEnums type;

  @HiveField(3)
  late String price;

  @HiveField(4)
  late String? customerName;

  @HiveField(5)
  late List<Reservation> reservations;

  MyDevice({
    required this.id,
    this.type = DeviceTypesEnums.PC,
    required this.name,
    required this.price,
    this.customerName,
    this.reservations = const [], //Empty List
  });
}