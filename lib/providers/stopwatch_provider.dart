import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../models/clock_model.dart';

class StopwatchProvider with ChangeNotifier {
  final stopwatch = Stopwatch();
  late Timer timer;
  bool isStart = false;
  bool isPause = false;
  bool isSplit = false;
  int id = 1;
  int currentIndex = 0;
  List<StopwatchData> splitData = [];

  StopwatchProvider() {
    timer = Timer.periodic(
      const Duration(milliseconds: 10),
      (timer) {
        if (stopwatch.isRunning) {
          notifyListeners();
        }
      },
    );
  }

  void startStopwatch() {
    stopwatch.start();
    isStart = true;
    notifyListeners();
  }

  void pauseStopwatch() {
    stopwatch.stop();
    isPause = true;
    notifyListeners();
  }

  void resumeStopwatch() {
    stopwatch.start();
    isPause = false;
    notifyListeners();
  }

  void resetStopwatch() {
    stopwatch.reset();
    isStart = false;
    isPause = false;
    isSplit = false;
    splitData.clear();
    id = 1;
    notifyListeners();
  }

  void splitStopwatch() {
    splitData.add(
      StopwatchData(
        id: id.toString(),
        splitTime: splitData.isEmpty
            ? "+ ${formattedTime()}"
            : "+ ${splitFormattedTime()}",
        realTime: formattedTime(),
      ),
    );
    isSplit = true;
    id++;
    notifyListeners();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String formattedTime() {
    final int milliseconds = stopwatch.elapsedMilliseconds;
    final int seconds = (milliseconds ~/ 1000) % 60;
    final int minutes = (milliseconds ~/ (1000 * 60)) % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}.'
        '${(milliseconds % 100).toString().padLeft(2, '0')}';
  }

  String splitFormattedTime() {
    // get current realtime data and convert into seconds
    final int milliseconds = stopwatch.elapsedMilliseconds;
    final int seconds = milliseconds ~/ 1000;
    final currentRealtimeSeconds =
        "$seconds.${(milliseconds % 100).toString().padLeft(2, '0')}";

    // get previous realtime data and convert into seconds
    final previousRealtimeData = splitData[currentIndex].realTime;
    List<String> parts = previousRealtimeData.split(":");
    int minutes = int.parse(parts[0]);
    double previousSeconds = double.parse(parts[1].replaceAll(".", "")) / 100;
    double previousRealtimeSeconds = (minutes * 60) + previousSeconds;

    double difference =
        double.parse(currentRealtimeSeconds) - previousRealtimeSeconds;

    // Format hasilnya kembali ke "MM:SS.ss"
    int diffMinutes = (difference ~/ 60).toInt();
    double diffSeconds = difference % 60;

    // Format dengan 2 digit pada menit
    String formattedMinutes = diffMinutes.toString().padLeft(2, '0');
    String formattedSeconds =
        diffSeconds.toStringAsFixed(2).padLeft(5, '0'); // SS.ss

    return "$formattedMinutes:$formattedSeconds";
  }
}
