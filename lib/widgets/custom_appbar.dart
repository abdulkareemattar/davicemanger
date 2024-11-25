import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.purple
          ),
          child: AppBar(backgroundColor: Colors.transparent,
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
          ),
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}
