import 'package:flutter/material.dart';
import 'package:untitled8/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen()),
  );
}
