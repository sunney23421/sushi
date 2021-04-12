import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sushiProjectZero/detection.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectChoice extends StatefulWidget {
  SelectChoice({Key key}) : super(key: key);

  @override
  _SelectChoiceState createState() => _SelectChoiceState();
}

class _SelectChoiceState extends State<SelectChoice> {
  @override
  Widget build(BuildContext context) {
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
                        builder: (BuildContext contex) => new SecondPage());
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
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                        onPressed: _launchURL,
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: new BorderRadius.circular(300.0)),
                        color: Colors.transparent,
                        child: LoadingBouncingGrid.square(
                          borderColor: Colors.orange,
                          borderSize: 1.0,
                          size: 60.0,
                          backgroundColor: Colors.black,
                          duration: Duration(milliseconds: 3000),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

_launchURL() async {
  const url = 'https://github.com/sunney23421/sushi';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
