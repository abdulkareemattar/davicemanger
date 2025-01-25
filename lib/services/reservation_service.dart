import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:untitled8/services/hive_service.dart';
import '../models/hive_models/devices.dart';
import '../models/hive_models/reservation_model.dart';

class ReservationService extends ChangeNotifier {
  final HiveService myHiveService;
  late final Box<MyDevice> _box;
  Map<String, Timer> _timers = {};
  List<Reservation> _currentReservations = [];
  bool timerIsOn = false;

  ReservationService(this.myHiveService) {
    _box = myHiveService.box;
  }

  List<Reservation> getCurrentReservations(String deviceId) {
    loadReservation(deviceId);
    return _currentReservations;
  }

  Future<void> startReservation({
    required String deviceId,
    required Reservation reservation,
  }) async {
    final device = myHiveService.devices.firstWhere((d) => d.id == deviceId);
    device.reservations.add(reservation);
    await _box.put(device.key, device);
    myHiveService.updateDevices();
    notifyListeners();
  }

  Future<void> cancelReservation({
    required String deviceId,
    required int reservationIndex,
  }) async {
    final device = myHiveService.devices.firstWhere((d) => d.id == deviceId);
    device.reservations.removeAt(reservationIndex);
    await _box.put(device.key, device);
    myHiveService.updateDevices();
    notifyListeners();
  }

  Future<void> loadReservation(String deviceId) async {
    _currentReservations = myHiveService.devices.firstWhere((d) => d.id == deviceId).reservations;
  }

  Future<void> editReservation({
    required Reservation newReservation,
    required String deviceId,
    required int reservationIndex,
  }) async {
    final device = myHiveService.devices.firstWhere((d) => d.id == deviceId);
    device.reservations[reservationIndex] = newReservation;
    await _box.put(device.key, device);
    myHiveService.updateDevices();
    notifyListeners();
  }

  void startTimer(String deviceId, int reservationIndex) {
    Reservation reservation = myHiveService.devices.firstWhere((d) => d.id == deviceId).reservations[reservationIndex];
    int remainingTimeSeconds = reservation.endTime.difference(DateTime.now()).inSeconds;

    if (remainingTimeSeconds <= 0) {
      // إذا كانت قيمة remainingTimeSeconds سالبة أو صفر، يتم إلغاء الحجز فورًا
      cancelReservation(reservationIndex: reservationIndex, deviceId: deviceId);
      return;
    }

    if (_timers[deviceId] != null) {
      _timers[deviceId]!.cancel();
    }

    _timers[deviceId] = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTimeSeconds > 0) {
        remainingTimeSeconds--;
        editReservation(
          newReservation: Reservation(
            startTime: reservation.startTime,
            endTime: reservation.endTime,
            customerName: reservation.customerName,
            remainingTime: remainingTimeSeconds,
            reservationID: reservation.reservationID,
          ),
          deviceId: deviceId,
          reservationIndex: reservationIndex,
        );
      } else {
        timer.cancel();
        cancelReservation(reservationIndex: reservationIndex, deviceId: deviceId);
      }
      notifyListeners();
    });
  }

  void startCountdown({
    required String deviceId,
    required int reservationIndex,
  }) {
    Reservation reservation = myHiveService.devices.firstWhere((d) => d.id == deviceId).reservations[reservationIndex];
    int remainingTimeSeconds = reservation.remainingTime;

    if (reservation.startTime.isBefore(DateTime.now()) && _timers[deviceId] == null) {
      startTimer(deviceId, reservationIndex);
    }
  }

  void cancelAllReservation() {
    for (int i = 0; i < myHiveService.reservedDevices.length; i++) {
      final device = myHiveService.reservedDevices[i];
      for (int j = 0; j < device.reservations.length; j++) {
        cancelReservation(deviceId: device.id, reservationIndex: j);
      }
    }
  }

  @override
  void dispose() {
    _timers.forEach((deviceId, timer) {
      timer.cancel();
    });
    super.dispose();
  }
}
