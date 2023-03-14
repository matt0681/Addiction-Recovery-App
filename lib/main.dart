import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

// This runs the MyApp Widget.
void main() {
  runApp(MyApp());
}

// The MyApp Widget creates a basic app theme and then loads the
// InitialPage Widget as the first page the user sees.
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
  // store app wide variables and things here.
  // for more widget specific variables/ changes, use a stateful widget.
  var failedDates = <DateTime>[];
  var timeSober = 0;

  void toggleFailedDate(DateTime dateTime) {
    if (failedDates.contains(dateTime)) {
      failedDates.remove(dateTime);
    } else {
      failedDates.add(dateTime);
    }
    notifyListeners();
  }
}


class InitialPage extends StatefulWidget {
  @override
  State<InitialPage> createState() => _InitialPageState();
}


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


class TrackerPage extends StatefulWidget {
  @override
  _TrackerPageState createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  DateTime? _selectedCalendarDate;
  DateTime? _focusedCalendarDate;

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
            SizedBox(height: 5,),

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

            SizedBox(height: 10,),

            Container(
              padding: EdgeInsets.all(10),
              color: Colors.black,
              child: Text(
                '${appState.timeSober} Days Sober',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),

            SizedBox(height: 10,),

            Container(
              padding: EdgeInsets.all(2),

              child: TableCalendar(
                focusedDay: focusedDay,
                firstDay: DateTime.utc(2000, 1, 1),
                lastDay: DateTime.utc(2100, 1, 1),

                calendarFormat: CalendarFormat.month,
                headerVisible: true,

                calendarStyle: CalendarStyle(
                  weekendTextStyle: TextStyle(color: Colors.white),
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),

                // selectedDayPredicate: (selectedDay) {
                //   return (isSameDay(_selectedCalendarDate!, selectedDay));
                // },
                // onDaySelected: (selectedDay, focusedDay) {
                //   if (!isSameDay(_selectedCalendarDate, selectedDay)) {
                //     setState(() {
                //       _selectedCalendarDate = selectedDay;
                //       _focusedCalendarDate = focusedDay;
                //     });
                //   }
                // },
              ),
            ),


          ],
        ),
      ),
    );
  }
}
