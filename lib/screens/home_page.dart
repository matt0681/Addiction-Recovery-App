import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:noe_more/screens/resources_page.dart';
import 'package:noe_more/screens/settings_page.dart';
import 'package:noe_more/screens/tracker_page.dart';


/// The HomePage is the home base for the app's functionality.
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 120,
            child: Text('Hello!'),
          )
        ]
      ),
    );
  }




  // int currentPageIndex = 0;
  // final pages = [
  //   TrackerPage(),
  //   ResourcesPage(),
  //   SettingsPage(),
  // ];
  //
  // @override
  // Widget build(BuildContext context) {
  //   // This widget variable holds information for the about page popup.
  //   final List<Widget> aboutBoxChildren = <Widget>[
  //     const SizedBox(height: 24),
  //     RichText(
  //       text: TextSpan(
  //         children: <TextSpan>[
  //           TextSpan(
  //             text: "Noe More is a an app dedicated to help end addictions."
  //                 'Lorem Ipsum blah blah blah'
  //                 'Lorem Ipsum blah blah blah'),
  //           TextSpan(text: '.'),
  //         ],
  //       ),
  //     ),
  //   ];
  //
  //   return Scaffold(
  //
  //     appBar: AppBar(
  //       centerTitle: true,
  //       title: const Text('Noe More', style: TextStyle(color: Colors.purple),
  //       ),
  //       backgroundColor: Colors.blueGrey,
  //     ),
  //
  //
  //     drawer: Drawer(
  //       backgroundColor: Colors.blueGrey,
  //       child: ListView(
  //         // Important: Remove any padding from listview.
  //         padding: EdgeInsets.zero,
  //         children: <Widget>[
  //
  //           DrawerHeader(
  //             child: Column(
  //               children: [
  //                 Text('Noe More', style: TextStyle(color: Colors.white, fontSize: 20)),
  //                 Text('Addiction Recovery App', style: TextStyle(color: Colors.white, fontSize: 20)),
  //               ],
  //             ),
  //           ),
  //
  //           ListTile(
  //             leading: Icon(Icons.home, color: Colors.white),
  //             title: Text('Tracker Home'),
  //             onTap: () {
  //               Navigator.pop(context);
  //               setState(() { currentPageIndex = 0; });
  //             },
  //           ),
  //
  //           ListTile(
  //             leading: Icon(Icons.file_copy, color: Colors.white),
  //             title: Text('Resources'),
  //             onTap: () {
  //               Navigator.pop(context);
  //               setState(() { currentPageIndex = 1; });
  //             },
  //           ),
  //
  //           ListTile(
  //             leading: Icon(Icons.settings, color: Colors.white),
  //             title: Text('Settings'),
  //             onTap: () {
  //               Navigator.pop(context);
  //               setState(() { currentPageIndex = 2; });
  //             },
  //           ),
  //
  //           AboutListTile(
  //             icon: const Icon(Icons.info, color: Colors.white),
  //             // applicationIcon: ,
  //             applicationName: "Noe More",
  //             applicationVersion: "April 2023",
  //             applicationLegalese: "\u{a9} 2023 The Burkett & Lad Group",
  //             aboutBoxChildren: aboutBoxChildren,
  //           ),
  //         ],
  //       ),
  //     ),
  //
  //     body: pages[currentPageIndex],
  //   );
  // }
}