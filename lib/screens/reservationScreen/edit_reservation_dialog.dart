import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/Functions/show_snackbar.dart';
import 'package:untitled8/services/hive_service.dart';
import 'package:untitled8/widgets/custom_textformfield.dart';

import '../../Functions/time&date_picker.dart';
import '../../models/hive_models/reservation_model.dart';
import '../../services/reservation_service.dart';
import '../../widgets/custom_confirmation_dialog.dart';
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
        Provider.of<ReservationService>(context, listen: true);
    DateTime? startTime = myHiveService
        .devices[deviceIndex].reservations![reservationIndex].startTime;
    DateTime? endTime = myHiveService
        .devices[deviceIndex].reservations![reservationIndex].endTime;
    TextEditingController nameController = TextEditingController(
      text: myHiveService.devices[deviceIndex].customerName ?? '',
    );

    return AlertDialog(
      title: Text(
          'Edit reservation for ${myHiveService.devices[deviceIndex].name} device'),
      content: _buildDialogContent(
          context: context,
          nameController: nameController,
          startTime: startTime,
          endTime: endTime,
          index: deviceIndex,
          myHiveService: myHiveService),
      actions: _buildDialogActions(
          context: context,
          nameController: nameController,
          startTime: startTime,
          endTime: endTime,
          deviceIndex: deviceIndex,
          myReservationService: myReservationService),
    );
  }

  Widget _buildDialogContent(
      {required BuildContext context,
      required TextEditingController nameController,
      DateTime? startTime,
      DateTime? endTime,
      required int index,
      required HiveService myHiveService}) {
    return Padding(
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
                  ? "Please select time for start the Reservation"
                  : null,
              initialValue: Provider.of<HiveService>(context, listen: false)
                  .devices[deviceIndex]
                  .reservations![reservationIndex]
                  .startTime,
              txt:
                  'Enter The (date & time) that you will reserve this device at :',
              label: 'Start Date & Time',
              onShowPicker: (context, current) async {
                return startTime =
                    await getTime(context: context, currentValue: current);
              },
            ),
            CustomBasicDateTimeField(
              valid: (value) => value == null
                  ? "Please select time for end the Reservation"
                  : null,
              initialValue: Provider.of<HiveService>(context, listen: false)
                  .devices[index]
                  .reservations![reservationIndex]
                  .endTime,
              txt:
                  'Enter The (date & time) that you will end reserve this device at :',
              label: 'End Date & Time',
              onShowPicker: (context, current) async {
                return startTime =
                    await getTime(context: context, currentValue: current);
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDialogActions(
      {required BuildContext context,
      required TextEditingController nameController,
      DateTime? startTime,
      DateTime? endTime,
      required int deviceIndex,
      required ReservationService myReservationService}) {
    return [
      SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  showCustomSnackBar(
                      context: context,
                      txt:
                          "Start Reservation: device name : ${deviceIndex}, startTime=$startTime, endTime=$endTime, name=${nameController.text}");
                  myReservationService.startReservation(
                    context: context,
                    deviceIndex: deviceIndex,
                    reservation: Reservation(
                        startTime: startTime!,
                        endTime: endTime!,
                        customerName: nameController.text),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Start Reservation',
                  style: TextStyle(color: Colors.green)),
            ),
            TextButton(
              onPressed: () {
                showCancellationConfirmationDialog(
                    context: context,
                    myReservationService: myReservationService,
                    deviceIndex: deviceIndex,
                    reservationIndex: reservationIndex);
              },
              child: const Text('Cancel Reservation',
                  style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              // Close dialog without canceling reservation
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    ];
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
