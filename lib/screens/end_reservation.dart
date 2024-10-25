import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../Functions/time&date_picker.dart';
import '../services/hive_service.dart';
import '../widgets/customCounter.dart';
import '../widgets/custom_datetime_picker_formfield.dart';
import '../widgets/custom_textformfield.dart';

void showDialogEndReservation({
  required BuildContext context,
  required int index,
}) {
  final myHiveService = Provider.of<HiveService>(context, listen: false);
  DateTime? time;
  TextEditingController nameController =
      TextEditingController(text: (myHiveService.devices[index].customerName));

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Reservation ${myHiveService.devices[index].name} device'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('You want to end the reservation for this device ?'),
          CustomTextFormField(
            onChanged: (value) {
              myHiveService.customerName = value;
            },
            txt: "Enter the customer name :",
            controller: nameController,
            label: 'Customer Name',
            keyboard: TextInputType.text,
          ),
          BasicDateTimeField(
            txt:
                'Enter The (date & time) that you will reserve this device at :',
            label: 'Date & Time',
            onShowPicker: (context, current) async {
              return time =
                  (myHiveService.devices[index].selectedTime == null)
                      ? await getTime(context: context, currentValue: current)
                      : myHiveService.devices[index].selectedTime;
            },
            initialValue: myHiveService.devices[index].selectedTime,
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomCounter(
              colonColor: Colors.orange,
              selectedTime: myHiveService.devices[index].selectedTime!,
              enableDescriptions: true,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            myHiveService.reservation(
                index: index, isNewDevice: false, newValue: false);
            Navigator.pop(context);
          },
          child: const Text(
            'End the reservation',
            style: TextStyle(color: Colors.orange),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    ),
  );
}
