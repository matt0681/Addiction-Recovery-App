import 'dart:async';
import 'package:english_words/english_words.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
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
  var selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedPageIndex) {
      case 0: // The main home page. Not sure what this will be yet.
        page = Placeholder();
        break;
      case 1: // This will be the calendar tracker page.
        page = TrackerPage();
        break;
      case 2: // This will be the Map page.
        page = Placeholder();
        break;
      default:
        throw UnimplementedError('no widget for $selectedPageIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Noe More'),
          // actions: <Widget>[
          //   TextButton(
          //     child: Icon(Icons.home),
          //     onPressed: () {
          //       print('Selected Home Page');
          //       print(selectedPageIndex);
          //       selectedPageIndex = 0;
          //     },
          //   ),
          //   TextButton(
          //     child: Icon(Icons.calendar_month),
          //     onPressed: () {
          //       print('Selected Tracker Page');
          //       print(selectedPageIndex);
          //       selectedPageIndex = 1;
          //     },
          //   ),
          //   TextButton(
          //     child: Icon(Icons.people),
          //     onPressed: () {
          //       print('Selected Connection Page');
          //       print(selectedPageIndex);
          //       selectedPageIndex = 2;
          //     },
          //   ),
          // ],

        ),
        body: page,
      );
    });
  }
}


class TrackerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Container(
        color: Colors.black,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Text('TRACKER PAGE'),

            // SizedBox(height: MediaQuery.of(context).size.height / 2.6,),
            //
            // Column(
            //   children: <Widget>[
            //     Text('You are worth it.', style: TextStyle(color: Colors.white, fontSize: 30.0)),
            //     Text('You are loved.', style: TextStyle(color: Colors.white, fontSize: 30.0)),
            //   ],
            // ),
            //
            // Expanded(
            //   child: Align(
            //     alignment: Alignment.bottomCenter,
            //     child: Text('The Burkett & Lad Group', style: TextStyle(color: Colors.white70, fontSize: 14.0)),
            //   ),
            // ),
            //
            // SizedBox(height: 1.0,),
          ],
        ),
      ),
    );
  }
}
