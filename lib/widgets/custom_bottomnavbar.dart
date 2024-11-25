import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // تأكد من استيراد مكتبة ScreenUtil إذا كنت تستخدمها
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyBottomNavigationBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 50, right: 50),
      child: Stack(
        alignment: Alignment.center,
        children: [

          ClipRRect(borderRadius: BorderRadius.circular(200),
            child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
              child: BottomNavigationBar(
                enableFeedback: true,
                selectedLabelStyle: TextStyle(
                  fontSize: 16.sp, // تأكد من استخدام ScreenUtil إذا كنت تستخدمه
                  color: Colors.white,
                ),
                mouseCursor: MouseCursor.defer,
                backgroundColor: Colors.transparent,
                fixedColor: Colors.white,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
                iconSize: 30,
                currentIndex: currentIndex,
                type: BottomNavigationBarType.fixed,
                onTap: onTap,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      FontAwesomeIcons.circlePlus,
                      color: Colors.green,
                      shadows: [
                        Shadow(color: Colors.black, offset: Offset(1, 1))
                      ],
                    ),
                    label: 'Add',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.gamepad,color: Colors.red, shadows: [
                      Shadow(color: Colors.black, offset: Offset(1, 1))
                    ],),
                    label: 'Active',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.calendar,color: Colors.yellow,
                      shadows: [
                        Shadow(color: Colors.black, offset: Offset(1, 1))
                      ],),
                    label: 'Reservation',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings,color: Colors.purple,
                      shadows: [
                        Shadow(color: Colors.black, offset: Offset(1, 1))
                      ],),
                    label: 'Settings',
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
