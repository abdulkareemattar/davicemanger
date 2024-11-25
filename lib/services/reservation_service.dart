import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:untitled8/services/hive_service.dart';

import '../screens/reservationScreen/start_reservation_dialog.dart';

class ReservationService extends ChangeNotifier {
  final HiveService hiveService;
  late final Box _box;
  final Map<int, Duration> _durations = {};
  final Map<int, Timer> _timers = {};

  Map<int, Duration> get durations => _durations;

  ReservationService(this.hiveService) {
    _box = hiveService.box;
  }

  /// Sets the reservation state for a device and shows the reservation dialog if needed.
  Future<void> setReservation({
    required int index,
    required bool newValue,
    required BuildContext context,
  }) async {
    if (newValue) {
      showStartReservationDialog(
          context: context, index: index, notDoublePop: true);
    }
    await _updateDeviceReservation(index, newValue);
  }

  /// Starts the reservation process for a device.
  Future<void> startReservation({
    required int index,
    required BuildContext context,
    required DateTime start,
    required DateTime end,
    required String customerName,
  }) async {
    hiveService.devices[index]
      ..startTime = start
      ..endTime = end
      ..customerName = customerName;
    await _updateDeviceReservation(index, true);

    await _box.putAt(index, hiveService.devices[index]);
    notifyListeners();
  }

  /// Cancels the reservation for a device.
  Future<void> cancelReservation(int index) async {
    hiveService.devices[index].startTime = null;
    hiveService.devices[index].endTime = null;
    hiveService.devices[index].customerName = null;
    await _updateDeviceReservation(index, false);
  }

  Future<void> checkReservationForAllDevices() async {
    for (int i = 0; i < hiveService.reservedDevices.length; i++) {
      var device = hiveService.devices[i];
      if (device.startTime != null && device.endTime != null) {
        final difference = device.endTime!.difference(device.startTime!);
        if (difference.inSeconds <= 0) {
          await cancelReservation(i);
        }
      }
    }
    notifyListeners();
  }

  /// Updates the reservation state of the device at the given index.
  Future<void> _updateDeviceReservation(int index, bool reserved) async {
    hiveService.devices[index].reserved = reserved;
    await _box.putAt(index, hiveService.devices[index]);
    notifyListeners();
  }

  /// Starts a countdown timer until the reservation time.
  void startCountdown({required int index}) {
    _durations[index] =
        hiveService.devices[index].endTime!.isBefore(DateTime.now())
            ? Duration.zero
            : hiveService.devices[index].endTime!.difference(DateTime.now());

    _timers[index]?.cancel();

    _timers[index] = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_durations[index]!.inSeconds > 0) {
        _durations[index] = _durations[index]! - const Duration(seconds: 1);
        notifyListeners(); // Notify listeners to update UI
      } else {
        timer.cancel();
        cancelReservation(index); // Cancel reservation when time is up
      }
    });
  }

  @override
  void dispose() {
    _timers.forEach((key, timer) => timer.cancel());
    super.dispose();
  }
}
