import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';
import 'package:flutter/services.dart';
import 'package:timezone/standalone.dart';


void main() => runApp(MaterialApp(
  theme: ThemeData(
    primarySwatch: Colors.black,
  ),
  home : TimeZonesWorld()
));

class TimeZonesWorld extends StatefulWidget {
  @override
  _TimeZonesWorldState createState() => _TimeZonesWorldState();
}

class _TimeZonesWorldState extends State<TimeZonesWorld> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void setup() async {
    LocationDatabase locationData = LocationDatabase();
    var byteData = await rootBundle.load('packages/timezone/data/2019b.tzf');
    initializeDatabase(byteData.buffer.asUint8List());
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Select Time Zone"),
          actions: <Widget>[
            Icon(Icons.search,
            color: Colors.white),
          ],
        ),
      ),
    );
  }
}

