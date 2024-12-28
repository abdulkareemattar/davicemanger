import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled8/screens/reservationScreen/start_reservation_dialog.dart';
import 'package:untitled8/services/hive_service.dart';
import 'package:untitled8/services/reservation_service.dart';

import '../../models/hive_models/reservation_model.dart';
import '../../widgets/custom_reservation_card.dart';

class DeviceReservationsDialog extends StatelessWidget {
  final int deviceIndex;
  final HiveService hiveService;
  final ReservationService reservationService;

  const DeviceReservationsDialog({
    super.key,
    required this.deviceIndex,
    required this.hiveService,
    required this.reservationService,
  });

  @override
  Widget build(BuildContext context) {
    final currentReservations = reservationService.getCurrentReservations(deviceIndex);

    // تجميع الحجوزات حسب التاريخ
    Map<String, List<Map<String, dynamic>>> groupedReservations = {};

    for (int i = 0; i < currentReservations.length; i++) {
      Reservation reservation = currentReservations[i];
      String dateKey = DateFormat('yyyy-MM-dd').format(reservation.startTime);

      // إضافة الرقم الأصلي للحجز مع الحجز نفسه
      groupedReservations.putIfAbsent(dateKey, () => []).add({
        'reservation': reservation,
        'originalIndex': i,
      });
    }

    return AlertDialog(
      title: Text(
        'Reservations for Device ${hiveService.devices[deviceIndex].name}',
        style:
            const TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
      ),
      content: groupedReservations.isEmpty
          ? const SizedBox(child: Text('No Reservations Found.'))
          : SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: groupedReservations.length,
                itemBuilder: (context, index) {
                  String dateKey = groupedReservations.keys.elementAt(index);
                  List<Map<String, dynamic>> dailyReservations =
                      groupedReservations[dateKey]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Chip(
                        label: Text(dateKey),
                      ),
                      ...dailyReservations.map((item) {
                        Reservation reservation = item['reservation'];
                        int originalIndex = item['originalIndex'];

                        return CustomReservationCard(reservationService: reservationService,
                          title: reservation.customerName,
                          dailyReservations: [reservation],
                          deviceIndex: deviceIndex,
                          reservationIndex: originalIndex,
                        );
                      }),
                    ],
                  );
                },
              ),
            ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close', style: TextStyle(color: Colors.purple)),
        ),
        TextButton(
          onPressed: () => showAddReservationDialog(
            notDoublePop: true,
            context: context,
            deviceIndex: deviceIndex,
          ),
          child: const Text('Add', style: TextStyle(color: Colors.purple)),
        ),
      ],
    );
  }
}

void showDeviceReservationsDialog({
  required BuildContext context,
  required int deviceIndex,
  required bool notDoublePop,
  required HiveService hive,
  required ReservationService reservationService,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return DeviceReservationsDialog(
        hiveService: hive,
        deviceIndex: deviceIndex,
        reservationService: reservationService,
      );
    },
  );
}
