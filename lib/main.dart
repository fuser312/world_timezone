import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';
import 'package:flutter/services.dart';
import 'package:timezone/standalone.dart';

void main() async {
  var byteData =
  await rootBundle.load('packages/timezone/data/$tzDataDefaultFilename');
  initializeDatabase(byteData.buffer.asUint8List());
  runApp(WorldTimeZone());
}

class WorldTimeZone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.dark,
          primaryColor: Colors.black,
          accentColor: Colors.cyan[600],

      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  String location;
  HomePage({this.location = 'Asia/Kolkata'});
  @override
  _HomePageState createState() => _HomePageState();
}

List allLocations = [];
class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    initializeTimeZone();
    timeZoneDatabase.locations.keys.forEach((x) => allLocations.add(x));
    super.initState();
  }

  Future<void> initializeTimeZone() async {
    await initializeTimeZone();
  }
  String getTimeZone(String location) {
    String sign =
    TZDateTime.now(getLocation(location)).timeZoneOffset.isNegative
        ? '-'
        : '+';
    int hour =
    TZDateTime.now(getLocation(location)).timeZoneOffset.inHours.abs();
    int minute = TZDateTime.now(getLocation(location)).timeZoneOffset.inMinutes;
    return '$sign' + ' ' + '$hour' + ':' + '${minute % 60}';
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Select Time Zone'),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text('Region', style: TextStyle(fontSize: 24, color: Colors.white70),)),
                ),
                subtitle:
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text('${widget.location}  ${getTimeZone(widget.location)}', style: TextStyle(fontSize: 24, color: Colors.white70),)),
                ),
                onTap: () async {
                  dynamic newLocation = await showSearch(
                    context: context,
                    delegate: LocationsSearch(allLocations),
                  );
                  if (newLocation != null) {
                    widget.location = newLocation;
                    setState(() {});
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
  class LocationsSearch extends SearchDelegate<String> {
  final List<dynamic> cities;

  LocationsSearch(this.cities);



    @override
    List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        onPressed: () {
        query = '';
        },
        icon: Icon(Icons.close)),
    ];
  }

    @override
    Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
        },
      );
      }

    @override
    Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
    }

    @override
    Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List results = allLocations
        .where((cityName) => cityName.toLowerCase().contains(query))
        .toList();
    return ListView.builder(
     itemCount: results.length,
     itemBuilder: (context, index) {
     return ListTile(
       onTap: () {
          close(context, results[index]);
          },
      dense: true,
      title: Text(results[index]),
        );
      },
     );
    }
  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme

    return ThemeData.dark();
  }
   }






