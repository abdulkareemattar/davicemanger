import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:untitled8/services/reservation_service.dart';
import 'package:untitled8/widgets/customCounter.dart';

import '../screens/reservationScreen/edit_reservation_dialog.dart';
import 'custom_confirmation_dialog.dart';
import 'custom_slidable.dart';

class CustomReservationCard extends StatelessWidget {
  final String title;
  final int deviceIndex;
  final int reservationIndex;
  final List<dynamic> dailyReservations;
  final ReservationService reservationService;

  const CustomReservationCard({
    Key? key,
    required this.title,
    required this.dailyReservations,
    required this.deviceIndex,
    required this.reservationIndex,
    required this.reservationService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      elevation: 10,
      shadowColor: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ExpansionTile(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          children: dailyReservations.map<Widget>((reservation) {
            return CustomSlidable(
              keyY: Key(title),
              editFunction: () {
                showEditReservationDialog(
                  context: context,
                  deviceIndex: deviceIndex,
                  reservationIndex: reservationIndex,
                  notDoublePop: false,
                );
              },
              deleteFunction: () {
                showCancellationConfirmationDialog(
                    deviceIndex: deviceIndex,
                    reservationIndex: reservationIndex,
                    context: context,
                    myReservationService: reservationService);
              },
              child: ListTile(
                  title: SizedBox(
                    height: 160.h,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTimeInfo(
                              'from:', reservation.startTime, Colors.green),
                          _buildTimeInfo(
                              'to:', reservation.endTime, Colors.red),
                        ],
                      ),
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        'Reserved by: ',
                        style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Chip(
                        label: Text(reservation.customerName ??
                            'Unknown'), // Handle null
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.event_available, color: Colors.purple),
                  onTap: () => {
                        reservationService.startCountdown(
                            deviceIndex: deviceIndex,
                            reservationIndex: reservationIndex),
                        showCounterDialog(
                            context: context,
                            deviceIndex: deviceIndex,
                            reservationIndex: reservationIndex)
                      }),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTimeInfo(String label, DateTime time, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
        Chip(
          label: Text(DateFormat('dd-MM-yyyy : kk:mm').format(time)),
        ),
      ],
    );
  }
}
