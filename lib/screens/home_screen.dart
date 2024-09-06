import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/services/hive_service.dart';
import 'package:untitled8/widgets/custom_card.dart';
import 'add_devices.dart';
import 'edit_device.dart';

class HomeScreen extends StatelessWidget {
late int Index;
  @override
  Widget build(BuildContext context) {
    final MyHiveService = Provider.of<HiveService>(context);
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
              itemCount: MyHiveService.devices.length,
              itemBuilder: (context, index) {
                return Slidable(
                  key: ValueKey(MyHiveService.devices[index].ID),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                            MyHiveService.deleteDevice(index: index);},
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
                        onPressed: (context) =>_openBottomSheet(context,EditDevice(index: index,)),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                    ],
                  ),
                  child: CustomCard(
                    leading: const Icon(Icons.laptop),
                    title: const Text('Laptop'),
                    subtitle: const Text('6800 SYP per hour'),
                    color: Colors.green,
                  ),
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _openBottomSheet(context,AddDevice()),
            child: const Icon(Icons.add),
            backgroundColor: Colors.green,
          ),
        );
      },
    );
  }
  _openBottomSheet(BuildContext context, Widget wid) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) =>
          BottomSheet(
            enableDrag: true,
            showDragHandle: true,
            onClosing: () {},
            builder: (context) =>
                Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: wid,
                ),
          ),
    );
  }

}


