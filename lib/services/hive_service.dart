import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:time_planner/time_planner.dart';

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

  Box get box => _box;

  List<MyDevice> get reservedDevices =>
      _box.values.where((device) => device.reserved).toList();

  List<TimePlannerTask>? getReservedTasks() {
    List<TimePlannerTask> tasks = [];
    for (MyDevice device in reservedDevices) {
      DateTime from = device.startTime!;
      DateTime to = device.endTime!;
      Duration difference = to.difference(from);
      tasks.add(
        TimePlannerTask(
          minutesDuration: 200,
          dateTime: TimePlannerDateTime(
            day: DateTime.now().day,
            hour: DateTime.now().hour,
            minutes: DateTime.now().minute,
          ),
          color: Colors.blue,
          // لون المهمة
          onTap: () {
            // تنفيذ حدث عند الضغط على المهمة
            print('تم الضغط على المهمة!');
          },
          child: Text(
            device.name,
            style: TextStyle(color: Colors.white),
          ),
          // المسافة من اليسار
          widthTask: 200.0, // عرض المهمة
        ),
      );
    }
    return tasks;
  }

  HiveService() {
    init();
  }

  Future<void> init() async {
    try {
      // تسجيل TypeAdapters لمرة واحدة
      if (!Hive.isAdapterRegistered(MyDeviceAdapter().typeId)) {
        Hive.registerAdapter(MyDeviceAdapter());
      }
      if (!Hive.isAdapterRegistered(DeviceTypesEnumsAdapter().typeId)) {
        Hive.registerAdapter(DeviceTypesEnumsAdapter());
      }
      _box = await Hive.openBox<MyDevice>('myDevices');
      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      print('Error initializing Hive: $e');
    }
  }

  bool get isInitialized => _isInitialized;

  Future<void> addDevice({
    required MyDevice device,
  }) async {
    await _box.add(device);
    notifyListeners();
    type = null;
  }

  Future<void> updateDevice({
    required int index,
    required MyDevice device,
  }) async {
    await _box.putAt(index, device);
    notifyListeners();
  }

  Future<void> deleteDevice({
    required int index,
  }) async {
    await _box.deleteAt(index);
    notifyListeners();
  }

  Future<void> deleteAllDevices() async {
    await _box.clear();
    notifyListeners();
  }

  Future<void> saveDetails(int index) async {
    await _box.putAt(index, devices[index]);
    notifyListeners();
  }

  void dropDownSelectType(DeviceTypesEnums newValue) {
    type = newValue;
    notifyListeners();
  }
}
