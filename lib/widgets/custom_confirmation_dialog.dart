import 'package:flutter/material.dart';

import '../services/reservation_service.dart';

void showCancellationConfirmationDialog(BuildContext context,
    ReservationService myReservationService, int index) {
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
                  .cancelReservation(index); // Call the cancellation method
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