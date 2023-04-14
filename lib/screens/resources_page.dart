import 'package:flutter/material.dart';


class ResourcesPage extends StatelessWidget {
  const ResourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("Resources page!");

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              child: Text(
                "Hello There! RESOURCES PAGE",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
            ),

            Container(
              child: Text(
                "Hello There! RESOURCES PAGE",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
            ),

            Container(
              child: Text(
                "Hello There! RESOURCES PAGE",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      )
    );
  }
}

