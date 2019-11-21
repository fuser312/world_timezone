import 'package:flutter/material.dart';
import 'package:world_timezone/main.dart';
class SelectLocationScreen extends StatefulWidget {
  final List allLocations;
  SelectLocationScreen(this.allLocations);
  @override
  _SelectLocationScreenState createState() => _SelectLocationScreenState();
}

  final textController = TextEditingController();

class _SelectLocationScreenState extends State<SelectLocationScreen> {

  @override
  void initState() {
    textController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller : textController,


          ),
        ),
        body: Center(
          child: ListView.builder(
              itemCount: widget.allLocations.where((x) => x.toLowerCase().contains(textController.text)).toList().length,
              itemBuilder: (context, index){
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        (context),
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                              location: widget.allLocations
                                  .where((x) => x.contains(textController.text))
                                  .toList()[index],
                            )
                        )
                    );
                  },
                  dense: true,
                  title: Center(
                    child: Text(
                        widget.allLocations.where((x) => x.toLowerCase().contains(textController.text)).toList()[index]),
                  ),
                );
              }
          ),
        ),
      ),
    );

  }
  @override
  void dispose() {
//    myController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

}


