import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/services/hive_service.dart';
import 'package:uuid/uuid.dart';

import '../../Functions/get_device_icon.dart';
import '../../models/hive_models/devices.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/custom_textformfield.dart';

class EditDevice extends StatelessWidget {
  final uuid = const Uuid();

  final int deviceIndex;

  const EditDevice(
      {super.key, required this.deviceIndex});

  @override
  Widget build(BuildContext context) {
    final myHiveService = Provider.of<HiveService>(context, listen: true);
    final TextEditingController name =
        TextEditingController(text: myHiveService.devices[deviceIndex].name);
    final TextEditingController price =
        TextEditingController(text: myHiveService.devices[deviceIndex].price);
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
                  'Edit " ${myHiveService.devices[deviceIndex].name} " device',
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
              icon:
                  getDeviceIcon(type: myHiveService.devices[deviceIndex].type),
              value: myHiveService.devices[deviceIndex].type,
              onChanged: (value) {
                myHiveService.devices[deviceIndex].type= value!;
                myHiveService.saveDetails(deviceIndex);
              },
            ),
            (myHiveService.devices[deviceIndex].reserved)
                ? CustomButton(
                    onpressed: () =>{},
                    txt: 'Edit the reservation time',
                    color: Colors.orange)
                : const SizedBox(),
          /*  CustomSwitch(
              value: myHiveService.devices[deviceIndex].reserved,
              onChanged: (value) {
                myReservationService.setReservation(
                    index: deviceIndex, newValue: value, context: context);
              },
            ),*/
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  child: CustomButton(
                    txt: 'Update this device',
                    onpressed: () {
                      myHiveService.updateDevice(
                          index: deviceIndex,
                          device: MyDevice(
                            // تمرير القائمة المُحدثة
                            price: price.text,
                            type: myHiveService.devices[deviceIndex].type,
                            reserved:
                                myHiveService.devices[deviceIndex].reserved,
                            name: name.text,
                            id: myHiveService.devices[deviceIndex].id,
                          ));
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
