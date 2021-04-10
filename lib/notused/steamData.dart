// This is test of data streaming
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sushiProjectZero/notused/testtf.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  StreamController<List> list = StreamController<List>.broadcast();
  StreamSubscription<List> streamSubscriptionList;
   List showList;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  MaterialButton(
                    color: Colors.yellow,
                    child: Text("SubscirbeToList"),
                    onPressed: () {
                      Stream stream = list.stream;
                      streamSubscriptionList = stream.listen((value) {
                        print("Value from the controller list $value");
                        
                      });
                    },
                  ),
                  MaterialButton(
                    color: Colors.blue[200],
                    child: Text("tf lite"),
                    onPressed: () {
                      list.add(["lol"]);
                    },
                  ),
                  MaterialButton(
                    color: Colors.green[200],
                    child: Text("add Value"),
                    onPressed: () {
                      list.sink.add(["lol2"]);
                    },
                  ),
                  MaterialButton(
                    color: Colors.red[200],
                    child: Text("unsub list"),
                    onPressed: () {
                      streamSubscriptionList.cancel();
                      print("unsub from list");
                    },
                  ),
                ],
              ),
              Row(
                children: [
                 
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
