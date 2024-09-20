import 'dart:async';

import 'package:flutter/material.dart';

class CountdownProvider with ChangeNotifier {
  late Duration remainingTime;
  Timer? timer;

  CountdownProvider({required this.remainingTime});

  void startCountDownFromRT({required Duration rt}) {
    remainingTime = rt;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      (remainingTime.inSeconds > 0)
          ? {
              remainingTime = remainingTime - Duration(seconds: 1),
              notifyListeners()
            }
          : timer.cancel();
    });
  }

  Duration findRimingTime(DateTime selectedTime) {
    return Duration(
      days: selectedTime.day - DateTime.now().day,
      hours: selectedTime.hour - DateTime.now().hour,
      minutes: selectedTime.minute - DateTime.now().minute,
    );
  }

  void stopCounterDown() {
    timer?.cancel();
  }

  @override
  void dispose() {
    stopCounterDown();
    super.dispose();
  }
}
