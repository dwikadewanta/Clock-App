import 'package:clock_app/providers/alarm_provider.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

import '../providers/timer_provider.dart';

class TimePicker extends StatelessWidget {
  const TimePicker({
    super.key,
    required this.itemHeight,
    required this.fontSize,
    required this.maxValue,
    required this.selectedValue,
    required this.position,
  });

  final int maxValue;
  final double itemHeight;
  final double fontSize;
  final int selectedValue;
  final int position;

  @override
  Widget build(BuildContext context) {
    final alarmProvider = Provider.of<AlarmProvider>(context);
    final timerProvider = Provider.of<TimerProvider>(context);

    return NumberPicker(
      itemHeight: itemHeight,
      infiniteLoop: true,
      minValue: 0,
      maxValue: maxValue,
      zeroPad: true,
      textStyle: TextStyle(fontSize: fontSize, color: Colors.grey),
      selectedTextStyle: TextStyle(fontSize: fontSize, color: Colors.black),
      value: selectedValue,
      onChanged: (value) {
        switch (position) {
          case 0:
            alarmProvider.setHours(value);
          case 1:
            alarmProvider.setMinutes(value);
          case 2:
            timerProvider.setHours(value);
          case 3:
            timerProvider.setMinutes(value);
          case 4:
            timerProvider.setSeconds(value);
        }
      },
    );
  }
}
