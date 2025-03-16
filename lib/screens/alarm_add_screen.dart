import 'package:clock_app/providers/alarm_provider.dart';
import 'package:clock_app/models/clock_model.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

import '../widgets/time_picker.dart';

class AlarmAddScreen extends StatelessWidget {
  const AlarmAddScreen({super.key});

  void addAlarm(BuildContext context, AlarmProvider alarmProvider) {
    alarmProvider.addAlarmData(
      AlarmData(
        clock: "${alarmProvider.selectedHours.toString().padLeft(2, '0')}:"
            "${alarmProvider.selectedMinutes.toString().padLeft(2, '0')}",
        details: "",
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final alarmProvider = Provider.of<AlarmProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.020),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      size: MediaQuery.of(context).size.height * 0.042,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Add Alarm",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => addAlarm(context, alarmProvider),
                    icon: Icon(
                      Icons.check,
                      size: MediaQuery.of(context).size.height * 0.042,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.066,
              ),
              Align(
                alignment: Alignment.center,
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TimePicker(
                        itemHeight: MediaQuery.of(context).size.height * 0.077,
                        fontSize: MediaQuery.of(context).size.width * 0.10,
                        maxValue: 23,
                        selectedValue: alarmProvider.selectedHours,
                        position: 0,
                      ),
                      const VerticalDivider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      TimePicker(
                        itemHeight: MediaQuery.of(context).size.height * 0.077,
                        fontSize: MediaQuery.of(context).size.width * 0.10,
                        maxValue: 59,
                        selectedValue: alarmProvider.selectedMinutes,
                        position: 1,
                      ),
                    ],
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 60,
              // ),
              // TextField(
              //   style: const TextStyle(fontSize: 20),
              //   decoration: const InputDecoration(
              //     labelText: "Message",
              //     border: OutlineInputBorder(),
              //   ),
              //   controller: _controller,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
