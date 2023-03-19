import 'dart:async';
import 'package:flutter/material.dart';
import 'package:noe_more/utils.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';


/// This runs the MyApp Widget.
void main() {
  runApp(MyApp());
}

/// The MyApp Widget creates a basic app theme and then loads the
/// InitialPage Widget as the first page the user sees.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Noe More App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          textTheme: Typography.whiteCupertino,
        ),
        home: InitialPage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  // // store app wide variables and things here.
  // // for more widget specific variables/ changes, use a stateful widget.
  // var sobrietyStatusList = <DateTime, bool>{};
  // var timeSober = 0;
  //
  // // Add a date
  // void toggleDateStatus(DateTime dateTime, bool status) {
  //   if (sobrietyStatusList.containsKey(dateTime)) {
  //     sobrietyStatusList.update(dateTime, (value) => status);
  //   } else {
  //     sobrietyStatusList[dateTime] = status;
  //   }
  //   notifyListeners();
  // }
}


/// The initial 'loading screen' of the app.
/// Consists of our motto along with our name.
class InitialPage extends StatefulWidget {
  @override
  State<InitialPage> createState() => _InitialPageState();
}

/// InitialPage State for timer and widgets.
class _InitialPageState extends State<InitialPage> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // 4 second timer for the loading screen to show our motto/name.
    // Set to zero for testing the rest of the app.
    timer = Timer(
      const Duration(seconds: 4),
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage()
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height / 2.6,),

            Column(
              children: <Widget>[
                Text('You are worth it.', style: TextStyle(color: Colors.white, fontSize: 30.0)),
                Text('You are loved.', style: TextStyle(color: Colors.white, fontSize: 30.0)),
              ],
            ),

            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text('The Burkett & Lad Group', style: TextStyle(color: Colors.white70, fontSize: 14.0)),
              ),
            ),

            SizedBox(height: 1.0,),
          ],
        ),
      ),
    );
  }
}

/// The HomePage is the home base for the app's functionality.
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Noe More', style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from listview.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              leading: Icon(Icons.home,),
              title: Text('Page 1'),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      body: TrackerPage(),
      // body: Center(
      //   child: Column(
      //     children: <Widget>[
      //       SizedBox(height: 50,),
      //       Text('Testing'),
      //     ],
      //   ),
      // )
    );
  }
}

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
    var appState = context.watch<MyAppState>();

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
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay,
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

