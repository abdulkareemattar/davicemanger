import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../data/devices.dart';

class HiveService extends ChangeNotifier {
  late Box<MyDevice> _box;

  List<MyDevice> get devices => _box.values.toList();

  HiveService() {
    _init();
  }

  Future<void> _init() async {
    Hive.registerAdapter(MyDeviceAdapter());
    _box = await Hive.openBox<MyDevice>('myDevices');
    notifyListeners();
  }

  Future<void> addDevice({
    required MyDevice device,
  }) async {
    await _box.add(device);
    notifyListeners();
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
}
