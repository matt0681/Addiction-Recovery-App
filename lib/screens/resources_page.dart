import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// This page is for listing various sobriety resources to the user as well
/// as affiliate links and other important information.
class ResourcesPage extends StatefulWidget {
  @override
  State<ResourcesPage> createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {

  Future<void> _launchURL(String url) async {
    print("Clicking the card worked and the onTap led to this function.");
    Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  // This is the current listing/storage method for the different resources.
  // [Title, SubTitle, Affiliate(0=false,1=true), Link, Image?]
  final List<List<String>> _resourceList = [
    ["Classic AA Book", "Used by all North American AA groups.", "0", "https://flutter.dev/", "Book"],
    ["North American AA Official Website", "Has helped Alcoholics recover since 1995.", "0", "https://flutter.dev/", "Website"],
    ["Classic AA Book", "Used by all North American AA groups.", "1", "https://flutter.dev/", "Book"],
    ["North American AA Official Website", "Has helped Alcoholics recover since 1995.", "1", "https://flutter.dev/", "Website"],
  ];

  bool _searchBoolean= false;
  List<int> _searchIndexList = [];

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
            onTap: () => _launchURL(_resourceList[index][3]),
          ),
        );
      },
    );
  }

  Widget _searchListView() {
    return ListView.builder(
      itemCount: _searchIndexList.length,
      itemBuilder: (context, index) {
        index = _searchIndexList[index];
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
      }
    );
  }

  Widget _searchTextField() {
    return TextField(
      autofocus: true,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
        ),
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Color(0xFF7D91BA),
          fontSize: 18,
        ),
      ),

      // This provides logic for the search bar.
      // It sees if any of the resources contain the searched string.
      onChanged: (String s) {
        setState(() {
          _searchIndexList = [];
          for(int i = 0; i < _resourceList.length; i++) {
            if((_resourceList[i][0].toLowerCase()).contains(s.toLowerCase())) {
              _searchIndexList.add(i);
            }
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // This extra logic is to change colors, sizes, and icons when something
      // is searched for in the top appbar.
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
                _searchIndexList = [];
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

      body: !_searchBoolean ? _defaultListView() : _searchListView(),
    );
  }
}

