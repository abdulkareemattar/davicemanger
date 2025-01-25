import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/reservation_service.dart';

void showCancellationConfirmationDialog(
    {required BuildContext context,
    required ReservationService myReservationService,
    required String deviceId,
    required int reservationIndex}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Confirm Cancellation',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 20.sp),
        ),
        content:
             Text('Are you sure you want to cancel this reservation?',style: TextStyle(fontSize: 16.sp),),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            // Close confirmation dialog
            child: const Text('No',style: TextStyle(color: Colors.red),),
          ),
          TextButton(
            onPressed: () {
              myReservationService.cancelReservation(
                  deviceId: deviceId, reservationIndex: reservationIndex);
              Navigator.pop(context); // Close confirmation dialog
              Navigator.pop(context); // Close original dialog
            },
            child: const Text('Yes',style: TextStyle(color: Colors.green),),
          ),
        ],
      );
    },
  );
}
