import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/screens/noData_screen.dart';

import '../../Functions/get_device_icon.dart';
import '../../services/hive_service.dart';
import '../../services/reservation_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_gridview.dart';
import '../../widgets/custom_slidable.dart';
import 'edit_reservation_dialog.dart';
import 'end_reservation_dialog.dart';

class ReservationDevices extends StatelessWidget {
  const ReservationDevices({super.key});

  @override
  Widget build(BuildContext context) {
    final myHiveService = Provider.of<HiveService>(context, listen: false);
    final myReservationService = Provider.of<ReservationService>(context);

    return myHiveService.reservedDevices.isEmpty
        ? const NoDataScreen()
        : Column(children: [
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
                      'My Reserved Devices',
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
                        txt: 'Stop All',
                        color: Colors.red)
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
                child: CustomGridview(
                  itemCount: myHiveService.reservedDevices.length,
                  itemBuilder: (context, index) {
                    return CustomSlidable(
                      keyY: Key(myHiveService.reservedDevices[index].id),
                      index: index,
                      child: CustomCard(
                        onTap: () => showDialogEndReservation(
                                context: context,
                                index: index,
                                myDevice: myHiveService.devices[index]),
                        device: myHiveService.reservedDevices[index],
                        id: myHiveService.reservedDevices[index].id,
                        onTapOnTrailing: () {
                          myReservationService.setReservation(
                              context: context,
                              index: index,
                              newValue: !myHiveService
                                  .reservedDevices[index].reserved);
                          if (myHiveService.reservedDevices[index].reserved) {
                            showEditReservationDialog(
                              context: context,
                              index: index,
                              notDoublePop: true,
                            );
                          }
                        },
                        isReserved:
                            myHiveService.reservedDevices[index].reserved,
                        index: index,
                        leading: getDeviceIcon(
                            type: myHiveService.reservedDevices[index].type),
                        title: Text(
                          myHiveService.reservedDevices[index].name,
                          style: TextStyle(
                              shadows: const [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 1,
                                    offset: Offset(1, 1))
                              ],
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: getDeviceIcon(
                                      type: myHiveService
                                          .reservedDevices[index].type)
                                  .color),
                        ),
                        subtitle: Column(
                          children: [
                            Text(
                              '${myHiveService.reservedDevices[index].price} \$ ',
                              style: TextStyle(
                                  shadows: const [
                                    BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 1,
                                        offset: Offset(1, 1))
                                  ],
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[700]),
                            ),
                            Text(
                              'Per Hour',
                              style: TextStyle(
                                  shadows: const [
                                    BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 1,
                                        offset: Offset(1, 1))
                                  ],
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[700]),
                            ),
                          ],
                        ),
                        colorOfReservedCircle:
                            (!myHiveService.reservedDevices[index].reserved)
                                ? Colors.red
                                : Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(double.infinity),
                        ),
                        colorOfCard: getDeviceIcon(
                                type: myHiveService.devices[index].type)
                            .color!,
                      ),
                    );
                  },
                ),
              ),
            ),
          ]);
  }
}
