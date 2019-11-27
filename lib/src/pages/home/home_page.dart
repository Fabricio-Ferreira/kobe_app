import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kobe Movies",
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.grey[400],
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
