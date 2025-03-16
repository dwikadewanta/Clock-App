import 'dart:async';
import 'dart:convert';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/clock_model.dart';

class AlarmProvider with ChangeNotifier {
  AlarmProvider() {
    getDataAlarm();
    _initNotifications();
    _detailsUpdating();
  }

  int selectedHours = 0;
  int selectedMinutes = 0;

  List<AlarmData> _alarmData = [];
  final List<int> _listDeleteAlarm = [];

  // getter
  List<AlarmData> get alarmData => _alarmData;
  List<int> get listDeleteAlarm => _listDeleteAlarm;


  // save data to shared preferences
  Future<void> saveDataAlarm(List<AlarmData> alarmData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> alarmDataJson =
        alarmData.map((data) => jsonEncode(data.toMap())).toList();
    await prefs.setStringList('alarmData_list', alarmDataJson);
  }

  // retrieve data from shared preferences
  Future<void> getDataAlarm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? alarmDataJson = prefs.getStringList('alarmData_list');

    if (alarmDataJson != null) {
      _alarmData = alarmDataJson
          .map((json) => AlarmData.fromMap(jsonDecode(json)))
          .toList();
    }
    notifyListeners();
  }

  List<int> parsingClock(String clock){
    List<String> parts = clock.split(":");
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    return [hours, minutes];
  }

  // add single data alarm to list
  Future<void> addAlarmData(AlarmData newAlarm) async {
    _alarmData.add(newAlarm);
    await saveDataAlarm(_alarmData);
    int alarmId = _alarmData.length;

    DateTime now = DateTime.now();
    // parsing hours and minutes from newAlarm data
    final data = parsingClock(newAlarm.clock);
    int hours = data[0];
    int minutes = data[1];

    DateTime alarmTime = DateTime(now.year, now.month, now.day, hours, minutes);
    if (alarmTime.isBefore(now)) {
      alarmTime = alarmTime.add(const Duration(days: 1));
    }

    AndroidAlarmManager.oneShotAt(alarmTime, alarmId, triggerAlarm);
    notifyListeners();
  }

  Future<void> _initNotifications() async {
    var androidSettings =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
    InitializationSettings(android: androidSettings);
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  @pragma('vm:entry-point')
  static void triggerAlarm() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    var androidDetails = const AndroidNotificationDetails('alarm_id', 'Alarm',
        importance: Importance.max, priority: Priority.high);
    var notificationDetails = NotificationDetails(android: androidDetails);
    await flutterLocalNotificationsPlugin.show(
        0, 'Alarm', 'Wake up!', notificationDetails);
  }

  // delete data at a certain position
  Future<void> deleteDataAlarmAt() async {
    for(final index in _listDeleteAlarm){
      _alarmData.removeAt(index);
    }
    await saveDataAlarm(_alarmData);
    _listDeleteAlarm.clear();
    notifyListeners();
  }

  void setHours(int hours) {
    selectedHours = hours;
    notifyListeners();
  }

  void setMinutes(int minutes) {
    selectedMinutes = minutes;
    notifyListeners();
  }

  void setPickerAlarm(int index) {
    final data = parsingClock(_alarmData[index].clock);
    int hours = data[0];
    int minutes = data[1];
    selectedHours = hours;
    selectedMinutes = minutes;
    notifyListeners();
  }

  void setPickerNow(){
    DateTime now = DateTime.now();
    setHours(now.hour);
    setMinutes(now.minute);
  }

  void editClockAlarm(int index) {
    _alarmData[index].clock =
        "${selectedHours.toString().padLeft(2, '0')}:${selectedMinutes.toString().padLeft(2, '0')}";
  }

  Future<void> toggleAlarm(int index, bool isActive) async{
    if(isActive){
      // activate alarm
      DateTime now = DateTime.now();
      // parsing hours and minutes from newAlarm data
      final data = parsingClock(_alarmData[index].clock);
      int hours = data[0];
      int minutes = data[1];

      DateTime alarmTime = DateTime(now.year, now.month, now.day, hours, minutes);
      if (alarmTime.isBefore(now)) {
        alarmTime = alarmTime.add(const Duration(days: 1));
      }

      AndroidAlarmManager.oneShotAt(alarmTime, index + 1, triggerAlarm);
    }else{
      await AndroidAlarmManager.cancel(index + 1);
    }

    _alarmData[index].isActive = isActive;
    saveDataAlarm(_alarmData);
    notifyListeners();
  }

  void _detailsUpdating() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        DateTime now = DateTime.now();
        if (_alarmData.isNotEmpty) {
          // parsing hours and minutes from newAlarm data
          final data = parsingClock(_alarmData.last.clock);
          int minutes = data[1];

          if (now.minute != minutes) {
            for (final (index, alarm) in _alarmData.indexed) {
              final nowMinutes = now.hour * 60 + now.minute;

              final data = parsingClock(alarm.clock);
              int hours = data[0];
              int minutes = data[1];

              final alarmMinutes = hours * 60 + minutes;
              int detailsHours;
              int detailsMinutes;

              if (alarmMinutes > nowMinutes) {
                final detailsTime = alarmMinutes - nowMinutes;
                detailsHours = detailsTime ~/ 60;
                detailsMinutes = detailsTime % 60;
              } else {
                final detailsTime = 1440 - (nowMinutes - alarmMinutes);
                detailsHours = detailsTime ~/ 60;
                detailsMinutes = detailsTime % 60;
              }

              if (detailsHours > 0) {
                _alarmData[index].details =
                "Alarm in $detailsHours hours $detailsMinutes minutes";
              } else {
                _alarmData[index].details =
                "Alarm in $detailsMinutes minutes";
              }
            }
            notifyListeners();
          }
        }
      },
    );
  }

  void addDeleteList(int index){
    _listDeleteAlarm.add(index);
    notifyListeners();
  }
  
  void removeDeleteList(int index){
    _listDeleteAlarm.removeWhere((element) => element == index,);
    notifyListeners();
  }
}
