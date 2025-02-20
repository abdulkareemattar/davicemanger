import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/screens/reservationScreen/data_reservation_screen.dart';
import 'package:untitled8/screens/settings_screen.dart';
import 'package:untitled8/widgets/custom_floatingActionButton.dart';

import '../providers/bottom_navbar_provider.dart';
import '../services/hive_service.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_bottomnavbar.dart';
import '../widgets/custom_bottomsheet.dart';
import 'activeDevicesScreen/active_device_screen.dart';
import 'addScreen/add_devices_bottomhseet.dart';
import 'addScreen/devices_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final myHiveService = Provider.of<HiveService>(context, listen: false);
    final myBottomSheet =
        Provider.of<BottomNavbarProvider>(context, listen: true);
    PageController pageController = PageController();
    List<Widget> screens = const [
      MyDevicesScreen(),
      ActiveDeviceScreen(),
      DataReservationScreen(),
      SettingsScreen()
    ];
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Scaffold(
            appBar: const CustomAppbar(),
            body: (!myHiveService.isInitialized)
                ? const Scaffold(
                    body: Center(child: CircularProgressIndicator(color: Colors.purpleAccent,)))
                : PageView(
                    controller: pageController,
                    onPageChanged: (value) =>
                        myBottomSheet.changeCurINd(value: value),
                    children: screens,
                  ),
            floatingActionButton: MyFloatingActionButton(
                onpressed: () => openBottomSheet(context, AddDeviceForm())),
            bottomNavigationBar: MyBottomNavigationBar(
              onTap: (value) => pageController.jumpToPage(value),
              currentIndex: myBottomSheet.curInd,
            ));
      },
    );
  }
}
