import 'package:clock_app/providers/timer_provider.dart';
import 'package:clock_app/widgets/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFEAEAEA),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.072,
            bottom: MediaQuery.of(context).size.height * 0.024,
            left: MediaQuery.of(context).size.width * 0.070,
            right: MediaQuery.of(context).size.width * 0.070,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Timer",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.075),
              ),
              const Spacer(),
              timerProvider.isStart
                  ? Align(
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.70,
                            height: MediaQuery.of(context).size.height * 0.33,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.grey,
                              value: timerProvider.progress,
                              strokeWidth: 6,
                            ),
                          ),
                          AnimatedBuilder(
                            animation: timerProvider.controller,
                            builder: (context, child) => Text(
                              timerProvider.countText,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Align(
                      alignment: Alignment.center,
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TimePicker(
                                itemHeight:
                                    MediaQuery.of(context).size.height * 0.077,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.10,
                                maxValue: 23,
                                selectedValue: timerProvider.selectedHours,
                                position: 2),
                            const VerticalDivider(
                              thickness: 0.5,
                              color: Colors.black,
                            ),
                            TimePicker(
                                itemHeight:
                                MediaQuery.of(context).size.height * 0.077,
                                fontSize:
                                MediaQuery.of(context).size.width * 0.10,
                                maxValue: 59,
                                selectedValue: timerProvider.selectedMinutes,
                                position: 3),
                            const VerticalDivider(
                              thickness: 0.5,
                              color: Colors.black,
                            ),
                            TimePicker(
                                itemHeight:
                                MediaQuery.of(context).size.height * 0.077,
                                fontSize:
                                MediaQuery.of(context).size.width * 0.10,
                                maxValue: 59,
                                selectedValue: timerProvider.selectedSeconds,
                                position: 4),
                          ],
                        ),
                      ),
                    ),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: timerProvider.isStart
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: timerProvider.stopTimer,
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(10),
                            ),
                            child: Icon(
                              Icons.stop,
                              color: const Color(0xFF6750A3),
                              size: MediaQuery.of(context).size.height * 0.042,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.10,
                          ),
                          ElevatedButton(
                            onPressed: timerProvider.resumePauseTimer,
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(10),
                            ),
                            child: timerProvider.isPause
                                ? Icon(
                                    Icons.play_arrow,
                                    color: const Color(0xFF6750A3),
                                    size: MediaQuery.of(context).size.height *
                                        0.042,
                                  )
                                : Icon(
                                    Icons.pause,
                                    color: const Color(0xFF6750A3),
                                    size: MediaQuery.of(context).size.height *
                                        0.042,
                                  ),
                          ),
                        ],
                      )
                    : ElevatedButton(
                        onPressed: timerProvider.startTimer,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 40,
                          ),
                        ),
                        child: Icon(
                          timerProvider.isStart
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: const Color(0xFF6750A3),
                          size: MediaQuery.of(context).size.height * 0.042,
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
