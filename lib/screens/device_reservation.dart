import 'package:flutter/material.dart';
import 'package:untitled8/widgets/custom_textformfield.dart';

import '../widgets/custom_datetime_picker_formfield.dart';

void showDialogReservation({required BuildContext context}) {
  TextEditingController nameController = TextEditingController();
  DateTime? selectedTime;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Reserve this device'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextFormField(
            controller: nameController,
            label: 'Customer Name',
            keyboard: TextInputType.text,
          ),
          BasicDateTimeField(),
          SizedBox(height: 20),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (selectedTime != null) {
              Navigator.pop(context);
            }
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
