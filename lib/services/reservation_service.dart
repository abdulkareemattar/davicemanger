import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:untitled8/services/hive_service.dart';

import '../models/hive_models/devices.dart';
import '../models/hive_models/reservation_model.dart';

class ReservationService extends ChangeNotifier {
  final HiveService myHiveService;
  late final Box<MyDevice> _box;
  Map<int, Map<int, Timer>> _timers = {};
  List<Reservation> _currentReservations = [];
  List<Reservation> _expiredReservations = [];
  bool timerIsOn = false;

  // Constructor
  ReservationService(this.myHiveService) {
    _box = myHiveService.box;
  }

  List<Reservation> getCurrentReservations(int deviceIndex) {
    loadReservation(deviceIndex);
    return _currentReservations;
  }

  List<Reservation> getExpiredReservations(int deviceIndex) {
    loadReservation(deviceIndex);
    return _expiredReservations;
  }

  // Start a new reservation
  Future<void> startReservation({
    required int deviceIndex,
    required Reservation reservation,
  }) async {
    final device = myHiveService.devices[deviceIndex];
    device.reservations.add(reservation);
    device.reserved = true;
    await _box.putAt(deviceIndex, device);
    notifyListeners();
  }

  // Cancel an existing reservation
  Future<void> cancelReservation({
    required int deviceIndex,
    required int reservationIndex,
  }) async {
    final device = myHiveService.devices[deviceIndex];
    device.reservations.removeAt(reservationIndex);
    device.reserved = device.reservations.isNotEmpty;
    await _box.putAt(deviceIndex, device);
    notifyListeners();
  }

  // Load reservations for a specific device
  Future<void> loadReservation(int deviceIndex) async {
    _currentReservations = myHiveService.devices[deviceIndex].reservations;
    _filterExpiredReservations();
  }

  // Filter expired reservations
  void _filterExpiredReservations() {
    DateTime now = DateTime.now();
    _expiredReservations =
        _currentReservations.where((r) => r.endTime.isBefore(now)).toList();
    _currentReservations.removeWhere((r) => r.endTime.isBefore(now));
  }

  // Edit an existing reservation
  Future<void> editReservation({
    required Reservation newReservation,
    required int deviceIndex,
    required int reservationIndex,
  }) async {
    final device = myHiveService.devices[deviceIndex];
    device.reservations[reservationIndex] = newReservation;
    await _box.putAt(deviceIndex, device);
    notifyListeners();
  }

  void startTimer(int deviceIndex, int reservationIndex) {
    Reservation reservation =
        myHiveService.devices[deviceIndex].reservations[reservationIndex];
    int remainingTimeSeconds =
        reservation.endTime.difference(DateTime.now()).inSeconds;

    _timers[deviceIndex] = {};

    // Initialize the timer for countdown
    _timers[deviceIndex]![reservationIndex] =
        Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTimeSeconds > 0) {
        remainingTimeSeconds--;
        editReservation(
            newReservation: Reservation(
                startTime: reservation.startTime,
                endTime: reservation.endTime,
                customerName: reservation.customerName,
                remainingTime: remainingTimeSeconds,
                reservationID: reservation.reservationID),
            deviceIndex: deviceIndex,
            reservationIndex: reservationIndex);
      } else {
        timer.cancel();
        cancelReservation(
            reservationIndex: reservationIndex, deviceIndex: deviceIndex);
      }
      notifyListeners();
    });
  }

  // Start countdown for a reservation
  void startCountdown({
    required int deviceIndex,
    required int reservationIndex,
  }) {
    // Get the reservation and calculate the duration
    Reservation reservation =
        myHiveService.devices[deviceIndex].reservations[reservationIndex];

    int remainingTimeSeconds = myHiveService
        .devices[deviceIndex].reservations[reservationIndex].remainingTime;
    Duration myDuration = Duration(seconds: remainingTimeSeconds);

    /// Whether this [startTime] occurs after [now].
    if (reservation.startTime.isBefore(DateTime.now()) &&
        _timers[deviceIndex]?[reservationIndex] == null) {
      startTimer(deviceIndex, reservationIndex);
    }
  }

  @override
  void dispose() {
    // Cancel all timers when disposing the service

    super.dispose();
  }
}
