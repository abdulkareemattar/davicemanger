import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/services/hive_service.dart';
import 'package:untitled8/widgets/custom_textformfield.dart';

import '../../Functions/time&date_picker.dart';
import '../../services/reservation_service.dart';
import '../../widgets/custom_confirmation_dialog.dart';
import '../../widgets/custom_datetime_picker_formfield.dart';

class EditReservationDialog extends StatelessWidget {
  final int index;
  final bool notDoublePop;

  const EditReservationDialog({
    super.key,
    required this.index,
    required this.notDoublePop,
  });

  @override
  Widget build(BuildContext context) {
    final myHiveService = Provider.of<HiveService>(context, listen: true);
    final myReservationService =
        Provider.of<ReservationService>(context, listen: true);
    DateTime? startTime = myHiveService.devices[index].startTime;
    DateTime? endTime = myHiveService.devices[index].endTime;
    TextEditingController nameController = TextEditingController(
      text: myHiveService.devices[index].customerName ?? '',
    );

    return AlertDialog(
      title: Text(
          'Edit reservation for ${myHiveService.devices[index].name} device'),
      content: _buildDialogContent(
          context: context,
          nameController: nameController,
          startTime: startTime,
          endTime: endTime,
          index: index,
          myHiveService: myHiveService),
      actions: _buildDialogActions(
          context: context,
          nameController: nameController,
          startTime: startTime,
          endTime: endTime,
          index: index,
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
                  .devices[index]
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
                  .startTime,
              txt:
                  'Enter The (date & time) that you will reserve this device at :',
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
      required int index,
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
                  print(
                      "Start Reservation: index=$index, startTime=$startTime, endTime=$endTime, name=${nameController.text}");
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
                  style: TextStyle(color: Colors.green)),
            ),
            TextButton(
              onPressed: () {
                showCancellationConfirmationDialog(
                    context, myReservationService, index);
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
  required int index,
  required bool notDoublePop,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return EditReservationDialog(index: index, notDoublePop: notDoublePop);
    },
  );
}
