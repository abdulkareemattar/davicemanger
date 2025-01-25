import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/hive_service.dart';

class ActiveDeviceScreen extends StatelessWidget {
  const ActiveDeviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hiveService = Provider.of<HiveService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Active Devices"),
      ),
      body: ListView.builder(
        itemCount: hiveService.activeDevices.length,
        itemBuilder: (context, index) {
          final device = hiveService.activeDevices[index];
          return ListTile(
            title: Text(device.name),
          );
        },
      ),
    );
  }
}
