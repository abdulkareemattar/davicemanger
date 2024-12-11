import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/Functions/show_snackbar.dart';
import 'package:untitled8/services/hive_service.dart';

bool checkIfDateConflict({
  required DateTime startTime,
  required DateTime endTime,
  required int deviceIndex,
  required BuildContext context,
}) {
  // 1. Input Validation: Check for invalid date ranges
  if (startTime.isAfter(endTime)) {
    showCustomSnackBar(
      context: context,
      txt: 'End time cannot be before start time.',
    );
    return true; // Indicate an error
  }

  // 2. Handle null or invalid deviceIndex
  final hiveService = Provider.of<HiveService>(context, listen: false);
  final reservations = hiveService.devices[deviceIndex].reservations;

  // 3. Handle null or empty reservations list (as before)
  if (reservations == null || reservations.isEmpty) {
    return false; // No conflicts if there are no reservations
  }

  // 4. Check for conflicts (as before, but improved)
  for (final reservation in reservations) {
    //More robust overlap check. Handles edge cases where start/end times are equal.
    if (startTime.isBefore(reservation.endTime) &&
            endTime.isAfter(reservation.startTime) ||
        startTime.isAtSameMomentAs(reservation.startTime) ||
        endTime.isAtSameMomentAs(reservation.endTime)) {
      showCustomSnackBar(
        context: context,
        txt:
            'There is a conflict with an existing reservation from ${reservation.startTime} to ${reservation.endTime}.',
      );
      return true;
    }
  }

  return false; // No conflict found
}
