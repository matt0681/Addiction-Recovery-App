import 'package:flutter/material.dart';


class ResourcesPage extends StatelessWidget {

  final List<List<String>> _resourceList = [
    ["Classic AA Book", "Used by all North American AA groups."],
    ["North American AA Official Website", "Has helped Alcoholics recover since 1995."]
  ];

  Widget _defaultListView() {
    return ListView.builder(
      itemCount: _resourceList.length,
      itemBuilder: (context, index) {
        return Card(
          color: Color(0xFF055680),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),

          child: ListTile(
            leading: FlutterLogo(size: 50.0),
            title: Text(
                _resourceList[index][0],
                style: TextStyle(color: Colors.white)),
            subtitle: Text(
              _resourceList[index][1],
              style: TextStyle(color: Color(0xFF7D91BA)),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xFF06294A),

      body: _defaultListView(),
    );
  }
}

