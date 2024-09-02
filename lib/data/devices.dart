import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class MyDevice extends HiveObject {

  @HiveField(0)
  late Icon LeadIcon;
  @HiveField(1)
  late String title;
  @HiveField(2)
  late String subtitle;
  @HiveField(3)
  late Icon trailIcon;
}
