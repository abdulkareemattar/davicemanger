import 'package:flutter/material.dart';
import 'package:untitled8/Functions/get_custom_textstyle.dart';

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
            side: const BorderSide(color: Colors.blueGrey, width: 2)),
        onPressed: onpressed,
        child: Text(
          txt,
          style: getTextStyle(type: FontTypeEnum.customHeadLine, color: Colors.white,size: 14),
        ));
  }
}
