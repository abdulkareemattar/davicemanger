import 'package:hive/hive.dart';

part 'reservation_model.g.dart';

@HiveType(typeId: 3)
class Reservation extends HiveObject {
  @HiveField(0)
  late DateTime startTime;
  @HiveField(1)
  late DateTime endTime;
  @HiveField(2)
  late String customerName;
  @HiveField(3)
  late String reservationID;
  @HiveField(4)
  late int remainingTime;

  Reservation(
      {required this.startTime,
      required this.endTime,
      required this.customerName,
      required this.reservationID,
      required this.remainingTime});
}
