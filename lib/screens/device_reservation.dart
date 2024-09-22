import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled8/widgets/custom_textformfield.dart';

import '../widgets/custom_datetime_picker_formfield.dart';

void showDialogReservation({required BuildContext context}) {
  TextEditingController nameController = TextEditingController();
  DateTime? date;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Reserve this device'),
      content: Padding(
        padding:  EdgeInsets.only( top: 20.0.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFormField(
              txt: "Enter the customer name :",
              controller: nameController,
              label: 'Customer Name',
              keyboard: TextInputType.text,
            ),
            BasicDateTimeField(
                txt:
                    'Enter The (date & time) that you will reserve this device at :',
                label: 'Date & Time',
                onShowPicker: (context, currentValue) async {
                   date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.combine(date!, time);
                  } else {
                    return currentValue;
                  }
                }),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Start Reservation',
            style: TextStyle(color: Colors.green),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    ),
  );
}
