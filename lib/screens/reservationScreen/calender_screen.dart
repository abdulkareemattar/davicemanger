import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_planner/time_planner.dart';
import 'package:untitled8/services/hive_service.dart';

import '../../Functions/get_day_name.dart';
import 'package:time_planner/src/config/global_config.dart' as config;

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final myHiveService = Provider.of<HiveService>(context);

    int numberOfDays = 365;

    List<TimePlannerTitle> headers = [];

    for (int i = 0 ; i < numberOfDays; i++) {
      DateTime date = DateTime.now().add(Duration(days: i));
      String title = getDayName(date.weekday);
      headers.add(
        TimePlannerTitle(
          date: "${date.day} / ${date.month} / ${date.year}",
          title: title,
        ),
      );
    }

    return TimePlanner(style: TimePlannerStyle(cellHeight: 50,),
      use24HourFormat: true,
      startHour: 0,
      endHour: 23,currentTimeAnimation: true,
      headers: headers,
      tasks: myHiveService.getReservedTasks(),
    );
  }
}
