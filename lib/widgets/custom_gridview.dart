import 'package:flutter/material.dart';
class CustomGridview extends StatelessWidget {
  final int? itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;

  const CustomGridview({super.key, this.itemCount, required this.itemBuilder});
  @override
  Widget build(BuildContext context) {

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // عدد الأعمدة
        childAspectRatio: 0.4, // نسبة العرض إلى الارتفاع لكل عنصر
        crossAxisSpacing: 10, // المسافة بين الأعمدة
        mainAxisSpacing: 10, // المسافة بين الصفوف
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}

