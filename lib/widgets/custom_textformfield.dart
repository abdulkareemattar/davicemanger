import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    this.validate,
    required this.controller,
    required this.label,
    required this.keyboard,
    required this.txt,
  });

  final TextEditingController controller;
  final TextInputType keyboard;
  final String label;
  final String txt;
  FormFieldValidator? validate;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(txt),
        ),
        Padding(
          padding:  EdgeInsets.all(20.sp),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelStyle: const TextStyle(
                color: Colors.green,
                fontSize:  20,
              ),
              labelText: label,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green, width: 3),
                borderRadius: BorderRadius.circular(8),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green, width: 3),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: validate,
            keyboardType: keyboard,
          ),
        ),
      ],
    );
  }
}
