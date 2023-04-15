import 'package:flutter/material.dart';


class ResourcesPage extends StatelessWidget {
  const ResourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("Resources page!");

    return Scaffold(
      body: ListView(
        children: const <Widget>[
          Card(
            child: ListTile(
              leading: FlutterLogo(),
              trailing: Text('Classic AA Book'),
              dense: true,
            ),
          ),
        ],
      ),
    );
  }
}

