import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/models/hive_models/devices.dart';

import '../../Functions/time&date_picker.dart';
import '../../services/reservation_service.dart';
import '../../widgets/customCounter.dart';
import '../../widgets/custom_datetime_picker_formfield.dart';
import '../../widgets/custom_textformfield.dart';

void showDialogEndReservation(
    {required BuildContext context,
    required int index,
    required MyDevice myDevice}) {
  TextEditingController nameController =
      TextEditingController(text: (myDevice.customerName));
  final myReservationService =
      Provider.of<ReservationService>(context, listen: false);


  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Reservation ${myDevice.name} device'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('You want to end the reservation for this device ?'),
          CustomTextFormField(
            onChanged: (value) {
              myDevice.customerName = value;
            },
            txt: "Enter the customer name :",
            controller: nameController,
            label: 'Customer Name',
            keyboard: TextInputType.text,
          ),
          CustomBasicDateTimeField(
            txt:
                'Enter The (date & time) that you will start reserve this device at :',
            label: 'Start Date & Time',
            onShowPicker: (context, current) async {
              return (myDevice.startTime == null)
                  ? await getTime(context: context, currentValue: current)
                  : myDevice.startTime;
            },
            initialValue: myDevice.startTime,
          ),
          CustomBasicDateTimeField(
            txt:
                'Enter The (date & time) that you will end reserve this device at :',
            label: 'End Date & Time',
            onShowPicker: (context, current) async {
              return (myDevice.endTime == null)
                  ? await getTime(context: context, currentValue: current)
                  : myDevice.endTime;
            },
            initialValue: myDevice.endTime,
          ),
          SizedBox(height: 20.h),
         /* Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomCounter(
              index: index,
              colonColor: Colors.orange,
              enableDescriptions: true,
            ),
          ),*/
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            myReservationService.cancelReservation(index);
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
