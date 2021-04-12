import 'dart:async';
import 'package:loading_animations/loading_animations.dart';
import 'package:flutter/material.dart';
import 'package:sushiProjectZero/select.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
    theme: ThemeData.dark(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => SelectChoice())));
    return SafeArea(
      child: new Scaffold(
        body: new Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.orange,
              Colors.orange[100],
              Colors.blue[100],
              Colors.blue,
            ],
          )),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Image.asset(
                  "assets/logo.png",
                  height: 200,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Tensorflow" " + " "Flutter",
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  "assets/logo_flutter.png",
                  height: 100,
                ),
                SizedBox(
                  height: 100,
                ),
                LoadingBouncingGrid.circle(
                  borderColor: Colors.orange,
                  borderSize: 3.0,
                  size: 60.0,
                  backgroundColor: Colors.orangeAccent,
                  duration: Duration(milliseconds: 2000),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
