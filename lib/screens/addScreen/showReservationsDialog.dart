import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:untitled8/services/hive_service.dart';

import '../../models/hive_models/reservation_model.dart';

class DeviceReservationsDialog extends StatelessWidget {
  final int deviceIndex;
  final HiveService hiveService;

  const DeviceReservationsDialog({
    super.key,
    required this.deviceIndex,
    required this.hiveService,
  });

  @override
  Widget build(BuildContext context) {
    final reservations = hiveService.devices[deviceIndex].reservations;

    // تجميع الحجوزات حسب اليوم
    Map<String, List<Reservation>> groupedReservations = {};
    for (var reservation in reservations) {
      String dateKey = DateFormat('yyyy-MM-dd').format(reservation.startTime);
      if (!groupedReservations.containsKey(dateKey)) {
        groupedReservations[dateKey] = [];
      }
      groupedReservations[dateKey]!.add(reservation);
    }

    return AlertDialog(
      title: Text(
        'Reservations for Device ${hiveService.devices[deviceIndex].name}',
        style:
            const TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
      ),
      content: groupedReservations.isEmpty
          ? const Center(child: Text('No reservations found.'))
          : Container(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: groupedReservations.keys.length,
                itemBuilder: (context, index) {
                  String dateKey = groupedReservations.keys.elementAt(index);
                  List<Reservation> dailyReservations =
                      groupedReservations[dateKey]!;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 10,
                    shadowColor: Colors.black26,
                    child: ExpansionTile(
                      title: Text(
                        dateKey,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      children: dailyReservations.map((reservation) {
                        return SizedBox(
                          child: ListTile(
                            title: SizedBox(
                              height: 160.h,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'from : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                    Chip(
                                        label: Text(
                                            '${DateFormat(' dd-mm-yyyy : kk:mm').format(reservation.startTime)}')),
                                    Text(
                                      'to : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                                    Chip(
                                        label: Text(
                                            '${DateFormat(' dd-mm-yyyy : kk:mm').format(reservation.endTime)}')),
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
                                      fontWeight: FontWeight.bold),
                                ),
                                Chip(
                                  label: Text(
                                    '${reservation.customerName}',
                                  ),
                                ),
                              ],
                            ),
                            trailing: Icon(Icons.event_available,
                                color: Colors.purple),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close', style: TextStyle(color: Colors.purple)),
        ),
      ],
    );
  }
}

// Usage function
void showDeviceReservationsDialog({
  required BuildContext context,
  required int deviceIndex,
  required bool notDoublePop,
  required HiveService hive,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return DeviceReservationsDialog(
        hiveService: hive,
        deviceIndex: deviceIndex,
      );
    },
  );
}
