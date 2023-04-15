import 'package:flutter/material.dart';


class ResourcesPage extends StatelessWidget {
  const ResourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xFF06294A),

      body: ListView(
        children: const <Widget>[


          Card(
            color: Color(0xFF055680),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
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


          Card(
            color: Color(0xFF055680),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),

            child: ListTile(
              leading: FlutterLogo(size: 50.0),
              title: Text(
                  'North American AA Official Website',
                  style: TextStyle(color: Colors.white)),
              subtitle: Text(
                'Has helped Alcoholics recover since 1995.',
                style: TextStyle(color: Color(0xFF7D91BA)),
              ),
            ),
          ),


        ],
      ),
    );
  }
}

