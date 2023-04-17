import 'package:flutter/material.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Settings',
            style: TextStyle(color: Colors.white),
        ),

        backgroundColor: Color(0xFF06294A),
        elevation: 0.0,
      ),

      backgroundColor: Color(0xFF06294A),

      body: ListView(
        children: const <Widget>[

          Card(
            color: Color(0xFF055680),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),

            child: ListTile(
              title: Text(
                'There are no settings yet.',
                style: TextStyle(color: Colors.white)
              ),
              dense: false,
              trailing: Text(
                'OFF',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            ),
          ),

          Card(
            color: Color(0xFF055680),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            margin: EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 0.0),

            child: ListTile(
              title: Text(
                  'There are no settings yet.',
                  style: TextStyle(color: Colors.white)
              ),
              dense: false,
              trailing: Text(
                'ON',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            ),
          ),

          Card(
            color: Color(0xFF055680),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            margin: EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 0.0),

            child: ListTile(
              title: Text(
                  'There are no settings yet.',
                  style: TextStyle(color: Colors.white)
              ),
              dense: false,
              trailing: Text(
                'OFF',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            ),
          ),

          Card(
            color: Color(0xFF055680),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            margin: EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 0.0),

            child: ListTile(
              title: Text(
                  'There are no settings yet.',
                  style: TextStyle(color: Colors.white)
              ),
              dense: false,
              trailing: Text(
                'OFF',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            ),
          ),

        ],
      )
    );
  }
}

