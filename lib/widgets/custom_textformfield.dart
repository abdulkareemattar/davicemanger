import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    this.validate,
    required this.controller,
    required this.label,
    required this.keyboard,
  });

  final TextEditingController controller;
  final TextInputType keyboard;
  final String label;
  FormFieldValidator? validate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelStyle: const TextStyle(
            color: Colors.green,
            fontSize: 20,
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
    );
  }
}
