import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/Functions/get_custom_textstyle.dart';
import 'package:untitled8/screens/addScreen/showReservationsDialog.dart';
import 'package:untitled8/services/reservation_service.dart';
import 'package:untitled8/widgets/custom_gridview.dart';
import 'package:untitled8/widgets/custom_slidable.dart';
import 'package:untitled8/widgets/custom_textformfield.dart';

import '../../Functions/get_device_icon.dart';
import '../../services/hive_service.dart';
import '../../widgets/custom_bottomsheet.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_delete_dialog.dart';
import '../noData_screen.dart';
import '../reservationScreen/start_reservation_dialog.dart';
import 'edit_device_bottomsheet.dart';

class MyDevicesScreen extends StatelessWidget {
  const MyDevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final myHiveService = Provider.of<HiveService>(context, listen: true);
    final myReservationService =
        Provider.of<ReservationService>(context, listen: true);


    if (myHiveService.devices.isEmpty) {
      return const NoDataScreen();
    } else {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 20.h),
            child: Row(
              children: [
                Chip(
                  backgroundColor: Colors.purpleAccent,
                  label: Text(
                    'My devices',
                    style: TextStyle(
                        shadows: const [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 1,
                              offset: Offset(1, 1))
                        ],
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                const Spacer(),
                ActionChip(
                  disabledColor: Colors.red,
                  label: Text(
                    'Clear All',
                    style: TextStyle(
                        shadows: const [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 1,
                              offset: Offset(1, 1))
                        ],
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                  onPressed: () => showDeleteConfirmationDialog(
                      context: context,
                      deleteText:
                          'Are you sure you want to delete all devices?',
                      onDeleteFun: () {
                        myHiveService.deleteAllDevices();
                        Navigator.of(context).pop();
                      }),
                ),
              ],
            ),
          ),
          CustomTextFormField(
            onChanged: (query) {
              myHiveService.filterDevices(query);
            },
            label: const Row(
              children: [
                Text('Search'),
                Spacer(),
                Icon(Icons.search),
              ],
            ),
            keyboard: TextInputType.text,
            txt: 'Search',
          ),
          Expanded(
            child: Consumer<HiveService>(
              builder: (context, hiveService, child) {
                final filteredDevices = hiveService.filteredDevices;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: filteredDevices.isEmpty
                            ? const Center(child: Text("No devices found."))
                            : CustomGridview(
                                itemCount: filteredDevices.length,
                                itemBuilder: (context, deviceIndex) {
                                  if (deviceIndex >= filteredDevices.length) {
                                    return Center(
                                      child: Text("Invalid device index."),
                                    );
                                  }
                                  final myDevice = filteredDevices[deviceIndex];
                                  return CustomSlidable(
                                    editFunction: () {
                                      openBottomSheet(
                                        context,
                                        EditDevice(deviceId: myDevice.id),
                                      );
                                    },
                                    keyY: Key(myDevice.id),
                                    deleteFunction: () =>
                                        showDeleteConfirmationDialog(
                                            context: context,
                                            deleteText:
                                                'Are You sure that You want to delete this device?',
                                            onDeleteFun: () async {
                                              await myHiveService
                                                  .deleteDeviceById(
                                                      id: myDevice.id);
                                              Navigator.of(context).pop();
                                            }),
                                    child: CustomCard(
                                      iconOfTrailing: const Icon(Icons.add,
                                          color: Colors.black),
                                      onTapOnTrailing: () {
                                        showAddReservationDialog(
                                          context: context,
                                          deviceId: myDevice.id,
                                          notDoublePop: true,
                                          hiveService: hiveService,
                                        );
                                      },
                                      onTap: () => showDeviceReservationsDialog(
                                        reservationService:
                                            myReservationService,
                                        hive: myHiveService,
                                        deviceId: myDevice.id,
                                        context: context,
                                        notDoublePop: true,
                                      ),
                                      colorOfCard:
                                          getDeviceIcon(type: myDevice.type)
                                              .color,
                                      device: myDevice,
                                      id: myDevice.id,
                                      index: deviceIndex,
                                      leading:
                                          getDeviceIcon(type: myDevice.type),
                                      title: Text(
                                        myDevice.name,
                                        overflow: TextOverflow.visible,
                                        maxLines: 3,
                                        softWrap: true,
                                        style: getTextStyle(
                                          size: 12,
                                          type: FontTypeEnum.customHeadLine,
                                          color:
                                              getDeviceIcon(type: myDevice.type)
                                                  .color,
                                        ),
                                      ),
                                      subtitle: Column(
                                        children: [
                                          Text(
                                            '${myDevice.price} \$ ',
                                            style: getTextStyle(
                                                type:
                                                    FontTypeEnum.headLineSmall,
                                                color: Colors.green),
                                          ),
                                          Text(
                                            'Per Hour',
                                            style: getTextStyle(
                                                type:
                                                    FontTypeEnum.customHeadLine,
                                                size: 10,
                                                color: Colors.green),
                                          ),
                                        ],
                                      ),
                                      colorOfReservedCircle:
                                              myDevice.reservations.isNotEmpty
                                          ? Colors.green
                                          : Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            double.infinity),
                                      ), isReserved: myDevice.reservations.isNotEmpty,
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }
}
