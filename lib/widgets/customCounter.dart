import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/services/hive_service.dart';
class CustomCounter extends StatelessWidget {
  final DateTime selectedTime;
  final bool enableDescriptions;
  final Color textColor;
  final Color colonColor;
  final double baseFontSize;

  const CustomCounter({
    super.key,
    this.enableDescriptions = false,
    required this.selectedTime,
    this.textColor = Colors.black, // Default text color
    this.colonColor = Colors.red, // Default colon color
    this.baseFontSize = 30.0, // Default base font size
  });

  Widget build(BuildContext context) {
    final countdownNotifier = Provider.of<HiveService>(context);
    final duration = selectedTime.isBefore(DateTime.now())
        ? Duration.zero
        : selectedTime.difference(DateTime.now());

    final List<Widget> countdownElements = [
      _buildTimeBlock(duration.inDays.toString().padLeft(2, '0'), 'Days'),
      _colon(),
      _buildTimeBlock(
          duration.inHours.remainder(24).toString().padLeft(2, '0'), 'Hours'),
      _buildTimeBlock(
          duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
          'Minutes'),
      _colon(),
      _buildTimeBlock(
          duration.inSeconds.remainder(60).toString().padLeft(2, '0'),
          'Seconds'),
    ];

    return Center(
      child: SizedBox(
        width: 300,
        height: 200,
        child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: countdownElements,
        ),
      ),
    );
  }

  Widget _colon() {
    return Center(
      child: Text(":",
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.red)),
    );
  }

  Widget _buildTimeBlock(String countdownValue, String? description) {
    return Container(
      width: 200.w,
      height: 200.h,
      decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(countdownValue,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.amber[700])),
          if (description != null) ...[
            SizedBox(height: 5),
            Text(description,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ],
      ),
    );
  }
}
