import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:untitled8/widgets/custom_card.dart';

import '../data/devices.dart';
import '../function/functions.dart';
import 'add_devices.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List <MyDevice> devices = [];
  late Box box;

  Future<void> _loadDevices() async {
    devices = box.values.toList().cast<MyDevice>();
    setState(() {});
  }

  @override
  void initState() async {
    super.initState();
    var box = await Hive.openBox('myBox');
    await _loadDevices();
  }

  @override
  Widget build(BuildContext context) {
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
              itemCount: devices.length,
              itemBuilder: (context, index) {
                return Slidable(
                  key: ValueKey(devices[index]),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => delete(box:box,device: devices[index]),
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
                        onPressed: (context) => (){},
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
            onPressed: () =>
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: false,
                    builder: (BuildContext context) => AddDevices()),
            child: const Icon(Icons.add),
            backgroundColor: Colors.green,
          ),
        );
      },
    );
  }
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
                    padding: const EdgeInsets.all(20.0),
                    child: AddDevices(),
                  )));
}
