//this page test class call another class
import 'package:flutter/material.dart';
import 'package:sushiProjectZero/class/ClassA.dart';
import 'package:sushiProjectZero/class/ClassB.dart';
import 'package:sushiProjectZero/class/ClassC.dart';
import 'package:sushiProjectZero/class/ClassD.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    ClassA(),
                    ClassB(),
                  ],
                ),
              ),//end row 1
              Expanded(
                child: Row(
                  children: [
                    ClassC(),
                    ClassD(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
