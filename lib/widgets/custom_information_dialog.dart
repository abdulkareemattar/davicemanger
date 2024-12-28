import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showCustomInfDialog({
  required BuildContext context,
  required String txt,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text(
          'Alert !',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 20.sp),
        ),
        content: Text(txt,style: TextStyle(fontSize: 16.sp),),
        actions: [
          TextButton(
            child: const Text('OK',style: TextStyle(color: Colors.purple),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
