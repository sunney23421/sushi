import 'dart:async';

import 'package:flutter/material.dart';

class ClassA extends StatefulWidget {
  ClassA({Key key}) : super(key: key);

  @override
  _ClassAState createState() => _ClassAState();
}

class _ClassAState extends State<ClassA> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: Colors.red,
    ));
  }
}
