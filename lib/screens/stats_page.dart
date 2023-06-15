import 'package:flutter/material.dart';

/// This page serves as a sobriety statistics dashboard for the user.
class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  // This is the graphics/scaffold section.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Statistics',
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
                '% Abstinent this week',
                style: TextStyle(color: Colors.white)
              ),
              dense: false,
              trailing: Text(
                '10%',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            ),
          ),

          Card(
            color: Color(0xFF055680),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),

            child: ListTile(
              title: Text(
                  '% abstinent this month',
                  style: TextStyle(color: Colors.white)
              ),
              dense: false,
              trailing: Text(
                '20%',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            ),
          ),

          Card(
            color: Color(0xFF055680),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),

            child: ListTile(
              title: Text(
                  '% abstinent this year',
                  style: TextStyle(color: Colors.white)
              ),
              dense: false,
              trailing: Text(
                '50%',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            ),
          ),

          Card(
            color: Color(0xFF055680),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),

            child: ListTile(
              title: Text(
                  'Current Streak',
                  style: TextStyle(color: Colors.white)
              ),
              dense: false,
              trailing: Text(
                '1 day',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            ),
          ),

          Card(
            color: Color(0xFF055680),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),

            child: ListTile(
              title: Text(
                  'Previous streak',
                  style: TextStyle(color: Colors.white)
              ),
              dense: false,
              trailing: Text(
                '10 days',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            ),
          ),

          Card(
            color: Color(0xFF055680),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),

            child: ListTile(
              title: Text(
                  'Maximum streak',
                  style: TextStyle(color: Colors.white)
              ),
              dense: false,
              trailing: Text(
                '3 months',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            ),
          ),

          Card(
            color: Color(0xFF055680),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),

            child: ListTile(
              title: Text(
                  'Minimum streak',
                  style: TextStyle(color: Colors.white)
              ),
              dense: false,
              trailing: Text(
                '20 minutes',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            ),
          ),

        ],
      )
    );
  }
}

