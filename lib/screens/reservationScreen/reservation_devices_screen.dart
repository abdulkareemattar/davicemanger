import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/screens/noData_screen.dart';
import 'package:untitled8/screens/reservationScreen/start_reservation_dialog.dart';
import '../../Functions/get_device_icon.dart';
import '../../services/hive_service.dart';
import '../../services/reservation_service.dart';
import '../../widgets/custom_bottomsheet.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_delete_dialog.dart';
import '../../widgets/custom_gridview.dart';
import '../../widgets/custom_slidable.dart';
import '../addScreen/edit_device_bottomsheet.dart';
import '../addScreen/showReservationsDialog.dart';

class ReservationDevices extends StatelessWidget {
  const ReservationDevices({super.key});

  @override
  Widget build(BuildContext context) {
    final myHiveService = Provider.of<HiveService>(context, listen: true);
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
                      BoxShadow(color: Colors.black, blurRadius: 1, offset: Offset(1, 1))
                    ],
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber[700]),
              ),
              const Spacer(),
              CustomButton(
                  onpressed: () => myReservationService.cancelAllReservation(),
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
              final myDevice = myHiveService.reservedDevices[index];
              return CustomSlidable(
                editFunction: () {
                  openBottomSheet(
                    context,
                    EditDevice(deviceId: myDevice.id),
                  );
                },
                deleteFunction: () {
                  showDeleteConfirmationDialog(
                    context: context,
                    deleteText: 'Are you sure you want to delete this device?',
                    onDeleteFun: () {
                      myHiveService.deleteDeviceById(id: myDevice.id);
                      Navigator.of(context).pop();
                    },
                  );
                },
                keyY: Key(myDevice.id),
                child: CustomCard(
                  iconOfTrailing: Icon(Icons.power_settings_new_sharp,
                      size: 16.sp, color: Colors.black),
                  device: myDevice,
                  id: myDevice.id,
                  onTapOnTrailing: () {
                    showAddReservationDialog(
                      hiveService: myHiveService,
                      context: context,
                      deviceId: myDevice.id,
                      notDoublePop: true,
                    );
                  },
                  onTap: () => showDeviceReservationsDialog(
                      reservationService: myReservationService,
                      hive: myHiveService,
                      deviceId: myDevice.id,
                      context: context,
                      notDoublePop: true),
                  isReserved: myDevice.reservations.isNotEmpty,
                  index: index,
                  leading: getDeviceIcon(type: myDevice.type),
                  title: Text(
                    myDevice.name,
                    style: TextStyle(
                        shadows: const [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 1,
                              offset: Offset(1, 1))
                        ],
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: getDeviceIcon(type: myDevice.type).color),
                  ),
                  subtitle: Column(
                    children: [
                      Text(
                        '${myDevice.price} \$ ',
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
                                offset: Offset(1, 1),
                              ),
                            ],
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700]),
                      ),
                    ],
                  ),
                  colorOfReservedCircle: myDevice.reservations.isNotEmpty ? Colors.green : Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(double.infinity),
                  ),
                  colorOfCard: getDeviceIcon(type: myDevice.type).color!,
                ),
              );
            },
          ),
        ),
      ),
    ]);
  }
}
