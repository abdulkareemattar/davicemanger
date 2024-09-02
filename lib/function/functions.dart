import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../data/devices.dart';

//add method
Future<void> add({
  required MyDevice device,
  required int ID,
  required String name,
  required String type,
  required bool reserved,
  required var box,
}) async {
  device
    ..ID = ID
    ..name = name
    ..type = type
    ..reserved = reserved;
  await box.add(device);
}

//save method
Future<void> save(
    {required MyDevice device,
    required int ID,
    required String name,
    required String type,
    required bool reserved}) async {
  device
    ..ID = ID
    ..name = name
    ..type = type
    ..reserved = reserved;
  await device.save();
}

//delete method
Future<void> delete({
  required var box,
  required MyDevice device,
}) async {
  await box.delete(device);
}
