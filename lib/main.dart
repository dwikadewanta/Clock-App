import 'dart:async';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:clock_app/providers/alarm_provider.dart';
import 'package:clock_app/providers/stopwatch_provider.dart';
import 'package:clock_app/providers/timer_provider.dart';
import 'package:clock_app/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late TimerProvider _timerProvider;

  @override
  void initState() {
    super.initState();
    _timerProvider = TimerProvider(this);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AlarmProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => StopwatchProvider(),
        ),
        ChangeNotifierProvider.value(value: _timerProvider)
      ],
      child: const MaterialApp(
        home: BottomNavigation(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
