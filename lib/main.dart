import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/providers/bottom_navbar_provider.dart';
import 'package:untitled8/services/hive_service.dart';
import 'package:untitled8/services/reservation_service.dart';

import 'models/hive_models/device_type_enums.dart';
import 'models/hive_models/devices.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // تسجيل TypeAdapters لمرة واحدة
  if (!Hive.isAdapterRegistered(MyDeviceAdapter().typeId)) {
    Hive.registerAdapter(MyDeviceAdapter());
  }
  if (!Hive.isAdapterRegistered(DeviceTypesEnumsAdapter().typeId)) {
    Hive.registerAdapter(DeviceTypesEnumsAdapter());
  }

  // تهيئة HiveService
  final hiveService = HiveService();
  await hiveService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => hiveService),
        ChangeNotifierProvider(create: (_) => BottomNavbarProvider()),
        ChangeNotifierProvider(create: (_) => ReservationService(hiveService)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
    );
    return MaterialApp(
      theme: ThemeData.dark(),
      darkTheme: ThemeData.dark(),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
