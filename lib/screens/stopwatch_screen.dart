import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/stopwatch_provider.dart';
import '../widgets/stopwatch_list_item.dart';

class StopwatchScreen extends StatelessWidget {
  const StopwatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stopwatchProvider = Provider.of<StopwatchProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFEAEAEA),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.070,
            right: MediaQuery.of(context).size.width * 0.070,
            bottom: MediaQuery.of(context).size.height * 0.024,
            top: MediaQuery.of(context).size.height * 0.072,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Stopwatch",
                style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.075),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: Text(
                  stopwatchProvider.formattedTime(),
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.13,
                  ),
                ),
              ),
              stopwatchProvider.isSplit
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.53,
                      child: ListView.builder(
                        itemCount: stopwatchProvider.splitData.length,
                        itemBuilder: (context, index) {
                          stopwatchProvider.currentIndex = index;
                          return StopwatchListItem(
                            index: index,
                          );
                        },
                      ),
                    )
                  : const SizedBox(
                      height: 1,
                    ),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: stopwatchProvider.isStart
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: stopwatchProvider.isPause
                                ? stopwatchProvider.resetStopwatch
                                : stopwatchProvider.splitStopwatch,
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(10),
                            ),
                            child: stopwatchProvider.isPause
                                ? Icon(
                                    Icons.stop,
                                    color: const Color(0xFF6750A3),
                                    size: MediaQuery.of(context).size.height * 0.042,
                                  )
                                : Icon(
                                    Icons.flag,
                                    color: const Color(0xFF6750A3),
                                    size: MediaQuery.of(context).size.height * 0.042,
                                  ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.10,
                          ),
                          ElevatedButton(
                            onPressed: stopwatchProvider.isPause
                                ? stopwatchProvider.resumeStopwatch
                                : stopwatchProvider.pauseStopwatch,
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(10),
                            ),
                            child: stopwatchProvider.isPause
                                ? Icon(
                                    Icons.play_arrow,
                                    color: const Color(0xFF6750A3),
                                    size: MediaQuery.of(context).size.height * 0.042,
                                  )
                                : Icon(
                                    Icons.pause,
                                    color: const Color(0xFF6750A3),
                                    size: MediaQuery.of(context).size.height * 0.042,
                                  ),
                          ),
                        ],
                      )
                    : ElevatedButton(
                        onPressed: stopwatchProvider.startStopwatch,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 40,
                          ),
                        ),
                        child: Icon(
                          Icons.play_arrow,
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
