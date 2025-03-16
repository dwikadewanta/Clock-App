import 'package:clock_app/screens/alarm_screen.dart';
import 'package:clock_app/screens/stopwatch_screen.dart';
import 'package:clock_app/screens/timer_screen.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BottomNavigationState();
  }
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedPageIndex = 0;

  final List<Widget> activePage = [
    const AlarmScreen(),
    const StopwatchScreen(),
    const TimerScreen(),
  ];

  void selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedPageIndex,
        children: activePage,
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFFEAEAEA),
          onTap: selectPage,
          currentIndex: selectedPageIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: const Color(0xFFC5C5C5),
          selectedLabelStyle: const TextStyle(color: Colors.black),
          unselectedLabelStyle: const TextStyle(color: Color(0xFFC5C5C5)),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.alarm),
              label: 'Alarm',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: 'Stopwatch',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.hourglass_bottom),
              label: 'Timer',
            ),
          ]),
    );
  }
}
