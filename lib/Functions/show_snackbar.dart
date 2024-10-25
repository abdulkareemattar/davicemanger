import 'package:flutter/material.dart';

void showCustomSnackBar({required BuildContext context, required String txt}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.amberAccent,
      content: Text(
        txt,
        style: const TextStyle(color: Colors.black),
      ),
    ),
  );
}
