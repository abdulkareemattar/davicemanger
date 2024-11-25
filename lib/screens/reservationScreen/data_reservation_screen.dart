import 'package:flutter/material.dart';
import 'package:untitled8/screens/reservationScreen/reservation_devices_screen.dart';

import 'calender_screen.dart';

class DataReservationScreen extends StatelessWidget {
  const DataReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const DefaultTabController(
        length: 2,
        child: Scaffold(
        appBar: TabBar(
        tabs: [
          Tab(
            text: 'Reserved devices',
            icon: Icon(Icons.access_alarm),
          ),
          Tab(
            text: 'Calender',
            icon: Icon(Icons.calendar_month),
          ),
        ],
      ),
      body: TabBarView(children: [ReservationDevices(), CalenderScreen()]),
    ));
  }
}
