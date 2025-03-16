import 'package:clock_app/providers/stopwatch_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StopwatchListItem extends StatelessWidget{
  const StopwatchListItem({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    var stopwatchProvider = Provider.of<StopwatchProvider>(context);

    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Text(
              stopwatchProvider.splitData[index].id,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
            Text(
              stopwatchProvider.splitData[index].splitTime,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
            Text(
              stopwatchProvider.splitData[index].realTime,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
          ],
        ),
      ),
    );
  }
}