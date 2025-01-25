import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:untitled8/Functions/get_custom_textstyle.dart';
import 'package:untitled8/screens/reservationScreen/start_reservation_dialog.dart';
import 'package:untitled8/services/hive_service.dart';
import 'package:untitled8/services/reservation_service.dart';

import '../../models/hive_models/reservation_model.dart';
import '../../widgets/custom_reservation_card.dart';

class DeviceReservationsDialog extends StatelessWidget {
  final String deviceId;
  final HiveService hiveService;
  final ReservationService reservationService;

  const DeviceReservationsDialog({
    super.key,
    required this.deviceId,
    required this.hiveService,
    required this.reservationService,
  });

  @override
  Widget build(BuildContext context) {
    int deviceIndex = hiveService.devices.indexWhere(
      (d) => d.id == deviceId,
    );
    final List<Reservation> currentReservations = reservationService
        .getCurrentReservations(hiveService.devices[deviceIndex].id);

    Map<String, List<Map<String, dynamic>>> groupedReservations = {};

    for (int i = 0; i < currentReservations.length; i++) {
      Reservation reservation = currentReservations[i];
      String dateKey = DateFormat('yyyy-MM-dd').format(reservation.startTime);

      groupedReservations.putIfAbsent(dateKey, () => []).add({
        'reservation': reservation,
        'originalIndex': i,
      });
    }

    return AlertDialog(
      title: Text(
        'Reservations for Device " ${hiveService.devices[deviceIndex].name} "',
        style:
             getTextStyle(type: FontTypeEnum.headLineLarge, color: Colors.white)
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
                        label: Text(
                         dateKey,
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber,fontSize: 12.sp),
                        ),
                        backgroundColor: Colors.purple,
                      ),

                      ...dailyReservations.map((item) {
                        Reservation reservation = item['reservation'];
                        int originalIndex = item['originalIndex'];

                        return CustomReservationCard(
                          reservationService: reservationService,hiveService: hiveService,
                          title: reservation.customerName,
                          dailyReservations: [reservation],
                          deviceId: hiveService.devices[deviceIndex].id,
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
          onPressed: () => showAddReservationDialog(hiveService: hiveService,
            notDoublePop: false,
            context: context,
            deviceId: hiveService.devices[deviceIndex].id,
          ),
          child: const Text('Add', style: TextStyle(color: Colors.purple)),
        ),
      ],
    );
  }
}

void showDeviceReservationsDialog({
  required BuildContext context,
  required String deviceId,
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
        deviceId: deviceId,
        reservationService: reservationService,
      );
    },
  );
}
