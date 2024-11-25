import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/services/reservation_service.dart';

class CustomCounter extends StatelessWidget {
  final bool enableDescriptions;
  final Color textColor;
  final Color colonColor;
  final double baseFontSize;
  final int index;

  const CustomCounter({
    super.key,
    this.enableDescriptions = false,
    this.textColor = Colors.black,
    this.colonColor = Colors.red,
    this.baseFontSize = 30.0,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final myReservationDuration =
        Provider.of<ReservationService>(context).durations;

    final countdownElements = [
      _buildTimeBlock(
          myReservationDuration[index]!.inDays.toString().padLeft(2, '0'),
          'Days'),
      _colon(),
      _buildTimeBlock(
          myReservationDuration[index]!
              .inHours
              .remainder(24)
              .toString()
              .padLeft(2, '0'),
          'Hours'),
      _buildTimeBlock(
          myReservationDuration[index]!
              .inMinutes
              .remainder(60)
              .toString()
              .padLeft(2, '0'),
          'Minutes'),
      _colon(),
      _buildTimeBlock(
          myReservationDuration[index]!
              .inSeconds
              .remainder(60)
              .toString()
              .padLeft(2, '0'),
          'Seconds'),
    ];

    return Center(
      child: SizedBox(
        width: 300,
        height: 200,
        child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: countdownElements,
        ),
      ),
    );
  }

  Widget _colon() {
    return const Center(
      child: Text(":",
          style: TextStyle(
              fontSize: 50, fontWeight: FontWeight.bold, color: Colors.red)),
    );
  }

  Widget _buildTimeBlock(String countdownValue, String? description) {
    return Container(
      width: 200,
      height: 200,
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
    );
  }
}
