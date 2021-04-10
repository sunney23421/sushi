import 'package:flutter/material.dart';

class ClassD extends StatefulWidget {
  ClassD({Key key}) : super(key: key);

  @override
  _ClassDState createState() => _ClassDState();
}

class _ClassDState extends State<ClassD> {
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(color: Colors.pink,));
  }
}
