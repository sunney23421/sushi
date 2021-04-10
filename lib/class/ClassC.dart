import 'package:flutter/material.dart';

class ClassC extends StatefulWidget {
  ClassC({Key key}) : super(key: key);

  @override
  _ClassCState createState() => _ClassCState();
}

class _ClassCState extends State<ClassC> {
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(color: Colors.blue,));
  }
}
