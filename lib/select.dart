import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sushiProjectZero/detection.dart';

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
    return SafeArea(
        child: Scaffold(
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
              Expanded(flex: 2, child: Container()),
              // Expanded(flex:3,
              //     child: Container(
              //   decoration: BoxDecoration(
              //       color: Colors.blueAccent,
              //       shape: BoxShape.rectangle,
              //       borderRadius: BorderRadius.circular(100)),
              // )),
              Expanded(
                flex: 3,
                child: RaisedButton(
                  onPressed: () {
                    var rount = new MaterialPageRoute(
                        builder: (BuildContext contex) => new StaticImage2());
                    Navigator.of(context).push(rount);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  child: Center(
                      child: Text(
                    "Go to Sushi Detection",
                    style: TextStyle(fontSize: 30),
                  )),
                ),
              ),
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 3,
                child: RaisedButton(
                  onPressed: () {
                    var rount = new MaterialPageRoute(
                        builder: (BuildContext contex) => new StaticImage2());
                    Navigator.of(context).push(rount);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                      color: Colors.orangeAccent,
                  child: Center(
                      child: Text(
                    "Go to Sushi Detection",
                    style: TextStyle(fontSize: 30),
                  )),
                ),
              ),
              Expanded(flex: 2, child: Container()),
            ],
          ),
        ),
      ),
    ));
  }
}

// Column(
//   children: [
//     Container(

//         child: RaisedButton(
//           onPressed: () {
//             var rount = new MaterialPageRoute(
//                 builder: (BuildContext contex) => new StaticImage2());
//             Navigator.of(context).push(rount);
//           },
//           child: Center(
//               child: Text(
//             "Go to Sushi Detection",
//             style: TextStyle(fontSize: 30),
//           )),
//           color: Colors.orange[700],
//         )),
//     Container(

//         child: RaisedButton(
//           onPressed: () {
//             var rount = new MaterialPageRoute(
//                 builder: (BuildContext contex) => new SecondPage());
//             Navigator.of(context).push(rount);
//           },
//           child: Center(
//               child: Text(
//             "Go to Sushi Summary",
//             style: TextStyle(fontSize: 30),
//           )),
//           color: Colors.pink[500],
//         )),
//   ],
// )
