import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


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
  final DateTime date;

  const TrackerEvent(this.status, this.date);

  int getStatus() {
    return status;
  }

  DateTime getDate() {
    return date;
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
        return Color(0xFF808080);
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


/// Class for defining the storage of TrackerEvents.
class TrackerStorage {
  /// Find the user's DOCUMENT DIRECTORY. This is different for Apple and Android devices.
  /// The document directory is a safe place for apps to store data in. This data is not
  /// extremely sensitive information so storing here is perfect.
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  /// Create a reference to the file's location.
  /// Create a file in that directory called calendar_tracker_data_file.csv
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/calendar_tracker_data_file.txt');
  }

  late List<String> currentData = [];

  /// data file -> currentData
  Future<void> readFileData() async {
    print("Reading a file.");
    final file = await _localFile;
    currentData = await file.readAsLines();
  }

  /// currentData -> data file
  Future<void> updateFileData(List<String> dataArray) async {
    final file = await _localFile;
    final sink = file.openWrite();
    for (final line in currentData) {
      sink.write(line);
    }
    await sink.flush();
    await sink.close();
  }

  /// new event -> currentData
  void addEvent(int status, DateTime date) {
    print("Adding an event: " + date.toString() + "=" + status.toString());
    currentData.add(date.toString() + "=" + status.toString());

    updateFileData(currentData);
  }

  /// deletes an event from currentData.
  void deleteEvent(DateTime date) async {
    print("Deleting an event: " + date.toString());
    for (String entry in currentData) {
      if (entry.startsWith(date.toString())) {
        currentData.remove(entry);
        return;
      }
    }

    updateFileData(currentData);
  }

  /// Returns an event from currentData on the specified date parameter.
  TrackerEvent getEvent(DateTime date) {
    print("Fetching an event: " + date.toString());
    for (String entry in currentData) {
      List<String> parts = entry.split("=");
      DateTime eventDate = DateTime.parse(parts[0]);
      if (eventDate.year == date.year && eventDate.month == date.month && eventDate.day == date.day) {
        print("FOUND IT!");
        return TrackerEvent(int.parse(parts[1]), eventDate);
      }
    }
    print("Did not find it...");
    return TrackerEvent(STATUS_NEUTRAL, date);
  }




  // /// updates data file
  // void updateEvent(TrackerEvent eventToUpdate, int newStatus) async {
  //   print("Updating an event: " + eventToUpdate.getDate().toString() + "=" + eventToUpdate.getStatus().toString() + "->" + newStatus.toString());
  //   final file = await _localFile;
  //   List<String> lines = await file.readAsLines();
  //   List<String> updatedLines = [];
  //   for (String line in lines) {
  //     if (line.startsWith(eventToUpdate.getDate().toString())) {
  //       updatedLines.add(eventToUpdate.getDate().toString() + "=" + newStatus.toString());
  //     } else {
  //       updatedLines.add(line);
  //     }
  //   }
  //   await file.writeAsString(updatedLines.join("\n"));
  // }
  //
}


/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  // Number of days between last and first day.
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(dayCount,
        (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

/// Converts a number day or month into it's respective string.
/// 0 = day of week.
/// 1 = month.
String getNameFromDateInt(int type, int intInput) {
  if (type == 0) {
    switch(intInput) {
      case 7:
        return "Sunday";
        break;
      case 1:
        return "Monday";
        break;
      case 2:
        return "Tuesday";
        break;
      case 3:
        return "Wednesday";
        break;
      case 4:
        return "Thursday";
        break;
      case 5:
        return "Friday";
        break;
      case 6:
        return "Saturday";
        break;
      default:
        return "ERROR";
    }
  } else if (type == 1) {
    switch(intInput) {
      case 1:
        return "January";
        break;
      case 2:
        return "February";
        break;
      case 3:
        return "March";
        break;
      case 4:
        return "April";
        break;
      case 5:
        return "May";
        break;
      case 6:
        return "June";
        break;
      case 7:
        return "July";
        break;
      case 8:
        return "August";
        break;
      case 9:
        return "September";
        break;
      case 10:
        return "October";
        break;
      case 11:
        return "November";
        break;
      case 12:
        return "December";
        break;
      default:
        return "ERROR";
    }
  } else {
    return "ERROR";
  }
}

// // Returns a list of events within the range parameters specified.
// List<TrackerEvent> getEventsForRange(DateTime start, DateTime end) {
//   final days = daysInRange(start, end);
//
//   return [
//     for (final d in days) ...getEventsForDay(d),
//   ];
// }
//
// int _countSobriety() {
//   int out = 0;
//   bool eventExists? = true;
//
//
//   return out;
// }
// // Returns a list containing the event on the specified day parameter.
// List<TrackerEvent> _getEventsForDay(DateTime day) {
//   var events = tracker_events_list[day];
//
//   if (events == null) {
//     return [];
//   } else {
//     return [events];
//   }
//
//   // return kEvents[day] ?? [];
// }
//
// // Returns a list of events within the range parameters specified.
// List<TrackerEvent> _getEventsForRange(DateTime start, DateTime end) {
//   final days = daysInRange(start, end);
//
//   return [
//     for (final d in days) ..._getEventsForDay(d),
//   ];
// }
//
// /// A LinkedHashMap of events where each DateTime is mapped to an Event.
// /// The map uses 'isSameDay' to compare any new DateTime entries to those already in the map.
// /// the 'isSameDay' function ignores time, making all the DateTime keys totally date based.
// final tracker_events_list = LinkedHashMap<DateTime, TrackerEvent>(
//   equals: isSameDay,
//   hashCode: getHashCode,
// )..addAll(sample_events_map);
//
// final dates = <DateTime>[
//   DateTime.utc(tracker_today.year, tracker_today.month, tracker_today.day),
//   DateTime.utc(tracker_today.year, tracker_today.month, tracker_today.day-1),
//   DateTime.utc(tracker_today.year, tracker_today.month, tracker_today.day-2),
//   DateTime.utc(tracker_today.year, tracker_today.month, tracker_today.day-3),
// ];
//
// final sample_events_map = Map<DateTime, TrackerEvent>.fromIterable(
//   dates,
//   key: (item) => item,
//   value: (item) => TrackerEvent(STATUS_FAILURE)
// );
//
//
// /// Returns a number calculated from a DateTime.
// int getHashCode(DateTime key) {
//   return key.day * 1000000 + key.month * 10000 + key.year;
// }
//
//