import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/services/hive_service.dart';
import 'package:untitled8/widgets/custom_card.dart';
import 'add_devices.dart';
import 'edit_device.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hiveService = Provider.of<HiveService>(context);
    if (!hiveService.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Devices'),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: hiveService.devices.length,
              itemBuilder: (context, index) {
                return Slidable(
                  key: ValueKey(hiveService.devices[index].ID),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          _showDeleteConfirmationDialog(context, hiveService, index);                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => _openBottomSheet(
                            context,
                            EditDevice(
                              index: index,
                            )),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                    ],
                  ),
                  child: CustomCard(
                    leading: const Icon(Icons.laptop),
                    title: Text(hiveService.devices[index].name),
                    subtitle: Text('${hiveService.devices[index].price} per hour'),
                    color: Colors.green,
                  ),
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _openBottomSheet(context, AddDevice()),
            child: const Icon(Icons.add),
            backgroundColor: Colors.green,
          ),
        );
      },
    );
  }
  void _showDeleteConfirmationDialog(BuildContext context, HiveService hiveService, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this device?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
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


  _openBottomSheet(BuildContext context, Widget wid) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) => BottomSheet(
        enableDrag: true,
        showDragHandle: true,
        onClosing: () {},
        builder: (context) => Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: wid,
        ),
      ),
    );
  }
}
