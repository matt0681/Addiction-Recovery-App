import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';


// final kToday = DateTime.now();
// // 3 months ago today.
// final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
// // 3 months in the future today.
// final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
//
//
// // Class for defining what a sobriety counter 'event' should be.
// // Essentially just a boolean value indicating success or failure.
// class Event {
//   final String title;
//
//   const Event(this.title);
//
//   @override
//   String toString() {
//     return title;
//   }
// }
//
//
// // A LinkedHashMap of events where each DateTime is mapped to a list of Events.
// // The map uses 'isSameDay' to compare any new DateTime entries to those already in the map.
// // the 'isSameDay' function ignores time, making all the DateTime keys totally date based.
// final kEvents = LinkedHashMap<DateTime, List<Event>>(
//   equals: isSameDay,
//   hashCode: getHashCode,
// )..addAll(_kEventSource);
//
//
// // Creates a Map filled with a ton of DateTimes and Events.
// final _kEventSource = Map.fromIterable(
//     List.generate(50, (index) => index),
//     key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
//     value: (item) => List.generate(
//         item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
//   ..addAll({
//     kToday: [
//       Event('Today\'s Event 1'),
//       Event('Today\'s Event 2'),
//     ],
//   });
//
//
// // Returns a number calculated from a DateTime.
// int getHashCode(DateTime key) {
//   return key.day * 1000000 + key.month * 10000 + key.year;
// }
//
//
// /// Returns a list of [DateTime] objects from [first] to [last], inclusive.
// List<DateTime> daysInRange(DateTime first, DateTime last) {
//   // Number of days between last and first day.
//   final dayCount = last.difference(first).inDays + 1;
//   return List.generate(dayCount,
//         (index) => DateTime.utc(first.year, first.month, first.day + index),
//   );
// }

 

final kToday = DateTime.now();
// 3 months ago today.
final kFirstDay = DateTime(kToday.year, kToday.month, kToday.day - 6);
// 3 months in the future today.
final kLastDay = DateTime(kToday.year, kToday.month, kToday.day);

const int SUCCESS = 1;
const int FAILURE = 0;
const int NEUTRAL = 2;

// Class for defining what a sobriety counter 'event' should be.
class Event {

  // Statuses can be:
  final int status;

  const Event(this.status);

  @override
  int getStatus() {
    return status;
  }
}


// A LinkedHashMap of events where each DateTime is mapped to an Event.
// The map uses 'isSameDay' to compare any new DateTime entries to those already in the map.
// the 'isSameDay' function ignores time, making all the DateTime keys totally date based.
final kEvents = LinkedHashMap<DateTime, Event>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);


// Creates a Map filled with a ton of DateTimes and Events.
final _kEventSource = Map.fromIterable(
    List.generate(5, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item),
    value: (item) => Event(FAILURE))
  ..addAll({
    kToday: Event(SUCCESS),
  });


// Returns a number calculated from a DateTime.
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
