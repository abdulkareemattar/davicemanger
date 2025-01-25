import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:untitled8/services/hive_service.dart';
import 'package:untitled8/services/reservation_service.dart';
import 'package:untitled8/widgets/customCounter.dart';

import '../screens/reservationScreen/edit_reservation_dialog.dart';
import 'custom_confirmation_dialog.dart';
import 'custom_slidable.dart';

class CustomReservationCard extends StatelessWidget {
  final String title;
  final String deviceId;
  final int reservationIndex;
  final List<dynamic> dailyReservations;
  final ReservationService reservationService;
  final HiveService hiveService;

  const CustomReservationCard({
    Key? key,
    required this.title,
    required this.dailyReservations,
    required this.deviceId,
    required this.reservationIndex,
    required this.reservationService,
    required this.hiveService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final originalDeviceIndex = hiveService.devices.indexWhere((d) => d.id == deviceId);

    return Card(
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
                  deviceIndex: originalDeviceIndex,
                  reservationIndex: reservationIndex,
                  notDoublePop: false,
                );
              },
              deleteFunction: () {
                showCancellationConfirmationDialog(
                  deviceId: deviceId,
                  reservationIndex: reservationIndex,
                  context: context,
                  myReservationService: reservationService,
                );
              },
              child: ListTile(
                title: SizedBox(
                  height: 165.h,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTimeInfo('from:', reservation.startTime,Colors.white),
                          _buildTimeInfo('to:', reservation.endTime, Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
                subtitle: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Reserved by:',
                      style: TextStyle(overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Chip(
                      label: Text(
                        reservation.customerName ?? 'Unknown',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber,fontSize: 12.sp),
                      ),
                      backgroundColor: Colors.purple,
                    ),

                  ],
                ),
                onTap: () => {
                  reservationService.startCountdown(
                    deviceId: deviceId,
                    reservationIndex: reservationIndex,
                  ),
                  showCounterDialog(
                    context: context,
                    deviceId: deviceId,
                    reservationIndex: reservationIndex,
                  ),
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
  Widget _colon() {
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: 2.w),
      child: Center(
        child: Text(":",
            style: TextStyle(
                fontSize: 30.sp, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  Widget _buildTimeInfo(String label, DateTime time, Color color) {
    return Column(
      children: [
        Align(alignment: AlignmentDirectional.topStart,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Chip(
              label: Text(
                DateFormat('dd-MM-yyyy').format(time),
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber,fontSize: 12.sp),
              ),
              backgroundColor: Colors.purple,
            ),
            _colon(),
            Chip(
              label: Text(
                DateFormat('kk:mm').format(time),
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber,fontSize: 12.sp),
              ),
              backgroundColor: Colors.purple,
            ),

          ],
        ),
      ],
    );
  }
}
