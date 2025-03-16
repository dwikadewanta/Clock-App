import 'package:clock_app/widgets/time_picker.dart';
import 'package:clock_app/providers/alarm_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlarmEditScreen extends StatelessWidget {
  const AlarmEditScreen({super.key, required this.index});

  final int index;

  void confirmButton(AlarmProvider alarmProvider, BuildContext context){
    alarmProvider.editClockAlarm(index);
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
                    "Edit Alarm",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => confirmButton(alarmProvider, context),
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
            ],
          ),
        ),
      ),
    );
  }
}
