import 'package:flutter/material.dart';
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