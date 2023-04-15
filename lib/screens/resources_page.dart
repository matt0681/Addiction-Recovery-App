import 'package:flutter/material.dart';


class ResourcesPage extends StatefulWidget {
  @override
  State<ResourcesPage> createState() => _ResourcesPageState();
}


class _ResourcesPageState extends State<ResourcesPage> {

  final List<List<String>> _resourceList = [
    ["Classic AA Book", "Used by all North American AA groups."],
    ["North American AA Official Website", "Has helped Alcoholics recover since 1995."]
  ];

  bool _searchBoolean= false;

  Widget _defaultListView() {
    return ListView.builder(
      itemCount: _resourceList.length,
      itemBuilder: (context, index) {
        return Card(
          color: Color(0xFF055680),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
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

  Widget _searchTextField() {
    return TextField(
      style: TextStyle(color: Color(0xFF2A5298)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: ! _searchBoolean
          ?
            const Text(
              'Resources',
              style: TextStyle(color: Colors.white),
            )
          :
            _searchTextField(),

        actions: !_searchBoolean
          ? [
            IconButton(
            icon: Icon(Icons.search_outlined),
            onPressed: () {
              setState(() {
                _searchBoolean = true;
              });
            })
        ]
        : [
          IconButton(
            icon: Icon(Icons.clear_outlined),
            onPressed: () {
              setState(() {
                _searchBoolean = false;
              });
            }
          )
        ],

        backgroundColor: Color(0xFF06294A),
        elevation: 0.0,
      ),

      backgroundColor: Color(0xFF06294A),

      body: _defaultListView(),
    );
  }
}

