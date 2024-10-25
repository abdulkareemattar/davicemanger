import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../data/devices.dart';

class HiveService extends ChangeNotifier {
  late Box<MyDevice> _box;
  bool _isInitialized = false;
  bool isReserved = false;
  String customerName = '';
  DeviceTypesEnums? type;
  DateTime dateTime = DateTime.now();

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


  Future<void> reservation({
    int? index,
    required bool newValue,
    required bool isNewDevice,
    DateTime? time,
    String? customerName,
  }) async {
    if (isNewDevice) {
      isReserved = newValue;
      notifyListeners();
    } else {
      devices[index!].reserved = newValue;
      if (newValue) {
        // ضبط الوقت الحالي عند الحجز
        devices[index].selectedTime = time;
        devices[index].customerName = customerName;

        // حفظ الحالة الحالية
        await _box.putAt(index, devices[index]);

        // بدء الموقت
        Timer.periodic(const Duration(seconds: 1), (timer) async {
          // تحديث وقت الحجز كل ثانية
          devices[index].selectedTime = devices[index].selectedTime!.subtract(const Duration(seconds: 1));

          // تحديث واجهة المستخدم (إذا لزم الأمر)
          notifyListeners();

          // إيقاف الموقت عند انتهاء وقت الحجز
          if (devices[index].selectedTime!.isBefore(DateTime.now())) {
            timer.cancel();

            // إلغاء الحجز
            devices[index].reserved = false; // إلغاء الحجز
            devices[index].selectedTime = null; // إعادة تعيين الوقت
            devices[index].customerName = null; // إعادة تعيين اسم العميل

            // حفظ الحالة النهائية عند انتهاء الوقت
            await _box.putAt(index, devices[index]);

            // تحديث واجهة المستخدم بعد إلغاء الحجز
            notifyListeners();
          }
        });

      } else {
        devices[index].selectedTime = null;
        devices[index].customerName = null;

        // حفظ الحالة النهائية عند إلغاء الحجز
        await _box.putAt(index, devices[index]);
      }
      notifyListeners();
    }
  }




  void dropDownSelectType(DeviceTypesEnums newValue) {
    type = newValue;
    notifyListeners();
  }
}
