import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled8/models/hive_models/devices.dart'; // Your Device model


void showDialogEndReservation({
  required BuildContext context,
  required int deviceIndex,
  required int reservationIndex,
  required MyDevice myDevice,
}) {
  final reservation = myDevice.reservations![reservationIndex];

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Reservation Details for ${myDevice.name}'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Are you sure you want to end this reservation?'),
            Wrap( // Use a Wrap to arrange Chips horizontally
              spacing: 8.0, // Spacing between Chips
              children: [
                _buildChip('Customer', reservation.customerName!),
                _buildChip('Start', reservation.startTime.toIso8601String()),
                _buildChip('End', reservation.endTime.toIso8601String()),
              ],
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Call your cancellation function here, passing deviceIndex and reservationIndex
            //Example (replace with your actual function call)
            // myReservationService.cancelReservation(deviceIndex: deviceIndex, reservationIndex: reservationIndex);
            Navigator.pop(context);
          },
          child: const Text('End Reservation', style: TextStyle(color: Colors.orange)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    ),
  );
}

Widget _buildChip(String label, String value) {
  return Chip(
    label: Text('$label: $value'),
    avatar: const CircleAvatar(
      backgroundColor: Colors.grey,
      child: Icon(Icons.info_outline, size: 16), //Changed Icon
    ),
  );
}
