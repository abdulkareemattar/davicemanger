import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/services/hive_service.dart';
import 'package:untitled8/widgets/custom_textformfield.dart';

import '../Functions/time&date_picker.dart';
import '../widgets/custom_datetime_picker_formfield.dart';

void showEditReservationDialog(
    {required BuildContext context,
    required int index,
    required bool notDoublePop}) {
  final formKey = GlobalKey<FormState>();
  final myHiveService = Provider.of<HiveService>(context, listen: false);
  DateTime? time = myHiveService.devices[index].selectedTime;
  TextEditingController nameController =
      TextEditingController(text: (myHiveService.devices[index].customerName));
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
            'Edit reservation for ${myHiveService.devices[index].name} device'),
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
                  txt: "Enter the customer name :",
                  controller: nameController,
                  label: 'Customer Name',
                  keyboard: TextInputType.text,
                ),
                BasicDateTimeField(
                  valid: (value) => (value == null)
                      ? "Please select time for the Reservation"
                      : null,
                  initialValue: myHiveService.devices[index].selectedTime,
                  txt:
                      'Enter The (date & time) that you will reserve this device at :',
                  label: 'Date & Time',
                  onShowPicker: (context, current) async {
                    return time =
                        await getTime(context: context, currentValue: current);
                  },
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
                    isNewDevice: false,
                    index: index,
                    customerName: nameController.text,
                    time: time,
                    newValue: myHiveService.devices[index].reserved);
                (notDoublePop)
                    ? {Navigator.pop(context)}
                    : {
                        for (int i = 0; i < 2; i++) {Navigator.pop(context)},
                      };
              }
            },
            child: const Text(
              'Edit Reservation',
              style: TextStyle(color: Colors.green),
            ),
          ),
          TextButton(
            onPressed: () => {
              (notDoublePop)
                  ? {Navigator.pop(context)}
                  : {
                      for (int i = 0; i < 2; i++) {Navigator.pop(context)},
                    },
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
