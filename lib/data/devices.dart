import 'package:hive/hive.dart';

part 'devices.g.dart';

@HiveType(typeId: 0)
class MyDevice extends HiveObject {
  @HiveField(0)
  late String ID;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late String type;
  @HiveField(3)
  late bool reserved;
  @HiveField(4)
  late String price;

  MyDevice({
    this.ID = '', this.type = '', this.name = '', this.reserved = false,this.price='0',
  });
}
