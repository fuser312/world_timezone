import 'package:flutter/material.dart';
import 'main.dart';
class SelectLocationScreen extends StatefulWidget {
  final List allLocations;
  SelectLocationScreen(this.allLocations);
  @override
  _SelectLocationScreenState createState() => _SelectLocationScreenState();
}

  final TextEditingController textController = TextEditingController();

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
          backgroundColor: Colors.blue,
          title: TextField(
            controller: textController,
            decoration: InputDecoration(
              icon: Icon(
                Icons.search,
                color: Colors.blue,
              ),
              hintText: "'Search region (country/region)')",
            ),
          ),
        ),
        body: ListView.builder(
            itemCount: widget.allLocations.where((x) => x.contains(textController.text)).toList().length,
            itemBuilder: (context, index){
              return Container(
                color: Colors.white,
                child: ListTile(
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
                        widget.allLocations.where((x) => x.contains(textController.text)).toList()[index]),
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}
