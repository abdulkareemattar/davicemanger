import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:untitled8/Functions/get_custom_textstyle.dart';
import 'package:uuid/uuid.dart';

import '../../Functions/get_device_icon.dart';
import '../../Functions/show_snackbar.dart';
import '../../models/hive_models/devices.dart';
import '../../services/hive_service.dart';
import '../../services/reservation_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/custom_textformfield.dart';

class AddDeviceForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final Uuid uuid = const Uuid();
  AddDeviceForm({super.key});

  @override
  Widget build(BuildContext context) {
    final myHiveService = Provider.of<HiveService>(context);
    final myReservationService = Provider.of<ReservationService>(context);

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
                    style: getTextStyle(
                        type: FontTypeEnum.headLineLarge, color: Colors.white),
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
                icon: (myHiveService.type != null)
                    ? getDeviceIcon(type: myHiveService.type!)
                    : const Icon(FontAwesomeIcons.question, color: Colors.purple),
                value: myHiveService.type,
                onChanged: (value) => myHiveService.dropDownSelectType(value!),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                      onpressed: () async {
                        if (_formKey.currentState!.validate()) {
                          myHiveService.addDevice(
                            device: MyDevice(
                              customerName: null,
                              startTime:  null,
                              endTime: null,
                              type: myHiveService.type!,
                              reserved: myHiveService.isReserved,
                              name: _name.text,
                              id: uuid.v4(),
                              price: _price.text,
                            ),
                          );
                          Navigator.pop(context);

                          showCustomSnackBar(
                            context: context,
                            txt: 'Device added successfully',
                          );

                        }
                        myHiveService.isReserved = false;
                      },
                      txt: 'Add Device',
                      color: Colors.green,
                    ),
                    CustomButton(
                      onpressed: () {
                        Navigator.pop(context);
                        myHiveService.type=null;
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
