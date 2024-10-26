import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/services/hive_service.dart';
import 'package:untitled8/widgets/custom_textformfield.dart';

import '../Functions/time&date_picker.dart';
import '../widgets/custom_datetime_picker_formfield.dart';

void showDeviceReservationDialog(
    {required BuildContext context,
    required int index,
    required bool isFromHomePage}) {
  final formKey = GlobalKey<FormState>();
  final myHiveService = Provider.of<HiveService>(context, listen: false);
  DateTime? time;
  TextEditingController nameController =
      TextEditingController(text: myHiveService.devices[index].customerName);

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Reserve ${myHiveService.devices[index].name} device'),
        content: Padding(
          padding: EdgeInsets.only(top: 20.0.h),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  validate: (value) => (value.isEmpty)
                      ? "Please Enter Customer's username"
                      : null,
                  onChanged: (value) {
                    myHiveService.customerName = value;
                  },
                  txt: "Enter the customer name :",
                  controller: nameController,
                  label: 'Customer Name',
                  keyboard: TextInputType.text,
                ),
                BasicDateTimeField(
                  valid: (value) => (value == null)
                      ? "Please select time for the Reservation"
                      : null,
                  txt:
                      'Enter The (date & time) that you will reserve this device at :',
                  label: 'Date & Time',
                  onShowPicker: (context, current) async {
                    return time =
                        await getTime(context: context, currentValue: current);
                  },
                  initialValue: null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                myHiveService.reservation(
                    newValue: true,
                    isNewDevice: false,
                    index: index,
                    customerName: nameController.text,
                    time: time);
                (isFromHomePage)
                    ? {Navigator.pop(context)}
                    : {
                        for (int i = 0; i < 2; i++) {Navigator.pop(context)},
                      };
              }
            },
            child: const Text(
              'Start Reservation',
              style: TextStyle(color: Colors.green),
            ),
          ),
          TextButton(
            onPressed: () => {
              (isFromHomePage)
                  ? {Navigator.pop(context)}
                  : {
                      for (int i = 0; i < 2; i++) {Navigator.pop(context)},
                    },
              myHiveService.reservation(
                  newValue: false, isNewDevice: false, index: index)
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      );
    },
  );
}
