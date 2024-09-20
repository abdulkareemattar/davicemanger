import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onpressed, required this.txt});

  final VoidCallback onpressed;
  final String txt;

  @override
  Widget build(
    BuildContext context,
  ) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            side: BorderSide(color: Colors.amber, width: 2)),
        onPressed: onpressed,
        child: Text(
          txt,
          style: TextStyle(color: Colors.white),
        ));
  }
}
