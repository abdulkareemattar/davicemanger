import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../data/devices.dart';

class HiveService extends ChangeNotifier {
  late Box<MyDevice> _box;
  bool _isInitialized = false;
  bool isReserved = false;
  DeviceTypesEnums? type;

  List<MyDevice> get devices => _box.values.toList();

  HiveService() {
    _init();
  }

  Future<void> _init() async {
    Hive.registerAdapter(MyDeviceAdapter());
    Hive.registerAdapter(DeviceTypesEnumsAdapter());
    _box = await Hive.openBox<MyDevice>('myDevices');
    _isInitialized = true;
    notifyListeners();
  }

  bool get isInitialized => _isInitialized;

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

  void editReserved({required index}) {
    devices[index].reserved = !devices[index].reserved;
    notifyListeners();
  }

  void setSwitch(bool newValue) {
    isReserved = newValue;
    notifyListeners();
  }

  void dropDownSelectType(DeviceTypesEnums newValue) {
    type = newValue;
    notifyListeners();
  }
}
