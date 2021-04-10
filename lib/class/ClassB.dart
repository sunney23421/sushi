import 'dart:async';

import 'package:flutter/material.dart';

class ClassB extends StatefulWidget {
  ClassB({Key key}) : super(key: key);

  @override
  _ClassBState createState() => _ClassBState();
}

class _ClassBState extends State<ClassB> {
  StreamController<double> controller = StreamController<double>.broadcast();
  StreamSubscription<double> streamSubscription;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: Colors.green,
      child: MaterialButton(
        color: Colors.pink[200],
        child: Text("Subscribe"),
        onPressed: () {
          Stream stream = controller.stream;
          streamSubscription = stream.listen((value) {
            print("Value from the controller $value");
          }); // this is for show the result
        },
      ),
    ));
  }
}
