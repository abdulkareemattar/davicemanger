import 'package:hive/hive.dart';
part '../hive_adapters/reservation_model.g.dart';
@HiveType(typeId: 3)
class Reservation extends HiveObject {
  @HiveField(0)
  late DateTime startTime;
  @HiveField(1)
  late DateTime endTime;
  @HiveField(2)
  late String? customerName; //Made nullable

  Reservation({
    required this.startTime,
    required this.endTime,
    this.customerName,
  });
}
