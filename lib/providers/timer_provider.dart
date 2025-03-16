import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier {
  int selectedHours = 0;
  int selectedMinutes = 0;
  int selectedSeconds = 1;
  bool isStart = false;
  bool isPause = false;
  late AnimationController controller;

  double progress = 1.0;

  TimerProvider(TickerProvider vsync){
    controller = AnimationController(
      vsync: vsync,
    );

    controller.addListener(
          () {
        if (controller.isAnimating) {
            progress = controller.value;
        } else if (controller.isDismissed) {
            progress = 1.0;
            isStart = false;
            isPause = false;
        } else {
            progress = 1.0;
          }
        notifyListeners();
      },
    );
  }

  String get countText {
    Duration count = controller.duration! * controller.value;
    return '${(count.inHours).toString().padLeft(2, '0')}:'
        '${(count.inMinutes % 60).toString().padLeft(2, '0')}:'
        '${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void resumePauseTimer() {
    if (controller.isAnimating) {
      controller.stop();
        isPause = true;
    } else {
      controller.reverse(from: controller.value == 0 ? 1.0 : controller.value);
        isPause = false;
    }
    notifyListeners();
  }

  void stopTimer() {
    controller.reset();
      isStart = false;
      isPause = false;
      notifyListeners();
  }

  void startTimer() {
    controller.duration = Duration(
      hours: selectedHours,
      minutes: selectedMinutes,
      seconds: selectedSeconds,
    );
    controller.reverse(from: controller.value == 0 ? 1.0 : controller.value);
    isStart = true;
    notifyListeners();
  }

  void setHours(int hours){
    selectedHours = hours;
    notifyListeners();
  }

  void setMinutes(int minutes){
    selectedMinutes = minutes;
    notifyListeners();
  }

  void setSeconds(int seconds){
    selectedSeconds = seconds;
    notifyListeners();
  }
}