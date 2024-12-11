import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/Functions/get_custom_textstyle.dart';
import 'package:untitled8/screens/addScreen/showReservationsDialog.dart';
import 'package:untitled8/widgets/custom_button.dart';
import 'package:untitled8/widgets/custom_gridview.dart';
import 'package:untitled8/widgets/custom_slidable.dart';

import '../../Functions/get_device_icon.dart';
import '../../services/hive_service.dart';
import '../../widgets/custom_card.dart';
import '../noData_screen.dart';
import '../reservationScreen/start_reservation_dialog.dart';

class AddDevicesScreen extends StatelessWidget {
  const AddDevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final myHiveService = Provider.of<HiveService>(context, listen: true);

    return myHiveService.devices.isEmpty
        ? const NoDataScreen()
        : Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                      'My devices',
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
                padding: EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
                child: CustomGridview(
                  itemCount: myHiveService.devices.length,
                  itemBuilder: (context, deviceIndex) {
                    return CustomSlidable(
                      keyY: Key(myHiveService.devices[deviceIndex].id),
                      index: deviceIndex,
                      child: CustomCard(
                        iconOfTrailing: const Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                        onTapOnTrailing: () {
                          showAddReservationDialog(
                            context: context,
                            deviceIndex: deviceIndex,
                          );
                        },
                        onTap: () => showDeviceReservationsDialog(hive: myHiveService,
                            deviceIndex: deviceIndex,
                            context: context,
                            notDoublePop: true),
                        colorOfCard: getDeviceIcon(
                                type: myHiveService.devices[deviceIndex].type)
                            .color,
                        device: myHiveService.devices[deviceIndex],
                        id: myHiveService.devices[deviceIndex].id,
                        isReserved: myHiveService.devices[deviceIndex].reserved,
                        index: deviceIndex,
                        leading: getDeviceIcon(
                            type: myHiveService.devices[deviceIndex].type),
                        title: Text(myHiveService.devices[deviceIndex].name,
                            overflow: TextOverflow.visible,
                            maxLines: 3,
                            softWrap: true,
                            style: getTextStyle(
                                size: 12.sp,
                                type: FontTypeEnum.customHeadLine,
                                color: getDeviceIcon(
                                        type: myHiveService
                                            .devices[deviceIndex].type)
                                    .color)),
                        subtitle: Column(
                          children: [
                            Text(
                              '${myHiveService.devices[deviceIndex].price} \$ ',
                              style: getTextStyle(
                                  type: FontTypeEnum.headLineSmall,
                                  color: Colors.green),
                            ),
                            Text(
                              'Per Hour',
                              style: getTextStyle(
                                  type: FontTypeEnum.customHeadLine,
                                  size: 10.sp,
                                  color: Colors.green),
                            ),
                          ],
                        ),
                        colorOfReservedCircle:
                            (!myHiveService.devices[deviceIndex].reserved)
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
