import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/services/hive_service.dart';
import 'package:untitled8/services/reservation_service.dart';

class CustomCounter extends StatelessWidget {
  final bool enableDescriptions;
  final Color textColor;
  final double baseFontSize;
  final String deviceId;
  final int reservationIndex;

  const CustomCounter({
    super.key,
    this.enableDescriptions = false,
    this.textColor = Colors.black,
    this.baseFontSize = 30.0,
    required this.deviceId,
    required this.reservationIndex,
  });

  @override
  Widget build(BuildContext context) {
    HiveService myHiveService = Provider.of<HiveService>(context, listen: true);
    ReservationService myReservationService = Provider.of<ReservationService>(context, listen: true);
    int deviceIndex = myHiveService.devices.indexWhere((d) => d.id == deviceId);
    Duration duration = Duration(
        seconds: myHiveService
            .devices[deviceIndex].reservations[reservationIndex].remainingTime);

    return Padding(
      padding: EdgeInsets.only(top: 30.0.h),
      child: SizedBox(
        width: 300.w,
        height: 170.h,
        child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            _buildTimeBlock(duration.inDays.toString().padLeft(2, '0'), 'Days'),
            _colon(),
            _buildTimeBlock(
                duration.inHours.remainder(24).toString().padLeft(2, '0'),
                'Hours'),
            _buildTimeBlock(
                duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
                'Minutes'),
            _colon(),
            _buildTimeBlock(
                duration.inSeconds.remainder(60).toString().padLeft(2, '0'),
                'Seconds'),
          ],
        ),
      ),
    );
  }

  Widget _colon() {
    return const Center(
      child: Text(":",
          style: TextStyle(
              fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }

  Widget _buildTimeBlock(String countdownValue, String? description) {
    return Center(
      child: Container(
        width: 200.w,
        height: 200.h,
        decoration: BoxDecoration(
            color: Colors.purple, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(countdownValue,
                style: TextStyle(
                    fontSize: baseFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber[700])),
            if (description != null) ...[
              const SizedBox(height: 5),
              Text(description,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ],
          ],
        ),
      ),
    );
  }
}

void showCounterDialog({
  required BuildContext context,
  required String deviceId,
  required int reservationIndex,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "Countdown Timer",
          style: TextStyle(
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        content: CustomCounter(
            deviceId: deviceId, reservationIndex: reservationIndex),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // لإغلاق الـ Dialog
            },
            child: Text("Close"),
          ),
        ],
      );
    },
  );
}
