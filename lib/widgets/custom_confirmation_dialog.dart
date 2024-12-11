import 'package:flutter/material.dart';

import '../services/reservation_service.dart';

void showCancellationConfirmationDialog({required BuildContext context,
    required ReservationService myReservationService, required int deviceIndex, required int reservationIndex}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Cancellation'),
        content:
        const Text('Are you sure you want to cancel this reservation?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            // Close confirmation dialog
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              myReservationService
                  .cancelReservation(deviceIndex: deviceIndex, reservationIndex: reservationIndex); // Call the cancellation method
              Navigator.pop(context); // Close confirmation dialog
              Navigator.pop(context); // Close original dialog
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}