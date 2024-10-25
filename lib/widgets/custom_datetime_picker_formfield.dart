import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class BasicDateTimeField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final String txt;
  final String label;
  final DateTime? initialValue;
  final Future<DateTime?> Function(BuildContext, DateTime?) onShowPicker;
  final FormFieldValidator<DateTime>? valid;

  BasicDateTimeField(
      {super.key,
      required this.txt,
      required this.label,
      required this.onShowPicker,
      required this.initialValue,
      this.valid});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: DateTimeField(
              decoration: InputDecoration(hintText: txt,
                label: Text(label),
                labelStyle: const TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 3),
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 3),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              format: format,
              initialValue: initialValue,
              validator: valid,
              onShowPicker: (context, current) async {
                return await onShowPicker(context, current);
              }),
        ),
      ],
    );
  }
}
