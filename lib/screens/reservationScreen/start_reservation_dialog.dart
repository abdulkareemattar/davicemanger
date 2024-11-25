import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/services/hive_service.dart';
import 'package:untitled8/widgets/custom_textformfield.dart';

import '../../Functions/time&date_picker.dart';
import '../../services/reservation_service.dart';
import '../../widgets/custom_datetime_picker_formfield.dart';

class StartReservationDialog extends StatelessWidget {
  final int index;
  final bool notDoublePop;

  const StartReservationDialog({
    super.key,
    required this.index,
    required this.notDoublePop,
  });

  @override
  Widget build(BuildContext context) {
    final myHiveService = Provider.of<HiveService>(context, listen: false);
    final myReservationService =
        Provider.of<ReservationService>(context, listen: false);
    DateTime? startTime;
    DateTime? endTime;
    final TextEditingController nameController = TextEditingController();

    return AlertDialog(
      title: Text(
          'Start reservation for ${myHiveService.devices[index].name} device'),
      content: Padding(
        padding: EdgeInsets.only(top: 20.0.h),
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFormField(
                validate: (value) =>
                    value.isEmpty ? "Please Enter Customer's username" : null,
                txt: "Enter the customer name :",
                controller: nameController,
                label: 'Customer Name',
                keyboard: TextInputType.text,
              ),
              CustomBasicDateTimeField(
                valid: (value) => value == null
                    ? "Please select start time for the Reservation"
                    : null,
                txt:
                    'Enter The (date & time) that you will start reserve this device at :',
                label: 'Start Date & Time',
                onShowPicker: (context, current) async {
                  return startTime =
                      await getTime(context: context, currentValue: current);
                },
              ),
              CustomBasicDateTimeField(
                valid: (value) => value == null
                    ? "Please select end time for the Reservation"
                    : null,
                txt:
                    'Enter The (date & time) that you will end reserve for this device at :',
                label: 'End Date & Time',
                onShowPicker: (context, current) async {
                  return endTime =
                      await getTime(context: context, currentValue: current);
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty ) {

                      print("Start Reservation: index=$index, startTime=$startTime,endTime=$endTime, name=${nameController.text}");
                      myReservationService.startReservation(
                        context: context,
                        index: index,
                        start: startTime!,
                        end: endTime!,
                        customerName: nameController.text,
                      );
                      Navigator.pop(context);
                  }
                },
                child: const Text('Start Reservation',
                    style: TextStyle(color: Colors.purple)),
              ),
              TextButton(
                onPressed: () => {
                  myReservationService.cancelReservation(index),
                  Navigator.pop(context)
                },
                // Close dialog without canceling reservation
                child:
                    const Text('Cancel', style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Usage function
void showStartReservationDialog({
  required BuildContext context,
  required int index,
  required bool notDoublePop,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return StartReservationDialog(index: index, notDoublePop: notDoublePop);
    },
  );
}
