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
              leading: FlutterLogo(size: 50.0),
              title: Text(
                  'Classic AA Book',
                  style: TextStyle(color: Colors.white)),
              subtitle: Text(
                'Used by all North American AA groups.',
                style: TextStyle(color: Color(0xFF7D91BA)),
              ),
            ),
          ),

        ],
      )
    );
  }
}

