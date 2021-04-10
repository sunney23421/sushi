import 'dart:async';

import 'package:flutter/material.dart';

class Cal extends StatefulWidget {
  //Cal({Key key}) : super(key: key);
  int price;
  Cal(this.price);

  @override
  //_CalState createState() => _CalState();
  State<StatefulWidget> createState() {
    return _CalState(this.price);
  }
}

class _CalState extends State<Cal> {
  _CalState(this.price);
  int price; //requirq value yess

  String answer;
  String answerTemp;
  String inputFull;
  String operator;
  bool calculateMode;
  int netTotal = 0;

  @override
  void initState() {
    answer = "0";
    operator = "";
    answerTemp = "";
    inputFull = "";
    calculateMode = false;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          color: Colors.blue,
          child: Column(
            children: [
              Expanded(
                  child: Container(
                color: Colors.blue,
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                            child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text("Totla price is",
                                  style: TextStyle(
                                      //fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text(" $price",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text("Paid",
                                  style: TextStyle(
                                      //fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text("$answer",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ))),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Change",
                            style: TextStyle(
                                //fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Text("$netTotal ",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        Text("Bath",
                            style: TextStyle(
                                //fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ],
                    )),
                  ],
                ),
              )), //show ans
              //ans
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.orange[100],
                  child: Column(
                    children: [
                      Row(children: <Widget>[
                        buildNumberButton("7", onTap: () {
                          addNumberToAnswer(7);
                        }),
                        buildNumberButton("8", onTap: () {
                          addNumberToAnswer(8);
                        }),
                        buildNumberButton("9", onTap: () {
                          addNumberToAnswer(9);
                        }),
                      ]),
                      Row(children: <Widget>[
                        buildNumberButton("4", onTap: () {
                          addNumberToAnswer(4);
                          //addOperatorToAnswer("-");
                        }),
                        buildNumberButton("5", onTap: () {
                          addNumberToAnswer(5);
                        }),
                        buildNumberButton("6", onTap: () {
                          addNumberToAnswer(6);
                        }),
                        // buildNumberButton("−", numberButton: false, onTap: () {
                        //   addOperatorToAnswer("-");
                        // }),
                      ]),
                      Row(children: <Widget>[
                        buildNumberButton("1", onTap: () {
                          addNumberToAnswer(1);
                        }),
                        buildNumberButton("2", onTap: () {
                          addNumberToAnswer(2);
                        }),
                        buildNumberButton("3", onTap: () {
                          addNumberToAnswer(3);
                        }),
                      ]),
                      Row(children: <Widget>[
                        buildNumberButton("⌫", onTap: () {
                          removeAnswerLast();
                          answer = "0";
                          netTotal = 0;
                        }),
                        buildNumberButton("0", onTap: () {
                          addNumberToAnswer(0);
                        }),
                        buildNumberButton(">", onTap: () {}),
                      ]),
                    ],
                  ),
                ),
              ),
              // Expanded(
              //     flex: 1,
              //     child: Row(
              //       children: [
              //         Expanded(
              //             child: RaisedButton(
              //           color: Colors.red,
              //           onPressed: () {
              //             removeAnswerLast();
              //           },
              //         )),
              //         Expanded(
              //             child: RaisedButton(
              //           color: Colors.green,
              //           onPressed: () {
              //             removeAnswerLast();
              //           },
              //         )),
              //       ],
              //     ))
            ],
          )),
    );
  }

  Expanded buildNumberButton(String str,
      {@required Function() onTap, bool numberButton = true}) {
    Widget widget;
    if (numberButton == "+") {
    } else {
      if (numberButton) {
        widget = Container(
            margin: EdgeInsets.all(1),
            child: Material(
                color: Colors.red[300],
                child: InkWell(
                    onTap: onTap,
                    splashColor: Colors.orange[200],
                    child: Container(
                        height: 60, //expaded fixed
                        child: Center(
                            child: Text(str,
                                style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold)))))));
      } else {
        widget = Container(
            margin: EdgeInsets.all(1),
            child: Material(
                color: Colors.orange,
                child: InkWell(
                    onTap: onTap,
                    splashColor: Colors.orange[200],
                    child: Container(
                        height: 70,
                        child: Center(
                            child:
                                Text(str, style: TextStyle(fontSize: 28)))))));
      }
    }

    return Expanded(child: widget);
  }

  void removeAnswerLast() {
    if (answer == "0") {
      // Not do anything.
    } else {
      setState(() {
        if (answer.length > 1) {
          answer = answer.substring(0, answer.length - 1);
          if (answer.length == 1 && (answer == "." || answer == "-")) {
            answer = "0";
          }
        } else {
          answer = "0";
        }
      });
    }
  }

  void addNumberToAnswer(int number) {
    setState(() {
      // if (number == 0 && answer == "0") {
      //   // Not do anything.
      // } else if (number != 0 && answer == "0") {
      //   answer = number.toString();
      // } else {
      //   answer += number.toString();
      // }
      if (answer.length < 4) {
        if (number == 0 && answer == "0") {
          // Not do anything.
        } else if (number != 0 && answer == "0") {
          answer = number.toString();
        } else {
          answer += number.toString();
        }
        netTotal = int.parse(answer) - price;
        print(int.parse(answer) - price);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Error"),
                    Text("too much for sushi price"),
                  ],
                ),
              ),
            );
          },
        );
        //print("why");
      }
    });
  }

  // void addOperatorToAnswer(String op) {
  //   setState(() {
  //     if (answer != "0" && !calculateMode) {
  //       calculateMode = true;
  //       answerTemp = answer;
  //       inputFull += operator + " " + answerTemp;
  //       operator = op;
  //       answer = "";
  //     } else if (calculateMode) {
  //       if (answer.isNotEmpty) {
  //         calculate();
  //         answerTemp = answer;
  //         inputFull = "";
  //         operator = "";
  //       } else {
  //         operator = op;
  //       }
  //     }
  //   });
  // }

  // void calculate() {
  //   setState(() {
  //     if (calculateMode) {
  //       bool decimalMode = false;
  //       double value = 0;

  //       if (operator == "+") {
  //         value = (double.parse(answerTemp) + double.parse(answer));
  //       } else if (operator == "-") {
  //         value = (double.parse(answerTemp) - double.parse(answer));
  //       } else if (operator == "×") {
  //         value = (double.parse(answerTemp) * double.parse(answer));
  //       } else if (operator == "÷") {
  //         value = (double.parse(answerTemp) / double.parse(answer));
  //       }

  //       if (!decimalMode) {
  //         answer = value.toInt().toString();
  //       } else {
  //         answer = value.toString();
  //       }

  //       calculateMode = false;
  //       operator = "";
  //       answerTemp = "";
  //       inputFull = "";
  //     }
  //   });
  // }
}
