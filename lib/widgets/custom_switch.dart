import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({required this.value, super.key, required this.onChanged});
final bool value;
final void Function(bool) onChanged;
  @override
  Widget build(BuildContext context) {
    return Switch(
      activeTrackColor: Colors.amber,
      thumbColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.red;
            } else if (states.contains(WidgetState.selected)) {
              return Colors.green;
            } else {
              return Colors.red;
            }
          }),
      value: value,
      onChanged: onChanged,
    );
  }
}
