import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';

Future<DateTime> getTime ({context, currentValue}) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime( 1900),
      initialDate: DateTime.now(),
      lastDate: DateTime( 2100),
    );
    if (date != null) {
      final time = await showTimePicker(context: context,
        initialTime: TimeOfDay.fromDateTime(
            currentValue ?? DateTime.now()),
      );
      return DateTimeField.combine(date, time);
    } else {
      return currentValue;
    }
  }