import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';


/// Time variables.
final tracker_today = DateTime.now();    // Today's date time.
final tracker_first_day = DateTime.utc(2000, 1, 1);   // January 1, 2000
final tracker_last_day = DateTime.utc(2100, 1, 1);  // January 1, 2100

/// Values to represent different event states.
const int SUCCESS_STATUS = 1;
const int FAILURE_STATUS = 0;
const int NEUTRAL_STATUS = 2;


/// Class for defining what a sobriety counter 'event' should be.
class TrackerEvent {
  final int status;   // See Statuses aove for different options.

  const TrackerEvent(this.status);

  int getStatus() {
    return status;
  }
}


/// A LinkedHashMap of events where each DateTime is mapped to an Event.
/// The map uses 'isSameDay' to compare any new DateTime entries to those already in the map.
/// the 'isSameDay' function ignores time, making all the DateTime keys totally date based.
final tracker_events_list = LinkedHashMap<DateTime, TrackerEvent>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(tracker_event_generator);


/// Creates a Map filled with a ton of DateTimes and Events.
final tracker_event_generator = Map.fromIterable(
    List.generate(2, (index) => index),
    key: (item) => DateTime.utc(tracker_first_day.year, tracker_first_day.month, item),
    value: (item) => TrackerEvent(FAILURE_STATUS))
  ..addAll({
    tracker_today: TrackerEvent(SUCCESS_STATUS),
  });


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

