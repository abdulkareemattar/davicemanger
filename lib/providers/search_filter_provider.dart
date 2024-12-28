import 'package:flutter/cupertino.dart';
import 'package:untitled8/models/hive_models/devices.dart';

import '../services/hive_service.dart';
import '../services/reservation_service.dart';

class SearchFilterProvider extends ChangeNotifier {
  final HiveService hiveService;
  final ReservationService reservationService;

  List<MyDevice> _allDevices = []; // Private variable to hold all devices
  List<MyDevice> get allDevices => _allDevices; // Getter to access allDevices

  List<MyDevice> filteredDevices = [];

  SearchFilterProvider(
      {required this.hiveService, required this.reservationService}) {
    _loadDevices(); // Load devices when the provider is initialized.
  }

  Future<void> _loadDevices() async {
    _allDevices = hiveService.devices; //Use an async function here
    notifyListeners();
  }

  void filterDevices(String query) {
    query = query.toLowerCase();
    filteredDevices = allDevices
        .where((device) => device.name.toLowerCase().contains(query))
        .toList();
    notifyListeners();
  }
}
