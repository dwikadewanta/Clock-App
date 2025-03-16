import 'package:clock_app/widgets/time_picker.dart';
import 'package:clock_app/screens/alarm_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/alarm_provider.dart';

class DialogEditAlarm extends StatelessWidget {
  const DialogEditAlarm({super.key, required this.index});

  final int index;

  void additionalButton(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AlarmEditScreen(index: index),
      ),
    );
  }

  void doneButton(AlarmProvider alarmProvider, BuildContext context) {
    alarmProvider.editClockAlarm(index);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final alarmProvider = Provider.of<AlarmProvider>(context);

    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.035,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Switch(
              value: alarmProvider.alarmData[index].isActive,
              onChanged: (value) => alarmProvider.toggleAlarm(index, value),
            ),
          ),
          Text(
            alarmProvider.alarmData[index].details,
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          const IntrinsicHeight(
            child: Divider(
              height: 0.5,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TimePicker(
                  maxValue: 23,
                  selectedValue: alarmProvider.selectedHours,
                  position: 0,
                  itemHeight: MediaQuery.of(context).size.height * 0.065,
                  fontSize: MediaQuery.of(context).size.width * 0.10,
                ),
                const VerticalDivider(
                  thickness: 1,
                  color: Colors.black,
                ),
                TimePicker(
                  maxValue: 59,
                  selectedValue: alarmProvider.selectedMinutes,
                  position: 1,
                  itemHeight: MediaQuery.of(context).size.height * 0.065,
                  fontSize: MediaQuery.of(context).size.width * 0.10,
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 40)),
                  onPressed: () => additionalButton(context),
                  child: Text(
                    "Additional",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.035,
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 40)),
                  onPressed: () => doneButton(alarmProvider, context),
                  child: Text(
                    "Done",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
