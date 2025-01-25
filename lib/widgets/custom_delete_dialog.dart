import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void showDeleteConfirmationDialog(
    {required BuildContext context,
    required String deleteText,
    required void Function () onDeleteFun}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            Text(
              'Confirm Delete',
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp),
            ),
            Spacer(),
            Icon(
              FontAwesomeIcons.triangleExclamation,
              color: Colors.yellow,
            )
          ],
        ),
        content: Text(deleteText),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text(
              'Delete',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed:
              onDeleteFun
          ),
        ],
      );
    },
  );
}
