import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/services/hive_service.dart';
import 'package:uuid/uuid.dart';

import '../../Functions/get_device_icon.dart';
import '../../models/hive_models/devices.dart';
import '../../services/reservation_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/custom_switch.dart';
import '../../widgets/custom_textformfield.dart';
import '../reservationScreen/edit_reservation_dialog.dart';

class EditDevice extends StatelessWidget {
  final uuid = const Uuid();

  int index;

  EditDevice({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final myReservationService =
        Provider.of<ReservationService>(context, listen: false);
    final myHiveService = Provider.of<HiveService>(context, listen: true);
    final TextEditingController name =
        TextEditingController(text: myHiveService.devices[index].name);
    final TextEditingController price =
        TextEditingController(text: myHiveService.devices[index].price);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h),
              child: Title(
                color: Colors.grey,
                child: Text(
                  'Edit " ${myHiveService.devices[index].name} " device',
                  style: TextStyle(color: Colors.green, fontSize: 20.sp),
                ),
              ),
            ),
            CustomTextFormField(
              txt: 'Enter device name:',
              validate: (value) {
                if (value.isEmpty) {
                  return 'Please enter a device name';
                }
                return null;
              },
              controller: name,
              label: 'Device Name',
              keyboard: TextInputType.name,
            ),
            CustomTextFormField(
              txt: 'Enter the price per hour for reserving this device:',
              validate: (value) {
                if (value.isEmpty) {
                  return 'Please enter a price';
                } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                  return 'Please enter only numbers';
                }
                return null;
              },
              controller: price,
              label: 'Price per hour',
              keyboard: TextInputType.number,
            ),
            CustomDropdown(
              icon: getDeviceIcon(type: myHiveService.devices[index].type),
              value: myHiveService.devices[index].type,
              onChanged: (value) {
                myHiveService.devices[index].type = value!;
                myHiveService.saveDetails(index);
              },
            ),
            (myHiveService.devices[index].reserved)
                ? CustomButton(
                    onpressed: () => showEditReservationDialog(
                          context: context,
                          index: index,
                          notDoublePop: true,
                        ),
                    txt: 'Edit the reservation time',
                    color: Colors.orange)
                : const SizedBox(),
            CustomSwitch(
              value: myHiveService.devices[index].reserved,
              onChanged: (value) {
                myReservationService.setReservation(
                    index: index, newValue: value, context: context);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  child: CustomButton(
                    txt: 'Update this device',
                    onpressed: () {
                      myHiveService.updateDevice(
                        index: index,
                        device: MyDevice(
                          startTime: myHiveService.devices[index].startTime,
                          endTime: myHiveService.devices[index].endTime,
                          customerName:
                              myHiveService.devices[index].customerName,
                          price: price.text,
                          type: myHiveService.devices[index].type,
                          reserved: myHiveService.devices[index].reserved,
                          name: name.text,
                          id: myHiveService.devices[index].id,
                        ),
                      );
                      Navigator.pop(context);
                    },
                    color: Colors.green,
                  ),
                ),
                CustomButton(
                  onpressed: () {
                    Navigator.pop(context);
                  },
                  txt: 'Cancel',
                  color: Colors.red,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
