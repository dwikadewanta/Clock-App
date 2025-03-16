import 'package:clock_app/widgets/dialog_edit_alarm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/alarm_provider.dart';

class AlarmListItem extends StatefulWidget {
  const AlarmListItem(
      {super.key,
      required this.index,});

  final int index;

  @override
  State<StatefulWidget> createState() {
    return _AlarmListItem();
  }
}

class _AlarmListItem extends State<AlarmListItem> {
  bool isSelected = false;

  void alarmInfo() {
    final alarmProvider = Provider.of<AlarmProvider>(context, listen: false);
    alarmProvider.setPickerAlarm(widget.index);
    showDialog(
      context: context,
      builder: (context) => DialogEditAlarm(
        index: widget.index,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final alarmProvider = Provider.of<AlarmProvider>(context);

    return Card(
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      color: alarmProvider.listDeleteAlarm.contains(widget.index)
          ? const Color(0xFFCACACA)
          : Colors.white,
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alarmProvider.alarmData[widget.index].clock,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.048,
                  ),
                ),
                Text(
                  alarmProvider.alarmData[widget.index].details,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Switch(
                value: alarmProvider.alarmData[widget.index].isActive,
                onChanged: (value) =>
                    alarmProvider.toggleAlarm(widget.index, value),
              ),
            )
          ],
        ),
        onTap: () => alarmInfo(),
        onLongPress: () {
          setState(() {
            isSelected = !isSelected;
          });
          isSelected
              ? alarmProvider.addDeleteList(widget.index)
              : alarmProvider.removeDeleteList(widget.index);
        },
      ),
    );
  }
}
