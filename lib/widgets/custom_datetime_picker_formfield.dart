import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../Functions/get_custom_textstyle.dart';

class CustomBasicDateTimeField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final String txt;
  final Widget label;
  final DateTime? initialValue;
  final Future<DateTime?> Function(BuildContext, DateTime?) onShowPicker;
  final FormFieldValidator<DateTime>? valid;

  CustomBasicDateTimeField(
      {super.key,
      required this.txt,
      required this.label,
      required this.onShowPicker,
      this.initialValue,
      this.valid});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
          ),
          Padding(
            padding:  EdgeInsets.all(10.sp),
            child: DateTimeField(
                decoration: InputDecoration(
                  hintText: txt,
                  label: label,
                  labelStyle: getTextStyle(
                      type: FontTypeEnum.headLineSmall, color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.purple, width: 4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 3,color: Colors.purple),
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
      ),
    );
  }
}
