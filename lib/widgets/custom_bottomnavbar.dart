import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // تأكد من استيراد مكتبة ScreenUtil إذا كنت تستخدمها
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyBottomNavigationBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h, left: 50, right: 50),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: BottomNavigationBar(
                enableFeedback: true,
                selectedLabelStyle: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.purpleAccent,
                ),
                mouseCursor: MouseCursor.defer,
                backgroundColor: Colors.transparent,
                fixedColor: Colors.white,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
                iconSize: 24.sp,
                currentIndex: currentIndex,
                type: BottomNavigationBarType.fixed,
                onTap: onTap,
                items: [
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom: 3.h),
                      child: Icon(
                        FontAwesomeIcons.house,
                        color: Colors.purpleAccent,
                        shadows: [
                          Shadow(color: Colors.black, offset: Offset(1, 1))
                        ],
                      ),
                    ),
                    label: 'Home',
                    activeIcon: Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Icon(
                        FontAwesomeIcons.houseChimneyWindow,
                        color: Colors.purpleAccent,
                        shadows: [
                          Shadow(color: Colors.black, offset: Offset(1, 1))
                        ],
                      ),
                    ),
                  ),
                  BottomNavigationBarItem(
                    activeIcon: Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Icon(
                        FontAwesomeIcons.circleDot,
                        color: Colors.green,
                        shadows: [
                          Shadow(color: Colors.black, offset: Offset(1, 1))
                        ],
                      ),
                    ),
                    icon: Padding(
                      padding: EdgeInsets.only(bottom: 3.h),
                      child: Icon(
                        FontAwesomeIcons.circle,
                        color: Colors.green,
                        shadows: [
                          Shadow(color: Colors.black, offset: Offset(1, 1))
                        ],
                      ),
                    ),
                    label: 'Active',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: const Icon(
                        FontAwesomeIcons.solidCalendar,
                        color: Colors.yellow,
                        shadows: [
                          Shadow(color: Colors.black, offset: Offset(1, 1))
                        ],
                      ),
                    ),
                    label: 'Reservation',
                    activeIcon: Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Icon(
                        FontAwesomeIcons.solidCalendarDays,
                        color: Colors.yellow,
                        shadows: [
                          Shadow(color: Colors.black, offset: Offset(1, 1))
                        ],
                      ),
                    ),
                  ),
                  BottomNavigationBarItem(
                    activeIcon: Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Icon(
                        Icons.settings_suggest,
                        color: Colors.red,
                        shadows: [
                          Shadow(color: Colors.black, offset: Offset(1, 1))
                        ],
                      ),
                    ),
                    icon: Padding(
                      padding: EdgeInsets.only(bottom: 3.h),
                      child: Icon(
                        Icons.settings,
                        color: Colors.red,
                        shadows: [
                          Shadow(color: Colors.black, offset: Offset(1, 1))
                        ],
                      ),
                    ),
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
