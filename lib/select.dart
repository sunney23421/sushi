import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sushiProjectZero/backUp/fixedtf.dart';
import 'package:sushiProjectZero/main.dart';
import 'package:sushiProjectZero/notused/tflite.dart';
import 'package:sushiProjectZero/testStage/test_00.dart';

class SelectChoice extends StatefulWidget {
  SelectChoice({Key key}) : super(key: key);

  @override
  _SelectChoiceState createState() => _SelectChoiceState();
}

class _SelectChoiceState extends State<SelectChoice> {
  @override
  Widget build(BuildContext context) {
    double wigthH = MediaQuery.of(context).size.width;
    double heightH = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      child: Row(
        children: [
          Column(
            children: [
              Container(
                  width: wigthH,
                  height: heightH / 2,
                  child: RaisedButton(
                    onPressed: () {
                      var rount = new MaterialPageRoute(
                          builder: (BuildContext contex) => new StaticImage2());
                      Navigator.of(context).push(rount);
                    },
                    child: Center(
                        child: Text(
                      "Go to Sushi Detection",
                      style: TextStyle(fontSize: 30),
                    )),
                    color: Colors.orange[700],
                  )),
              Container(
                  width: wigthH,
                  height: heightH / 2,
                  child: RaisedButton(
                    onPressed: () {
                      var rount = new MaterialPageRoute(
                          builder: (BuildContext contex) => new SecondPage());
                      Navigator.of(context).push(rount);
                    },
                    child: Center(
                        child: Text(
                      "Go to Sushi Summary",
                      style: TextStyle(fontSize: 30),
                    )),
                    color: Colors.pink[500],
                  )),
            ],
          )
        ],
      ),
    ));
  }
}
