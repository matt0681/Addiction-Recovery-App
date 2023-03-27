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
  // Defining some basic variables for the calendar.
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late final ValueNotifier<List<Event>> _selectedEvents;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    var events = kEvents[day];

    if (events == null) {
      return [];
    } else {
      return [events];
    }

    // return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }



  @override
  Widget build(BuildContext context) {
    //var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Container(
        color: Colors.black,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            SizedBox(height: 3,),

            Container(
              padding: EdgeInsets.all(20),
              color: Colors.black,
              child: Column(
                children: [
                  Text(
                    'Be watchful; taken by surprise',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    'How many fall, no more to rise!',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    "The storm that wakes the passion's glow",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    'Shall lay the tender lily low.',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),

            SizedBox(height: 5,),

            Container(
              padding: EdgeInsets.all(10),
              color: Colors.black,
              child: Text(
                '0 Days Sober',
                // '${appState.timeSober} Days Sober',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),

            SizedBox(height: 5,),

            Container(
              padding: EdgeInsets.all(2),

              child: TableCalendar<Event>(
                focusedDay: _focusedDay,
                firstDay: utilsFirstDay,
                lastDay: utilsLastDay,

                locale: "en_US",
                headerStyle: HeaderStyle(
                    formatButtonVisible: false, titleCentered: true),



                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                rangeStartDay: _rangeStart,
                rangeEndDay: _rangeEnd,
                calendarFormat: _calendarFormat,
                rangeSelectionMode: _rangeSelectionMode,
                eventLoader: _getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                calendarStyle: CalendarStyle(
                  // Use 'CalendarStyle' to customize the UI.
                  outsideDaysVisible: false,
                ),
                onDaySelected: _onDaySelected,
                onRangeSelected: _onRangeSelected,
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

            const SizedBox(height: 8.0),

            Expanded(
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          onTap: () => print('${value[index]}'),
                          title: Text('${value[index]}'),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}