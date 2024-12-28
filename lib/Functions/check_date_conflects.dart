import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../services/hive_service.dart';
import '../widgets/custom_information_dialog.dart';
// ... other imports

bool checkIfDateConflict({
  required DateTime startTime,
  required DateTime endTime,
  required String? reservationID,
  required int deviceIndex,
  required BuildContext context,
}) {
  // 1. Check for past reservation attempts
  if (endTime.isBefore(DateTime.now())) {
    showCustomInfDialog(
        context: context, txt: 'You Can\'t Reserve in The Past');
    return true;
  }
  // 2. Handle null or invalid deviceIndex and reservations
  final hiveService = Provider.of<HiveService>(context, listen: false);
  final device = hiveService.devices[deviceIndex];
  final reservations = device.reservations;

  // 3. Handle empty reservations list
  if (reservations.isEmpty) {
    return false; // No conflicts if no reservations exist
  }

  // 4. Check for conflicts, handling overlapping times more precisely
  for (final reservation in reservations) {
    //Skip self-comparison
    if (reservation.reservationID == reservationID) continue;

    //Improved overlap check: Uses isAfter and isBefore for more accurate comparisons
    if (startTime.isBefore(reservation.endTime) &&
        endTime.isAfter(reservation.startTime)) {
      showCustomInfDialog(
        context: context,
        txt:
            'Conflict with reservation from ${reservation.startTime} to ${reservation.endTime}.',
      );
      return true;
    }
  }

  return false; // No conflict found
}
