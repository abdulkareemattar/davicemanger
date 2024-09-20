import 'package:flutter/material.dart';

void showDialogEndReservation({required BuildContext context}) {
  showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
          title: Text('Reservation this device'),
          content: Text('You want to end the reservation for this device ?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('End', style: TextStyle(color: Colors.orange),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey),
                )),
          ],
        ),
  );
}
