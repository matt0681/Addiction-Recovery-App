import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


/// Time variables.
final tracker_today = DateTime.now();    // Today's date time.
final tracker_first_day = DateTime.utc(2000, 1, 1);   // January 1, 2000
final tracker_last_day = DateTime.utc(2100, 1, 1);  // January 1, 2100

/// Values to represent different event states.
const int STATUS_SUCCESS = 1;
const int STATUS_FAILURE = 0;
const int STATUS_NEUTRAL = 2;


/// Class for defining what a sobriety counter 'event' should be.
class TrackerEvent {
  final int status;   // See Statuses above for different options.

  const TrackerEvent(this.status);

  int getStatus() {
    return status;
  }

  Color getColor() {
    switch(status) {
      case STATUS_SUCCESS:
        return Color(0xFF00ff00);
        break;
      case STATUS_FAILURE:
        return Color(0xFFff3300);
        break;
      case STATUS_NEUTRAL:
        return Colors.grey;
        break;
      default:
        print('ERROR in Tracker Utils, cannot determine tracker event color.');
        return Colors.deepPurpleAccent;
        break;
    }
  }

  @override
  String toString() {
    switch(this.status) {
      case STATUS_SUCCESS:
        return "Success";
        break;
      case STATUS_FAILURE:
        return "Failure";
        break;
      case STATUS_NEUTRAL:
        return "Neutral";
        break;
      default:
        return "Error: Invalid Tracker Event Status";
        break;
    }
  }
}


/// A LinkedHashMap of events where each DateTime is mapped to an Event.
/// The map uses 'isSameDay' to compare any new DateTime entries to those already in the map.
/// the 'isSameDay' function ignores time, making all the DateTime keys totally date based.
final tracker_events_list = LinkedHashMap<DateTime, TrackerEvent>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(sample_events_map);

final dates = <DateTime>[
  DateTime.utc(tracker_today.year, tracker_today.month, tracker_today.day),
  DateTime.utc(tracker_today.year, tracker_today.month, tracker_today.day-1),
  DateTime.utc(tracker_today.year, tracker_today.month, tracker_today.day-2),
  DateTime.utc(tracker_today.year, tracker_today.month, tracker_today.day-3),
];

final sample_events_map = Map<DateTime, TrackerEvent>.fromIterable(
  dates,
  key: (item) => item,
  value: (item) => TrackerEvent(STATUS_FAILURE)
);


/// Returns a number calculated from a DateTime.
int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}


/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  // Number of days between last and first day.
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(dayCount,
        (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

