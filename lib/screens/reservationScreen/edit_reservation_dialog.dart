import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/services/hive_service.dart';
import 'package:untitled8/widgets/custom_textformfield.dart';

import '../../Functions/check_date_conflects.dart';
import '../../Functions/show_snackbar.dart';
import '../../Functions/time&date_picker.dart';
import '../../models/hive_models/reservation_model.dart';
import '../../services/reservation_service.dart';
import '../../widgets/custom_datetime_picker_formfield.dart';

class EditReservationDialog extends StatelessWidget {
  final int deviceIndex;
  final int reservationIndex;
  final bool notDoublePop;

  const EditReservationDialog({
    super.key,
    required this.deviceIndex,
    required this.notDoublePop,
    required this.reservationIndex,
  });

  @override
  Widget build(BuildContext context) {
    final myHiveService = Provider.of<HiveService>(context, listen: true);
    final myReservationService =
        Provider.of<ReservationService>(context, listen: false);
    final Reservation currentReservation =
        myHiveService.devices[deviceIndex].reservations[reservationIndex];
    TextEditingController nameController = TextEditingController(
      text: currentReservation.customerName,
    );
    DateTime startTime=currentReservation.startTime;
    DateTime endTime=currentReservation.endTime;

    return AlertDialog(
      title: Text(
          'Edit reservation for ${myHiveService.devices[deviceIndex].name} device'),
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
                label: Row(
                  children:[
                    Text('Customer Name'),
                    Spacer(),
                    Icon(FluentIcons.person_add_32_regular)
                  ]
                ),
                keyboard: TextInputType.text,
              ),
              CustomBasicDateTimeField(
                valid: (value) => value == null
                    ? "Please select time for start the Reservation"
                    : null,
                initialValue: currentReservation.startTime,
                txt:
                    'Enter The (date & time) that you will reserve this device at :',
                label: Row(
                  children: [
                    Text('Start Date & Time'),
                    Spacer(),
                    Icon(FluentIcons.calendar_12_filled)
                  ],
                ),
                onShowPicker: (context, current) async {
                  return startTime =
                      await getTime(context: context, currentValue: current);
                },
              ),
              CustomBasicDateTimeField(
                valid: (value) => value == null
                    ? "Please select time for end the Reservation"
                    : null,
                initialValue: currentReservation.endTime,
                txt:
                    'Enter The (date & time) that you will end reserve this device at :',
                label: Row(
                  children: [
                    Text('End Date & Time'),
                    Spacer(),
                    Icon(FluentIcons.calendar_12_filled)
                  ],
                ),
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
        TextButton(
          onPressed: () async {
            if ((nameController.text.isNotEmpty) &&
                (!checkIfDateConflict(
                    reservationID: myHiveService.devices[deviceIndex]
                        .reservations[reservationIndex].reservationID,
                    context: context,
                    deviceIndex: deviceIndex,
                    endTime: endTime,
                    startTime: startTime))) {
              await myReservationService.editReservation(
                  newReservation: Reservation(
                      remainingTime: endTime.difference(startTime).inSeconds,
                      reservationID: myHiveService.devices[deviceIndex]
                          .reservations[reservationIndex].reservationID,
                      customerName: nameController.text,
                      startTime: startTime,
                      endTime: endTime),
                  reservationIndex: reservationIndex,
                  deviceId:  myHiveService.devices[deviceIndex].id);
              showCustomSnackBar(context: context, txt: " Reservation Edited ");
              if (notDoublePop) {
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
                Navigator.pop(context);
              }
            }
          },
          child: const Text('Confirm Reservation',
              style: TextStyle(color: Colors.green)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          // Close dialog without canceling reservation
          child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}

// Usage function
void showEditReservationDialog({
  required BuildContext context,
  required int deviceIndex,
  required int reservationIndex,
  required bool notDoublePop,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return EditReservationDialog(
        deviceIndex: deviceIndex,
        reservationIndex: reservationIndex,
        notDoublePop: notDoublePop,
      );
    },
  );
}
