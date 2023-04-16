import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:noe_more/screen_utils/tracker_utils.dart';


/// The Tracker page consists of important sobriety tracking information
/// such as a calendar, sobriety counter, and quotes.
class TrackerPage extends StatefulWidget {
  @override
  _TrackerPageState createState() => _TrackerPageState();
}

/// Tracker Page State class.
class _TrackerPageState extends State<TrackerPage> {
  TextStyle quoteStyle = TextStyle(color: Color(0xFF899BC0), fontSize: 16); // 0xFF7D91BA

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Calendar Tracker',
          style: TextStyle(color: Colors.white),
        ),

        backgroundColor: Color(0xFF06294A),
        elevation: 0.0,
      ),

      backgroundColor: Color(0xFF06294A),

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 20.0),
              color: Color(0xFF06294A),
              child: Column(
                children: [
                  Text(
                    'Be watchful; taken by surprise',
                    style: quoteStyle,
                  ),
                  Text(
                    'How many fall, no more to rise!',
                    style: quoteStyle,
                  ),
                  Text(
                    "The storm that wakes the passion's glow",
                    style: quoteStyle,
                  ),
                  Text(
                    'Shall lay the tender lily low.',
                    style: quoteStyle,
                  ),
                ],
              ),
            ),

            Card(
              color: Color(0xFF055680),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
              margin: EdgeInsets.fromLTRB(110.0, 8.0, 110.0, 0.0),

              child: ListTile(
                leading: Text(
                  "0",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0
                  )
                ),
                title: Text(
                  "Days Sober",
                  style: TextStyle(color: Colors.white)
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  // // Defining some basic variables for the calendar.
  // CalendarFormat _calendarFormat = CalendarFormat.month;
  // DateTime _focusedDay = DateTime.now();
  // DateTime? _selectedDay;
  // late final ValueNotifier<List<TrackerEvent>> _selectedEvents;
  // RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  // DateTime? _rangeStart;
  // DateTime? _rangeEnd;
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   _selectedDay = _focusedDay;
  //   _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  // }
  //
  // @override
  // void dispose() {
  //   _selectedEvents.dispose();
  //   super.dispose();
  // }
  //
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
  // List<TrackerEvent> _getEventsForRange(DateTime start, DateTime end) {
  //   final days = daysInRange(start, end);
  //
  //   return [
  //     for (final d in days) ..._getEventsForDay(d),
  //   ];
  // }
  //
  // void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
  //   if (!isSameDay(_selectedDay, selectedDay)) {
  //     setState(() {
  //       _selectedDay = selectedDay;
  //       _focusedDay = focusedDay;
  //       _rangeStart = null; // Important to clean those
  //       _rangeEnd = null;
  //       _rangeSelectionMode = RangeSelectionMode.toggledOff;
  //     });
  //
  //     _selectedEvents.value = _getEventsForDay(selectedDay);
  //   }
  // }
  //
  // void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
  //   setState(() {
  //     _selectedDay = null;
  //     _focusedDay = focusedDay;
  //     _rangeStart = start;
  //     _rangeEnd = end;
  //     _rangeSelectionMode = RangeSelectionMode.toggledOn;
  //   });
  //
  //   // `start` or `end` could be null
  //   if (start != null && end != null) {
  //     _selectedEvents.value = _getEventsForRange(start, end);
  //   } else if (start != null) {
  //     _selectedEvents.value = _getEventsForDay(start);
  //   } else if (end != null) {
  //     _selectedEvents.value = _getEventsForDay(end);
  //   }
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   //var appState = context.watch<MyAppState>();
  //   print(tracker_events_list.toString());
  //
  //   return Scaffold(
  //     body: Container(
  //       color: Colors.blueGrey,
  //       height: MediaQuery.of(context).size.height,
  //       width: MediaQuery.of(context).size.width,
  //       child: Column(
  //         children: <Widget>[
  //           Container(
  //             padding: EdgeInsets.all(20),
  //             color: Colors.blueGrey,
  //             child: Column(
  //               children: [
  //                 Text(
  //                   'Be watchful; taken by surprise',
  //                   style: TextStyle(color: Colors.white, fontSize: 16),
  //                 ),
  //                 Text(
  //                   'How many fall, no more to rise!',
  //                   style: TextStyle(color: Colors.white, fontSize: 16),
  //                 ),
  //                 Text(
  //                   "The storm that wakes the passion's glow",
  //                   style: TextStyle(color: Colors.white, fontSize: 16),
  //                 ),
  //                 Text(
  //                   'Shall lay the tender lily low.',
  //                   style: TextStyle(color: Colors.white, fontSize: 16),
  //                 ),
  //               ],
  //             ),
  //           ),
  //
  //
  //           Container(
  //             padding: EdgeInsets.all(10),
  //             color: Colors.deepPurpleAccent,
  //             child: Text(
  //               '0 Days Sober',
  //               // '${appState.timeSober} Days Sober',
  //               style: TextStyle(color: Colors.white, fontSize: 20),
  //             ),
  //           ),
  //
  //
  //           Container(
  //             padding: EdgeInsets.all(2),
  //
  //             child: TableCalendar<TrackerEvent>(
  //               focusedDay: _focusedDay,
  //               firstDay: tracker_first_day,
  //               lastDay: tracker_last_day,
  //
  //               locale: "en_US",  // USA Language calendar.
  //               headerStyle: HeaderStyle(
  //                   formatButtonVisible: false,
  //                   titleCentered: true),
  //               availableGestures: AvailableGestures.all, // Allows finger gestures to navigate calendar.
  //
  //               onDaySelected: _onDaySelected,  // Updates the selected day and selected day events variables.
  //               selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
  //
  //
  //
  //
  //               rangeStartDay: _rangeStart,
  //               rangeEndDay: _rangeEnd,
  //               calendarFormat: _calendarFormat,
  //               rangeSelectionMode: _rangeSelectionMode,
  //               eventLoader: _getEventsForDay,
  //               startingDayOfWeek: StartingDayOfWeek.sunday,
  //               calendarStyle: CalendarStyle(
  //                 // Use 'CalendarStyle' to customize the UI.
  //                 outsideDaysVisible: false,
  //               ),
  //
  //               onRangeSelected: _onRangeSelected,
  //               onFormatChanged: (format) {
  //                 if (_calendarFormat != format) {
  //                   setState(() {
  //                     _calendarFormat = format;
  //                   });
  //                 }
  //               },
  //               onPageChanged: (focusedDay) {
  //                 _focusedDay = focusedDay;
  //               },
  //             ),
  //           ),
  //
  //
  //           Container(
  //             padding: EdgeInsets.all(3.0),
  //             child: Row(
  //               children: [
  //                 Expanded(
  //                   child: Text((() {
  //                     if(_selectedEvents.value.isEmpty == true) {
  //                       return "" + _selectedDay.toString().split(" ")[0] + "  No Status";
  //                     } else {
  //                       return "" + _selectedDay.toString().split(" ")[0] + "  " + _selectedEvents.value.first.toString();
  //                     }
  //                   } ())),
  //                   // child: Text("" + _selectedDay.toString().split(" ")[0] + "  " + _selectedEvents.value.first.toString()),
  //                 ),
  //                 Text("Edit"),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}