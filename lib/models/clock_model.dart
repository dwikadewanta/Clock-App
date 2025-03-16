import 'dart:convert';

class AlarmData {
  AlarmData({required this.clock, required this.details, this.isActive = true});

  String clock;
  String details;
  bool isActive;

  // convert object to JSON
  Map<String, dynamic> toMap() =>
      {'clock': clock, 'details': details, 'isActive': isActive};

  // convert JSON back to object
  factory AlarmData.fromMap(Map<String, dynamic> map) {
    return AlarmData(
      clock: map['clock'],
      details: map['details'],
      isActive: map.containsKey('isActive') ? map['isActive'] : true,
    );
  }
}

class StopwatchData {
  const StopwatchData({
    required this.id,
    required this.splitTime,
    required this.realTime,
  });

  final String id;
  final String splitTime;
  final String realTime;
}
