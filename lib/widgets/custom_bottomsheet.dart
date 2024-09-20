import 'package:flutter/material.dart';

void openBottomSheet(BuildContext context, Widget wid) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: wid,
        );
      });
}