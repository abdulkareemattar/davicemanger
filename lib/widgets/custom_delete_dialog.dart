import 'package:flutter/material.dart';

import '../services/hive_service.dart';

void showDeleteConfirmationDialog(
    BuildContext context, HiveService hiveService, int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this device?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () {
              hiveService.deleteDevice(index: index);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}