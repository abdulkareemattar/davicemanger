import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/hive_models/device_type_enums.dart';
import '../models/hive_models/devices.dart';

class HiveService extends ChangeNotifier {
  late Box<MyDevice> _box;
  bool _isInitialized = false;
  bool isReserved = false;
  String customerName = '';
  DeviceTypesEnums? type;
  DateTime dateTime = DateTime.now();

  List<MyDevice> get devices => _box.values.toList();
  List<MyDevice> filteredDevices = [];
  List<MyDevice> activeDevices = [];
  List<MyDevice> expiredDevices = [];
  List<MyDevice> reservedDevices = [];

  void filterDevices(String query) {
    if (query.isEmpty) {
      filteredDevices = _box.values.toList();
    } else {
      filteredDevices = _box.values
          .where((device) =>
          device.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners(); // إعلام المستمعين بالتغييرات
  }

  Box<MyDevice> get box => _box;

  HiveService() {
    init();
  }

  Future<void> init() async {
      // تسجيل TypeAdapters لمرة واحدة
      if (!Hive.isAdapterRegistered(MyDeviceAdapter().typeId)) {
        Hive.registerAdapter(MyDeviceAdapter());
      }
      if (!Hive.isAdapterRegistered(DeviceTypesEnumsAdapter().typeId)) {
        Hive.registerAdapter(DeviceTypesEnumsAdapter());
      }
      _box = await Hive.openBox<MyDevice>('myDevices');
      updateDevices();
      _isInitialized = true;
      notifyListeners();
    }

  bool get isInitialized => _isInitialized;

  void updateDevices() {
    filteredDevices = devices.toList();
    expiredDevices = devices
        .where((device) =>
        device.reservations.any((r) => r.endTime.isBefore(DateTime.now())))
        .toList();
    reservedDevices = devices.where((device) =>
    device.reservations.isNotEmpty).toList();
  }

  Future<void> addDevice({
    required MyDevice device,
  }) async {
    await _box.add(device);
    updateDevices();
    type=null;
    notifyListeners();
  }

  Future<void> updateDevice({
    required String id,
    required MyDevice device,
  }) async {
    final originalDevice = _box.values.firstWhere((d) => d.id == id);
    await _box.put(originalDevice.key, device); // استخدام key للجهاز
    updateDevices(); // تحديث القوائم بعد التحديث
    notifyListeners();
  }

  Future<void> deleteDeviceById({
    required String id,
  }) async {
    try {
      final device = _box.values.firstWhere((device) => device.id == id);
      await _box.delete(device.key); // حذف الجهاز باستخدام مفتاح Hive
      updateDevices(); // تحديث القوائم بعد الحذف
      notifyListeners();
    } catch (e) {
      print('Error deleting device: $e');
    }
  }

  Future<void> deleteAllDevices() async {
    await _box.clear();
    updateDevices(); // تحديث القوائم بعد حذف جميع الأجهزة
    notifyListeners();
  }

  Future<void> saveDetails(String id) async {
    final device = _box.values.firstWhere((d) => d.id == id);
    await _box.put(device.key, device);
    updateDevices(); // تحديث القوائم بعد الحفظ
    notifyListeners();
  }

  void dropDownSelectType(DeviceTypesEnums newValue) {
    type = newValue;
    notifyListeners();
  }
}
