import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

List list = [];

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            color: Colors.orange[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  RaisedButton(onPressed: () {
                    setState(() {
                      list.add("List");
                    });
                  }),
                  Text("Make List"),
                  Text(" $list")
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  RaisedButton(onPressed: () {
                    setState(() {
                      list.add("value1");
                    });
                  }),
                  Text("Add value List"),
                  Text(" $list")
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  RaisedButton(onPressed: () {
                    setState(() {
                      list.removeAt(1);
                    });
                  }),
                  Text("Listview,modify list"),
                  Text(" $list")
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  RaisedButton(onPressed: () {}),
                  Text("cal list"),
                  Text(" ${list.length}")
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  RaisedButton(onPressed: () {
                    setState(() {
                      list.clear();
                    });
                  }),
                  Text("clear List"),
                  Text(" $list.length")
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
