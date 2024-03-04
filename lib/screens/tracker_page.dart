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

  // Defining some variables for the calendar.
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late final ValueNotifier<TrackerEvent> _selectedEvent;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  final TrackerStorage calendarStorage = TrackerStorage();

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvent = ValueNotifier(calendarStorage.getEvent(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvent.dispose();
    super.dispose();
  }

  // When you select a day a popup card will appear asking to select that day's
  // status. You can select Success, neutral, or failure. The app will then create
  // an event for that day and display the corresponding status color.
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    if (selectedDay.isAfter(DateTime.now())) {
      // If the selected day is in the future, show an error dialog
      showDialog(
        context: context,
        builder: (context) =>
            Dialog(
              insetPadding: EdgeInsets.all(70.0),
              backgroundColor: Color(0xFF2A5298),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Text("Error",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),

                      SizedBox(height: 4.0),

                      Text("Statuses cannot be added to the future.",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),

                      SizedBox(height: 6.0),

                      TextButton(
                        style: ButtonStyle(),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('OK',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),

                    ],
                ),
              ),
            ),
      );
      return; // Exit the function without adding the event
    }

    showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          Dialog(
            insetPadding: EdgeInsets.all(70.0),
            backgroundColor: Color(0xFF2A5298),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Text("Set your status for",
                    style: TextStyle(color: Colors.white),
                  ),

                  Text("${getNameFromDateInt(0, selectedDay.weekday)}, "
                      "${getNameFromDateInt(1, selectedDay.month)} ${selectedDay.day}, "
                      "${selectedDay.year}",
                    style: TextStyle(color: Colors.white,),
                  ),

                  SizedBox(height: 8.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        style: ButtonStyle(),
                        onPressed: () {
                          calendarStorage.addEvent(STATUS_SUCCESS, selectedDay);
                          Navigator.pop(context);
                          _updateSelectedEvent(selectedDay);
                        },
                        child: Text('Success', style: TextStyle(color: Color(
                            0xFF00ff00))),
                      ),
                      TextButton(
                        onPressed: () {
                          calendarStorage.deleteEvent(selectedDay);
                          Navigator.pop(context);
                          _updateSelectedEvent(selectedDay);
                        },
                        child: Text('Neutral', style: TextStyle(color: Colors
                            .grey)),
                      ),
                      TextButton(
                        onPressed: () {
                          calendarStorage.addEvent(STATUS_FAILURE, selectedDay);
                          Navigator.pop(context);
                          _updateSelectedEvent(selectedDay);
                        },
                        child: Text('Failure', style: TextStyle(color: Color(
                            0xFFff3300))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      );

    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
    }

    // _selectedEvents.value = _getEventsForDay(selectedDay);
    _updateSelectedEvent(selectedDay);
  }

  void _updateSelectedEvent(DateTime selectedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = selectedDay;
      _rangeStart = null;
      _rangeEnd = null;
      _rangeSelectionMode = RangeSelectionMode.toggledOff;
      _selectedEvent.value = calendarStorage.getEvent(selectedDay);
    });
  }

  List<TrackerEvent> _getEventsForDay(DateTime date) {
    List<TrackerEvent> out = [];
    out.add(calendarStorage.getEvent(date));
    return out;
  }

  // // Handles a selected range logic.
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
  //     _selectedEvents.value = getEventsForRange(start, end);
  //   } else if (start != null) {
  //     _selectedEvents.value = getEventsForDay(start);
  //   } else if (end != null) {
  //     _selectedEvents.value = getEventsForDay(end);
  //   }
  // }

  // The set style for displayed quotes.
  TextStyle quoteStyle = TextStyle(color: Color(0xFF7D91BA), fontSize: 16); // 0xFF7D91BA, 0xFF899BC0

  // The current storage method for displayed quotes.
  final List<String> _quoteList = [
    "Be watchful; taken by surprise\nHow many fall, no more to rise!\nThe storm that wakes the passion's glow\nShall lay the tender lily low.",
    "Quote #2",
    "Quote #3",
  ];

  // The main graphics handler/scaffolding for the tracker page. Contains a
  // sobriety day counter, a quote, a title, and a calendar.
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Calendar Tracker',
          style: TextStyle(color: Colors.white),
        ),

        // actions: <Widget>[
        //   Container(
        //     padding: EdgeInsets.all(10.0),
        //     margin: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
        //     decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //         begin: Alignment.centerLeft,
        //         end: Alignment.centerRight,
        //         colors: [
        //           Color(0xFF2A5298),
        //           Color(0xFF1C3B6F),
        //         ],
        //       ),
        //       color: Color(0xFF2A5298),
        //       borderRadius: BorderRadius.circular(15.0),
        //     ),
        //     child: Center(
        //       child: Text(
        //         // '${_countSobriety()} Days Sober',
        //         '0 Days Sober',
        //         style: TextStyle(color: Colors.white),
        //       ),
        //     ),
        //   ),
        // ],

        backgroundColor: Color(0xFF06294A),
        elevation: 0.0,
      ),

      backgroundColor: Color(0xFF06294A),

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: <Widget>[
            Container(
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

            Container(
              margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 5.0),
              padding: EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                color: Color(0xFF055680),
                borderRadius: BorderRadius.circular(20.0),
              ),

              child: TableCalendar<TrackerEvent>(
                focusedDay: _focusedDay,
                firstDay: tracker_first_day,
                lastDay: tracker_last_day,

                locale: "en_US",  // USA Language calendar.
                availableGestures: AvailableGestures.all, // Allows finger gestures to navigate calendar.

                onDaySelected: _onDaySelected,  // Updates the selected day and selected day events variables.
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),

                rangeStartDay: _rangeStart,
                rangeEndDay: _rangeEnd,
                calendarFormat: _calendarFormat,
                rangeSelectionMode: _rangeSelectionMode,
                eventLoader: _getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.sunday,

                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Color(0xFF93AACE)),
                  weekendStyle: TextStyle(color: Color(0xFF93AACE)),
                ),

                sixWeekMonthsEnforced: true,

                // Sets display properties to make the app really look good.
                calendarStyle: CalendarStyle(
                  // Use 'CalendarStyle' to customize the UI.
                  outsideDaysVisible: false,
                  weekendTextStyle: TextStyle(color: Colors.white),
                  defaultTextStyle: TextStyle(color: Colors.white),
                  markersMaxCount: 1,
                  canMarkersOverflow: false,
                  // markerSizeScale: 0.35, //0.333,
                  // markerDecoration: ShapeDecoration(
                  //   color: Colors.white,
                  //   shape: CircleBorder(),
                  // ),

                  selectedDecoration: ShapeDecoration(
                    color: Color(0x006182b8), // 0xBB6182b8
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                  ),

                  todayDecoration: ShapeDecoration(
                    color: Color(0x556182b8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),

                // Certain display properties are better set in the calendar
                // builders than in the calendar style.
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) {
                    if(events.isEmpty) {
                      return SizedBox(); // return null;
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(1),
                        child: Container(
                          height: 40,
                          width: 42,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: events.first.getColor().withOpacity(0.7),
                                width: 3,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                          )
                        ),
                      );
                    }
                  },
                ),

                headerStyle: HeaderStyle(
                  titleCentered: true,
                  titleTextStyle: TextStyle(color: Colors.white),
                  formatButtonVisible: false,
                  leftChevronIcon: Icon(
                    Icons.chevron_left_outlined,
                    color: Colors.white,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right_outlined,
                    color: Colors.white,
                  ),
                ),

                //onRangeSelected: _onRangeSelected,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
            ),


            // Container(
            //   padding: EdgeInsets.all(3.0),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Text((() {
            //           if(_selectedEvents.value.isEmpty == true) {
            //             return "" + _selectedDay.toString().split(" ")[0] + "  No Status";
            //           } else {
            //             return "" + _selectedDay.toString().split(" ")[0] + "  " + _selectedEvents.value.first.toString();
            //           }
            //         } ())),
            //         // child: Text("" + _selectedDay.toString().split(" ")[0] + "  " + _selectedEvents.value.first.toString()),
            //       ),
            //       Text("Edit"),
            //     ],
            //   ),
            // ),

          ],
        ),
      ),
    );
  }
}

