import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:noe_more/screens/home_page.dart';
import 'package:provider/provider.dart';


// Deprecated main function.
// /// This runs the MyApp Widget.
// void main() {
//   runApp(MyApp());
// }

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
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Noe More App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          textTheme: Typography.whiteCupertino,
        ),
        home: MyHomePage(),
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


// /// The initial 'loading screen' of the app.
// /// Consists of our motto along with our name.
// class InitialPage extends StatefulWidget {
//   @override
//   State<InitialPage> createState() => _InitialPageState();
// }
//
// /// InitialPage State for timer and widgets.
// class _InitialPageState extends State<InitialPage> {
//   Timer? timer;
//
//   @override
//   void initState() {
//     super.initState();
//     // 4 second timer for the loading screen to show our motto/name.
//     // Set to zero for testing the rest of the app.
//     timer = Timer(
//       const Duration(seconds: 4),
//           () {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//               builder: (context) => MyHomePage()
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     timer?.cancel();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.black,
//         height: MediaQuery.of(context).size.height,
//         child: Column(
//           children: <Widget>[
//             SizedBox(height: MediaQuery.of(context).size.height / 2.6,),
//
//             Column(
//               children: <Widget>[
//                 Text('You are worth it.', style: TextStyle(color: Colors.white, fontSize: 30.0)),
//                 Text('You are loved.', style: TextStyle(color: Colors.white, fontSize: 30.0)),
//               ],
//             ),
//
//             Expanded(
//               child: Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Text('The Burkett & Lad Group', style: TextStyle(color: Colors.white70, fontSize: 14.0)),
//               ),
//             ),
//
//             SizedBox(height: 1.0,),
//           ],
//         ),
//       ),
//     );
//   }
// }

