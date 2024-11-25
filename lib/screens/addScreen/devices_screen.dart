import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/Functions/get_custom_textstyle.dart';
import 'package:untitled8/widgets/custom_button.dart';
import 'package:untitled8/widgets/custom_gridview.dart';
import 'package:untitled8/widgets/custom_slidable.dart';

import '../../Functions/get_device_icon.dart';
import '../../services/hive_service.dart';
import '../../services/reservation_service.dart';
import '../../widgets/custom_card.dart';
import '../noData_screen.dart';
import '../reservationScreen/end_reservation_dialog.dart';
import '../reservationScreen/start_reservation_dialog.dart';

class AddDevicesScreen extends StatelessWidget {
  const AddDevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final myHiveService = Provider.of<HiveService>(context, listen: true);
    final myReservationService =
        Provider.of<ReservationService>(context, listen: true);

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
                  itemBuilder: (context, index) {
                    return CustomSlidable(
                      keyY: Key(myHiveService.devices[index].id),
                      index: index,
                      child: CustomCard(
                        onTap: () => (!myHiveService.devices[index].reserved)
                            ? showStartReservationDialog(
                                context: context,
                                index: index,
                                notDoublePop: true)
                            : showDialogEndReservation(
                                context: context,
                                index: index,
                                myDevice: myHiveService.devices[index]),
                        colorOfCard: getDeviceIcon(
                                type: myHiveService.devices[index].type)
                            .color,
                        device: myHiveService.devices[index],
                        id: myHiveService.devices[index].id,
                        onTapOnTrailing: () {
                          myReservationService.setReservation(
                              context: context,
                              index: index,
                              newValue: !myHiveService.devices[index].reserved);
                        },
                        isReserved: myHiveService.devices[index].reserved,
                        index: index,
                        leading: getDeviceIcon(
                            type: myHiveService.devices[index].type),
                        title: Text(myHiveService.devices[index].name,
                            overflow: TextOverflow.visible,
                            maxLines: 3,
                            softWrap: true,
                            style: getTextStyle(
                                size: 12.sp,
                                type: FontTypeEnum.customHeadLine,
                                color: getDeviceIcon(
                                        type: myHiveService.devices[index].type)
                                    .color)),
                        subtitle: Column(
                          children: [
                            Text(
                              '${myHiveService.devices[index].price} \$ ',
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
                            (!myHiveService.devices[index].reserved)
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
