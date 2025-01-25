import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/screens/addScreen/showReservationsDialog.dart';
import 'package:untitled8/services/hive_service.dart';
import 'package:untitled8/services/reservation_service.dart';
import 'package:uuid/uuid.dart';

import '../../Functions/get_device_icon.dart';
import '../../models/hive_models/devices.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/custom_textformfield.dart';

class EditDevice extends StatefulWidget {
  final String deviceId;

  const EditDevice({super.key, required this.deviceId});

  @override
  _EditDeviceState createState() => _EditDeviceState();
}

class _EditDeviceState extends State<EditDevice> {
  final uuid = const Uuid();

  late TextEditingController nameController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    final myHiveService = Provider.of<HiveService>(context, listen: false);
    final myReservationService = Provider.of<ReservationService>(context, listen: false);
    final device =
        myHiveService.devices.firstWhere((d) => d.id == widget.deviceId);
    nameController = TextEditingController(text: device.name);
    priceController = TextEditingController(text: device.price);
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myHiveService = Provider.of<HiveService>(context, listen: false);
    final device =
        myHiveService.devices.firstWhere((d) => d.id == widget.deviceId);
    final myReservationService = Provider.of<ReservationService>(context, listen: false);
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
                  'Edit " ${device.name} " device',
                  style: TextStyle(color: Colors.green, fontSize: 20.sp),
                ),
              ),
            ),
            CustomTextFormField(
              txt: 'Enter device name:',
              validate: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a device name';
                }
                return null;
              },
              controller: nameController,
              label: Row(
                children: [
                  Text('Device Name'),
                  Spacer(),
                  Icon(FluentIcons.device_eq_16_filled)
                ],
              ),
              keyboard: TextInputType.name,
            ),
            CustomTextFormField(
              txt: 'Enter the price per hour for reserving this device:',
              validate: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a price';
                } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                  return 'Please enter only numbers';
                }
                return null;
              },
              controller: priceController,
              label: Row(
                children: [
                  Text('Price per hour'),
                  Spacer(),
                  Icon(FluentIcons.money_16_filled)
                ],
              ),
              keyboard: TextInputType.number,
            ),
            CustomDropdown(
              icon: getDeviceIcon(type: device.type),
              value: device.type,
              onChanged: (value) {
                setState(() {
                  device.type = value!;
                });
                myHiveService.saveDetails(widget.deviceId);
              },
            ),
            (device.reservations.isNotEmpty)
                ? CustomButton(
                    onpressed: () => showDeviceReservationsDialog(
                        context: context,
                        deviceId: widget.deviceId,
                        notDoublePop: false,
                        hive: myHiveService,
                        reservationService: myReservationService),
                    txt: 'Edit the reservation time',
                    color: Colors.orange)
                : const SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.h),
                  child: CustomButton(
                    txt: 'Update this device',
                    onpressed: () {
                      myHiveService.updateDevice(
                          id: widget.deviceId,
                          device: MyDevice(
                            price: priceController.text,
                            type: device.type,
                            name: nameController.text,
                            id: device.id,
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
