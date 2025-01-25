import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled8/Functions/get_custom_textstyle.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    this.onChanged,
    this.validate,
     this.controller,
    required this.label,
    required this.keyboard,
    required this.txt,
  });

  final TextEditingController ? controller;
  final TextInputType keyboard;
  final Widget label;
  final String txt;
  final ValueChanged<String>? onChanged;
  FormFieldValidator? validate;

  @override
  Widget build(BuildContext context) {
    return Expanded(flex: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10.sp),
            child: TextFormField(
              onChanged: onChanged,
              controller: controller,
              decoration: InputDecoration(
                labelStyle: getTextStyle(
                    type: FontTypeEnum.headLineSmall, color: Colors.white),
                hintText: txt,
                label: label,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.purple, width: 4),
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3,color: Colors.purple),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: validate,
              keyboardType: keyboard,
            ),
          ),
        ],
      ),
    );
  }
}
