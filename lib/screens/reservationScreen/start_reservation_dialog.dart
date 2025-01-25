import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/Functions/show_snackbar.dart';
import 'package:untitled8/services/hive_service.dart';
import 'package:untitled8/widgets/custom_textformfield.dart';
import 'package:uuid/uuid.dart';

import '../../Functions/check_date_conflects.dart';
import '../../Functions/time&date_picker.dart';
import '../../models/hive_models/reservation_model.dart';
import '../../services/reservation_service.dart';
import '../../widgets/custom_datetime_picker_formfield.dart';

class AddReservationDialog extends StatelessWidget {
  final String deviceId;
  final HiveService hiveService;
  final bool notDoublePop;
  final _formKey = GlobalKey<FormState>();

  AddReservationDialog({
    super.key,
    required this.notDoublePop,
    required this.deviceId,
    required this.hiveService,
  });

  @override
  Widget build(BuildContext context) {
    final originalDeviceIndex = hiveService.devices.indexWhere((d) => d.id == deviceId);
    Uuid uuid = const Uuid();
    final myHiveService = Provider.of<HiveService>(context, listen: false);
    final myReservationService = Provider.of<ReservationService>(context, listen: false);
    DateTime? startTime;
    DateTime? endTime;
    final TextEditingController nameController = TextEditingController();

    return AlertDialog(
      title: Text(
          'Start reservation for ${myHiveService.devices[originalDeviceIndex].name} device'),
      content: Padding(
        padding: EdgeInsets.only(top: 10.0.h),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFormField(
                validate: (value) =>
                value!.isEmpty ? "Please Enter Customer's Username" : null,
                txt: "Enter the Customer Name :",
                controller: nameController,
                label: Row(
                  children: [
                    Text('Customer Name'),
                    Spacer(),
                    Icon(FluentIcons.person_add_32_regular)
                  ],
                ),
                keyboard: TextInputType.text,
              ),
              CustomBasicDateTimeField(
                valid: (value) => value == null
                    ? "Please select start time for the Reservation"
                    : null,
                txt:
                'Enter The (date & time) that you will start reserve this device at :',
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
                    ? "Please select end time for the Reservation"
                    : null,
                txt:
                'Enter The (date & time) that you will end reserve for this device at :',
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
        SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      !checkIfDateConflict(
                        reservationID: null,
                        context: context,
                        deviceIndex: originalDeviceIndex,
                        endTime: endTime!,
                        startTime: startTime!,
                      )) {
                    showCustomSnackBar(
                        context: context,
                        txt:
                        "Start Reservation: device name :${myHiveService.devices[originalDeviceIndex].name}, startTime=$startTime,endTime=$endTime, Customer Name=${nameController.text}");
                    myReservationService.startReservation(
                      deviceId:
                      myHiveService.devices[originalDeviceIndex].id,
                      reservation: Reservation(
                        remainingTime:
                        endTime!.difference(startTime!).inSeconds,
                        reservationID: uuid.v4(),
                        startTime: startTime!,
                        endTime: endTime!,
                        customerName: nameController.text,
                      ),
                    );
                    if (notDoublePop) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text(
                  'Start Reservation',
                  style: TextStyle(color: Colors.purple),
                ),
              ),
              TextButton(
                onPressed: () => {Navigator.pop(context)},
                // Close dialog without canceling reservation
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Usage function
void showAddReservationDialog({
  required BuildContext context,
  required String deviceId,
  required HiveService hiveService,
  bool notDoublePop = true,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AddReservationDialog(
        hiveService: hiveService,
        deviceId: deviceId,
        notDoublePop: notDoublePop,
      );
    },
  );
}
