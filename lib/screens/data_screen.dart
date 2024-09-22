import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../Functions/get_device_icon.dart';
import '../services/hive_service.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_delete_dialog.dart';
import '../widgets/custom_bottomsheet.dart';
import 'edit_device.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hiveService = Provider.of<HiveService>(context);

    return Column(children: [
      Container(
          color: Colors.transparent,
          width: double.infinity,
          height: 50,
          child: Padding(
            padding: EdgeInsets.only(
              top: 10.h,
              left: 20.w,
            ),
            child: Text(
              'My Devices :',
              style: TextStyle(
                  shadows: const[
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 1,
                        offset: Offset(1, 1))
                  ],
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber[700]),
            ),
          )),
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(bottom: 60.h, left: 16.w, right: 16.w),
          child: ListView.builder(
            itemCount: hiveService.devices.length,
            itemBuilder: (context, index) {
              return Slidable(
                key: ValueKey(hiveService.devices[index].ID),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        showDeleteConfirmationDialog(
                            context, hiveService, index);
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
                            index: index,
                          )),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      icon: FontAwesomeIcons.penToSquare,
                      label: 'Edit',
                    ),
                  ],
                ),
                child: CustomCard(
                  isReserved: hiveService.devices[index].reserved,
                  index: index,
                  leading: getDeviceIcon(type: hiveService.devices[index].type)
                      as Widget,
                  title: Text(hiveService.devices[index].name),
                  subtitle:
                      Text('${hiveService.devices[index].price} per hour'),
                  color: (hiveService.devices[index].reserved == false)
                      ? Colors.red
                      : Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  shadowColor: Colors.grey.withOpacity(0.5),
                ),
              );
            },
          ),
        ),
      ),
    ]);
  }
}
