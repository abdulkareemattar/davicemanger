import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../data/devices.dart';
//add method
void add(
    {required Icon LeadIcon,
    required Icon trailIcon,
    required String subtitle,
    required String title,
    required var box,
    required MyDevice device}) async {
  device
    ..LeadIcon = LeadIcon
    ..title = title
    ..subtitle = subtitle
    ..trailIcon = trailIcon;
  await box.add(device);
}
//save method
void save(
    {required MyDevice device,
    required Icon LeadIcon,
    required Icon trailIcon,
    required String subtitle,
    required String title}) async {
  device
    ..trailIcon = trailIcon
    ..subtitle = subtitle
    ..title = title
    ..LeadIcon = LeadIcon;
  await device.save();
}
//delete method
void delete({
  required var box,
  required MyDevice device,
}) async {
  await box.delete(device);
}
