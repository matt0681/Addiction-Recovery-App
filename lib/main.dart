import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:noe_more/screens/home_page.dart';
import 'package:noe_more/screens/resources_page.dart';
import 'package:noe_more/screens/settings_page.dart';
import 'package:noe_more/screens/tracker_page.dart';


/// This runs the MyApp Widget. It will load the entire app before letting the
/// user interact with it. (the 'loading'/splash screen will display to them)
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.removeAfter(initialization);

  runApp(MyApp());
}

Future initialization(BuildContext? context) async {
  await Future.delayed(Duration(seconds: 3));
}

/// The MyApp Widget creates a basic app theme and then loads the
/// InitialPage Widget as the first page the user sees.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noe More App',

      theme: ThemeData(
        fontFamily: 'Inter',
      ),

      home: HomePage(),
    );
  }
}

/// This page contains the bottom navigation bar and displays which ever
/// page is currently selected.
class HomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    TrackerPage(),
    ResourcesPage(),
    SettingsPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _widgetOptions.elementAt(_selectedIndex),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Tracker',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_library),
            label: 'Resources',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],

        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        backgroundColor: Color(0xFF2A5298),
        unselectedItemColor: Color(0xFF7D91BA),
        onTap: _onItemTapped,
      ),
    );
  }
}