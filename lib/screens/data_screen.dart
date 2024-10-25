import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/widgets/custom_button.dart';

import '../Functions/get_device_icon.dart';
import '../services/hive_service.dart';
import '../widgets/custom_bottomsheet.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_delete_dialog.dart';
import 'device_reservation.dart';
import 'edit_device.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final myHiveService = Provider.of<HiveService>(context);

    return Column(children: [
      Padding(
        padding: EdgeInsets.only(
          top: 10.h,
          left: 20.w,
          right: 20.w,
        ),
        child: SizedBox(
          height: 50.h,
          width: double.infinity,
          child: Row(
            children: [
              Text(
                'My Devices',
                style: TextStyle(
                    shadows: const [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 1,
                          offset: Offset(1, 1))
                    ],
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber[700]),
              ),
              const Spacer(),
              CustomButton(
                  onpressed: () => myHiveService.deleteAllDevices(),
                  txt: 'Clear All',
                  color: Colors.red)
            ],
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(bottom: 60.h, left: 16.w, right: 16.w),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // عدد الأعمدة
              childAspectRatio: 0.65, // نسبة العرض إلى الارتفاع لكل عنصر
              crossAxisSpacing: 10, // المسافة بين الأعمدة
              mainAxisSpacing: 10, // المسافة بين الصفوف
            ),
            itemCount: myHiveService.devices.length,
            itemBuilder: (context, index) {
              return Slidable(
                key: ValueKey(myHiveService.devices[index].ID),
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
                  id: myHiveService.devices[index].ID,
                  onTapOnTrailing: () {
                    myHiveService.reservation(
                        index: index,
                        isNewDevice: false,
                        newValue: !myHiveService.devices[index].reserved);
                    if (myHiveService.devices[index].reserved) {
                      showDeviceReservationDialog(
                          isFromHomePage: true, context: context, index: index);
                    }
                  },
                  isReserved: myHiveService.devices[index].reserved,
                  index: index,
                  leading:
                      getDeviceIcon(type: myHiveService.devices[index].type)!,
                  title: Text(
                    myHiveService.devices[index].name,
                    style: TextStyle(
                        shadows: const [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 1,
                              offset: Offset(1, 1))
                        ],
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: getDeviceIcon(type: myHiveService.devices[index].type)!.color),
                  ),
                  subtitle: Column(
                    children: [
                      Text(
                        '${myHiveService.devices[index].price} \$ ',
                        style: TextStyle(
                            shadows: const [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 1,
                                  offset: Offset(1, 1))
                            ],
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700]),
                      ),
                      Text(
                        'per hour',
                        style: TextStyle(
                            shadows: const [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 1,
                                  offset: Offset(1, 1))
                            ],
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700]),
                      ),
                    ],
                  ),
                  color: (!myHiveService.devices[index].reserved)
                      ? Colors.red
                      : Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(double.infinity),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ]);
  }
}
