import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../Functions/get_device_icon.dart';
import '../Functions/show_snackbar.dart';
import '../data/devices.dart';
import '../services/hive_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/custom_switch.dart';
import '../widgets/custom_textformfield.dart';
import 'device_reservation.dart';

class AddDeviceForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final Uuid uuid = const Uuid();

  AddDeviceForm({super.key});

  @override
  Widget build(BuildContext context) {
    final myHiveServiceListenIsTrue = Provider.of<HiveService>(context);
    final myHiveServiceListenIsFalse =
        Provider.of<HiveService>(context, listen: false);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h),
                child: Title(
                  color: Colors.grey,
                  child: Text(
                    'Add Devices',
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
                controller: _name,
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
                controller: _price,
                label: 'Price per hour',
                keyboard: TextInputType.number,
              ),
              CustomDropdown(
                icon: (myHiveServiceListenIsTrue.type != null)
                    ? getDeviceIcon(type: myHiveServiceListenIsTrue.type!)
                    : const Icon(FontAwesomeIcons.desktop, color: Colors.green),
                value: myHiveServiceListenIsTrue.type,
                onChanged: (value) =>
                    myHiveServiceListenIsTrue.dropDownSelectType(value!),
              ),
              CustomSwitch(
                value: myHiveServiceListenIsTrue.isReserved,
                onChanged: (value) {
                  myHiveServiceListenIsTrue.reservation(
                    newValue: value,
                    isNewDevice: true,
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                      onpressed: () async {
                        if (_formKey.currentState!.validate()) {
                          myHiveServiceListenIsTrue.addDevice(
                            device: MyDevice(
                              customerName:
                                  (myHiveServiceListenIsTrue.isReserved)
                                      ? myHiveServiceListenIsTrue.customerName
                                      : "",
                              selectedTime:
                                  (myHiveServiceListenIsTrue.isReserved)
                                      ? myHiveServiceListenIsTrue.dateTime
                                      : null,
                              type: myHiveServiceListenIsTrue.type!,
                              reserved: myHiveServiceListenIsTrue.isReserved,
                              name: _name.text,
                              ID: uuid.v4(),
                              price: _price.text,
                            ),
                          );
                          if (myHiveServiceListenIsFalse.isReserved) {
                            showDeviceReservationDialog(
                                isFromHomePage: false,
                                context: context,
                                index:
                                    (myHiveServiceListenIsTrue.devices.length -
                                        1));
                          } else {
                            Navigator.pop(context);
                          }
                          showCustomSnackBar(
                            context: context,
                            txt: 'Device added successfully',
                          );
                        }
                        myHiveServiceListenIsTrue.isReserved = false;
                      },
                      txt: 'Add Device',
                      color: Colors.green,
                    ),
                    CustomButton(
                      onpressed: () {
                        Navigator.pop(context);
                        myHiveServiceListenIsTrue.reservation(
                            newValue: false, isNewDevice: true);
                      },
                      txt: 'Cancel',
                      color: Colors.red,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
