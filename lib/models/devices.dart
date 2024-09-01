import 'package:flutter/material.dart';

class MyDevice {
  MyDevice(
      {required this.LeadIcon,
      required this.title,
      required this.subtitle,
      required this.trailIcon});

  Icon LeadIcon;
  String title;
  String subtitle;
  Icon trailIcon;

}
