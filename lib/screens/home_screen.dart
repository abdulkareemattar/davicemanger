import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/screens/data_screen.dart';
import 'package:untitled8/widgets/custom_floatingActionButton.dart';

import '../services/hive_service.dart';
import '../widgets/custom_bottomsheet.dart';
import 'add_devices.dart';
import 'noData_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final myHiveService = Provider.of<HiveService>(context);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 4,
              title: Text(
                'Gaming Area',
                style: TextStyle(
                    shadows: const [
                      BoxShadow(offset: Offset(2, 1), color: Colors.black)
                    ],
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                    color: Colors.white),
              ),
              centerTitle: true,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.amber,
                      Colors.green,
                    ],
                  ),
                ),
              ),
            ),
            body: (!myHiveService.isInitialized)
                ? const Scaffold(
                    body: Center(child: CircularProgressIndicator()))
                : (myHiveService.devices.isEmpty)
                    ? const NoDataScreen()
                    : const DataScreen(),
            floatingActionButton: MyFloatingActionButton(
                onpressed: () => openBottomSheet(context, AddDeviceForm())));
      },
    );
  }
}
