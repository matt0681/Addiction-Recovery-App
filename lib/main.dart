import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:noe_more/screens/home_page.dart';


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

      home: MyHomePage(),
    );
  }
}

