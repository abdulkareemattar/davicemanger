import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class MyDevice extends HiveObject {
  @HiveField(0)
  late int ID;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late String type;
  @HiveField(3)
  late bool reserved ;
}
