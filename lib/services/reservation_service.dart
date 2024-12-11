import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:untitled8/services/hive_service.dart';

import '../models/hive_models/devices.dart';
import '../models/hive_models/reservation_model.dart';

class ReservationService extends ChangeNotifier {
  final HiveService myHiveService;
  late final Box<MyDevice> _box;
  final Map<int, Duration> _durations = {};
  final Map<int, Timer> _timers = {};

  Map<int, Duration> get durations => _durations;

  ReservationService(this.myHiveService) {
    _box = myHiveService.box;
  }


  /// Starts the reservation process for a device.
  Future<void> startReservation({
    required BuildContext context,
    required int deviceIndex,
    required Reservation reservation,
  }) async {
    final device=myHiveService.devices[deviceIndex];
    // Add the new reservation
    device.reservations!.add(reservation);
    device.reserved = true;
    // Update the device in the box
    await _box.putAt(deviceIndex,device);
    notifyListeners();
  }

  /// Cancels the reservation.
  Future<void> cancelReservation({
    required int deviceIndex,
    required int reservationIndex, // Changed to reservationIndex
  }) async {
    final device = myHiveService.devices[deviceIndex];
    device.reservations!.removeAt(reservationIndex);
    device.reserved = device.reservations!.isNotEmpty;
    await _box.putAt(deviceIndex, device);
    notifyListeners();
  }

  Future<void> checkReservationForOneDevice(int deviceIndex) async {
    final myDevice = myHiveService.devices[deviceIndex];
    for (int reserveIndex = 0;
        reserveIndex < myDevice.reservations!.length;
        reserveIndex++) {
      final Duration difference = myDevice.reservations![reserveIndex].endTime
          .difference(DateTime.now());
      if (difference.inSeconds <= 0) {
        cancelReservation(
            deviceIndex: deviceIndex, reservationIndex: reserveIndex);
      }
    }
  }

  Future<void> checkReservationForAllDevices() async {
    for (int deviceIndex = 0;
        deviceIndex < myHiveService.devices.length;
        deviceIndex++) {
      final myDevice = myHiveService.devices[deviceIndex];
      if (myDevice.reserved) {
        await checkReservationForOneDevice(deviceIndex);
      }
    }
    notifyListeners();
  }

  /// Updates the reservation state of the device at the given index.
  Future<void> _updateDeviceReservation(int index, bool reserved) async {
    myHiveService.devices[index].reserved = reserved;
    await _box.putAt(index, myHiveService.devices[index]);
    notifyListeners();
  }

  /// Starts a countdown timer until the reservation time.
  void startCountdown(
      {required int deviceIndex, required int reservationIndex}) {
    _durations[deviceIndex] = myHiveService
            .devices[deviceIndex].reservations!.last.endTime
            .isBefore(DateTime.now())
        ? Duration.zero
        : myHiveService.devices[deviceIndex].reservations!.last.endTime
            .difference(DateTime.now());

    _timers[deviceIndex]?.cancel();

    _timers[deviceIndex] = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_durations[deviceIndex]!.inSeconds > 0) {
        _durations[deviceIndex] =
            _durations[deviceIndex]! - const Duration(seconds: 1);
        notifyListeners(); // Notify listeners to update UI
      } else {
        timer.cancel();
        cancelReservation(
            reservationIndex: reservationIndex, deviceIndex: deviceIndex);
      }
    });
  }

  @override
  void dispose() {
    _timers.forEach((key, timer) => timer.cancel());
    super.dispose();
  }
}
