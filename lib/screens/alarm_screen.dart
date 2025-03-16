import 'package:clock_app/providers/alarm_provider.dart';
import 'package:clock_app/screens/alarm_add_screen.dart';
import 'package:clock_app/widgets/alarm_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({super.key});

  void addAlarmScreen(BuildContext context, AlarmProvider alarmProvider) {
    alarmProvider.setPickerNow();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AlarmAddScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final alarmProvider = Provider.of<AlarmProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFEAEAEA),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.030,
            right: MediaQuery.of(context).size.width * 0.030,
            top: MediaQuery.of(context).size.height * 0.012,
            bottom: MediaQuery.of(context).size.height * 0.024,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.060,
                child: alarmProvider.listDeleteAlarm.isNotEmpty
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () => alarmProvider.deleteDataAlarmAt(),
                          icon: Icon(
                            Icons.delete,
                            size: MediaQuery.of(context).size.height * 0.036,
                          ),
                        ),
                      )
                    : const SizedBox(
                        height: 1,
                      ),
              ),
              Text(
                "  Alarm",
                style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.075),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: ListView.builder(
                  itemCount: alarmProvider.alarmData.length,
                  itemBuilder: (context, index) {
                    return AlarmListItem(
                      index: index,
                    );
                  },
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: FloatingActionButton(
                  shape: const CircleBorder(),
                  onPressed: () => addAlarmScreen(context, alarmProvider),
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF6750A3),
                  child: const Icon(Icons.add),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
