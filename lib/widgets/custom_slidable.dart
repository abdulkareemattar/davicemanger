import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../screens/addScreen/edit_device_bottomsheet.dart';
import '../services/hive_service.dart';
import 'custom_bottomsheet.dart';
import 'custom_delete_dialog.dart';

class CustomSlidable extends StatelessWidget {

  const CustomSlidable({super.key, required this.keyY, required this.index, required this.child});
final Key keyY;
final int index;
final Widget child;

  @override
  Widget build(BuildContext context,) {
    final myHiveService = Provider.of<HiveService>(context);
    return Slidable(
        key:keyY,closeOnScroll: true,
    startActionPane: ActionPane(
    motion: const ScrollMotion(),
    children: [
    SlidableAction(
    onPressed: (context) {
    showDeleteConfirmationDialog(
    context, myHiveService, index);
    },
    backgroundColor: const Color(0xFFFE4A49),
    foregroundColor: Colors.white,
    icon: FontAwesomeIcons.trash,
    label: 'Delete',
    ),
    ],
    ),
    endActionPane: ActionPane(
    motion: const ScrollMotion(),
    children: [
    SlidableAction(
    onPressed: (context) => openBottomSheet(
    context,
    EditDevice(
    deviceIndex: index,
    )),
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
    icon: FontAwesomeIcons.penToSquare,
    label: 'Edit',
    ),
    ],
    ),
    child:child);
  }
}
