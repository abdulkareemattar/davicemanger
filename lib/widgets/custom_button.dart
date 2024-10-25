import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onpressed, required this.txt, required this.color});

  final VoidCallback onpressed;
  final String txt;
  final Color color;

  @override
  Widget build(
    BuildContext context,
  ) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            side: const BorderSide(color: Colors.amber, width: 2)),
        onPressed: onpressed,
        child: Text(
          txt,
          style: const TextStyle(color: Colors.white),
        ));
  }
}
