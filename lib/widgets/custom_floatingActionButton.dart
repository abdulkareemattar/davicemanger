import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyFloatingActionButton extends StatelessWidget {
  final VoidCallback onpressed;

  const MyFloatingActionButton({super.key, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.purple,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black, offset: Offset(5, 5), blurRadius: 5)
          ]),
      child: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: onpressed,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: const Icon(
          FontAwesomeIcons.plus,
          color: Colors.white,
          shadows: [BoxShadow(color: Colors.black, offset: Offset(1, 1))],
        ),
      ),
    );
  }
}
