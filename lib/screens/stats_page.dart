import 'package:flutter/material.dart';
import 'package:noe_more/screen_utils/tracker_utils.dart';


/// This page serves as a sobriety statistics dashboard for the user.
class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  // Returns a list containing the event on the specified day parameter.
  List<TrackerEvent> _getEventsForDay(DateTime day) {
    var events = tracker_events_list[day];

    if (events == null) {
      return [];
    } else {
      return [events];
    }
  }

  // Calculates the percentage of days sober in the current week. The current
  // week is defined as the last 7 days with today as the 7th. It will return
  // a floating point number as the percentage.
  String _getPercentSoberThisWeek() {

    DateTime start = DateTime.utc(2023, 6, 11);
    DateTime end = DateTime.now();

    final days = daysInRange(start, end);

    List<TrackerEvent> weekEvents = [for (final d in days) ..._getEventsForDay(d)];

    int count = 0;
    for(TrackerEvent event in weekEvents) {
      if (event.status == Null || event.status == STATUS_NEUTRAL || event.status == STATUS_SUCCESS) {
        count += 1;

      } else {
        count += 0;
      }
    }

    return (7 / count).toString();
  }

  // % this month

  // % this year

  // current streak

  // previous streak

  // max streak

  // min streak



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
        children: <Widget>[

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
                _getPercentSoberThisWeek(),
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

