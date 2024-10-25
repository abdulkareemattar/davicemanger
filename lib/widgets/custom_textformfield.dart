import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    this.onChanged,
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
  final ValueChanged<String>? onChanged;
  FormFieldValidator? validate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: EdgeInsets.all(20.sp),
          child: TextFormField(
            onChanged: onChanged,
            controller: controller,
            decoration: InputDecoration(
              labelStyle: const TextStyle(
                color: Colors.green,
                fontSize: 20,
              ),hintText: txt,
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
