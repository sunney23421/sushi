import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    title: 'Sushi Detection',
    home: StaticImage2(),
    theme: ThemeData.dark(),
  ));
}

class StaticImage2 extends StatefulWidget {
  @override
  _StaticImage2State createState() => _StaticImage2State();
}

//decal value,
List<String> list = []; // take all sushi name
List uniqueStrings = []; // take list and take only unique name
int salmonCount = 0;
List t = []; //summary show time
List n = []; //summary show name of sushi
List p = []; //summary show price
List c = []; //summary show count sushi

List name = []; //all name fo sushi in list
var unique = []; // get unique namae fron list

// To set the price of sushi
int crab = 10;
int eel = 10;
int squid = 10;
int inari = 10;
int omelette = 10;
int saba = 10;
int salmon = 10;
int maguro = 10;
int tuna = 10;
int wakame = 10;

// funcation to count same value in given string value
int countOccurrencesUsingLoop(List list, String element) {
  if (list == null || list.isEmpty) {
    return 0;
  }
  int count = 0;
  for (int i = 0; i < list.length; i++) {
    if (list[i] == element) {
      count++;
    }
  }
  return count;
}

// funcation to calculate Total price by given string name and amount
int price(String element, int howmany) {
  int price = 0;
  if (element == "crab") {
    price = howmany * crab;
  } else if (element == "eel") {
    price = howmany * eel;
  } else if (element == "squid") {
    price = howmany * squid;
  } else if (element == "inari") {
    price = howmany * inari;
  } else if (element == "omelette") {
    price = howmany * omelette;
  } else if (element == "saba") {
    price = howmany * saba;
  } else if (element == "salmon") {
    price = howmany * salmon;
  } else if (element == "maguro") {
    price = howmany * maguro;
  } else if (element == "tuna") {
    price = howmany * tuna;
  } else if (element == "wakame") {
    price = howmany * wakame;
  } else {
    price = 0;
  }
  return price;
}

// funcation to count total sushi amount
int totalPrice(List list) {
  if (list == null || list.isEmpty) {
    return 0;
  }
  int total = 0;
  for (int i = 0; i < list.length; i++) {
    if (list[i] == "crab") {
      total = total + crab;
    } else if (list[i] == "eel") {
      total = total + eel;
    } else if (list[i] == "squid") {
      total = total + squid;
    } else if (list[i] == "inari") {
      total = total + inari;
    } else if (list[i] == "omelette") {
      total = total + omelette;
    } else if (list[i] == "saba") {
      total = total + saba;
    } else if (list[i] == "salmon") {
      total = total + salmon;
    } else if (list[i] == "maguro") {
      total = total + maguro;
    } else if (list[i] == "tuna") {
      total = total + tuna;
    } else if (list[i] == "wakame") {
      total = total + wakame;
    } else {
      total = 0;
    }
  }
  return total;
}

int count = 0;
//cal
String answer;
String answerTemp;
String inputFull;
String operator;
bool calculateMode;
int netTotal = 0;
//en cal

class _StaticImage2State extends State<StaticImage2> {
  //variable for Tensorflow lite
  File _image;
  List _recognitions;
  bool _busy;
  double _imageWidth, _imageHeight;

  final picker = ImagePicker();

  // this function loads the model
  loadTfModel() async {
    await Tflite.loadModel(
      model: "assets/detect.tflite",
      labels: "assets/labelmap.txt",
    );
  }

  // this function detects the objects on the image
  detectObject(File image) async {
    var recognitions = await Tflite.detectObjectOnImage(
        path: image.path, // required
        model: "SSDMobileNet",
        imageMean: 127.5,
        imageStd: 127.5,
        threshold: 0.5, // defaults to 0.1
        numResultsPerClass: 10, // defaults to 5
        asynch: true // defaults to true
        );
    FileImage(image)
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
          setState(() {
            _imageWidth = info.image.width.toDouble();
            _imageHeight = info.image.height.toDouble();
          });
        })));
    setState(() {
      _recognitions = List.from(recognitions);
    });
  }

  @override
  void initState() {
    //variable for calculator
    answer = "0";
    operator = "";
    answerTemp = "";
    inputFull = "";
    calculateMode = false;
    //cal
    super.initState();
    _busy = true;
    loadTfModel().then((val) {
      {
        setState(() {
          _busy = false;
        });
      }
    });
  }

  int dele = 0;
  List<Widget> aa() {
    if (_recognitions == null) return [];
    return _recognitions.map((re) {
      int lent = _recognitions.length;
      //int dele = 0;
      if (lent > name.length && dele == 0) {
        name.add("${re["detectedClass"]}");
        //print("$lent ${name.length} $dele");
        print("asdfasdfasdf");
      }
      // if (del == false) {
      //   //name.remove("${re["detectedClass"]}");
      //   print("ok");
      // }

      // if (lent < name.length) {
      //   name.clear();
      //   netTotal = 0;
      //   answer = "0";
      // }
    }).toList();
  }

  // display the bounding boxes over the detected objects
  List<Widget> renderBoxes(Size screen) {
    if (_recognitions == null) return [];
    if (_imageWidth == null || _imageHeight == null) return [];

    Timer(Duration(seconds: 1), () {
      setState(() {
        //name.clear();
        print("waiting");
      });
    });

    //double factorX = screen.width;
    double factorX = screen.width;
    double factorY = _imageHeight / _imageHeight * screen.width;
    //double factorY = _imageHeight / _imageHeight * screen.width;

    Color blue = Colors.blue;

    return _recognitions.map((re) {
      // if (!list.any((element) => element == "${re["detectedClass"]}")) {
      //   list.add("${re["detectedClass"]}");

      print("from $name");

      return Container(
        child: Positioned(
            //left: re["rect"]["x"] * factorX,
            left: re["rect"]["x"] * 200,
            top: re["rect"]["y"] * 300,
            //width: re["rect"]["w"] * factorX,
            //height: re["rect"]["h"] * factorY,
            child: ((re["confidenceInClass"] > 0.50))
                ? Container(
                    // decoration: BoxDecoration(
                    //     border: Border.all(
                    //   color: blue,
                    //   width: 4,
                    // )),
                    child: Column(
                      children: <Widget>[
                        Text(
                          //"${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
                          "${re["detectedClass"]}",
                          style: TextStyle(
                            background: Paint()..color = blue,
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container()),
      );
      //}
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> stackChildren = [];
    List<Widget> stackChildren2 = []; // fix list add it self

    unique = name.toSet().toList(); //get uniqe name

    var bg = Colors.orange[100];

    //font size
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 2;

    stackChildren.add(Positioned(
      // using ternary operator
      child: _image == null
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text("Please Select an Image",
                          style: TextStyle(
                            fontSize: multiplier * unitHeightValue,
                          )),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FloatingActionButton(
                            heroTag: "Fltbtn2",
                            child: Icon(Icons.camera_alt),
                            onPressed: getImageFromCamera,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          FloatingActionButton(
                            heroTag: "Fltbtn1",
                            child: Icon(Icons.photo),
                            onPressed: getImageFromGallery,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : // if not null then
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.file(_image),
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FloatingActionButton(
                          heroTag: "Fltbtn2",
                          child: Icon(Icons.camera_alt),
                          onPressed: getImageFromCamera,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FloatingActionButton(
                          heroTag: "Fltbtn1",
                          child: Icon(Icons.photo),
                          onPressed: getImageFromGallery,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FloatingActionButton(
                          heroTag: "Fltbtn3",
                          backgroundColor: Colors.pink,
                          // child: Icon(Icons.bug_report),
                          child: Text("${name.length}"),
                          onPressed: () {
                            print("btn clicked");
                            print(name);

                            //here
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    ));

    stackChildren.addAll(renderBoxes(size));
    stackChildren2.addAll(aa());

    if (_busy) {
      stackChildren.add(Center(
        child: CircularProgressIndicator(),
      ));
    }
    //main page
    return Scaffold(
      appBar: AppBar(
        title: Text("Sushi Detector"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Stack(
                      children: stackChildren,
                    ),
                  ),
                ),
                //tensorflow section
                //This part show the sushi button two rows in one column
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        color: bg,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      name.add("salmon");
                                      count = count + 10;
                                      print(name);
                                      print(unique);
                                      print(count);
                                    });
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        "assets/salmon.jpg",
                                      ))),
                            ), //btn
                            Expanded(
                              child: FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      name.add("tuna");

                                      //here
                                    });
                                    print(name);
                                    _recognitions.map((re) {
                                      name.add("salmon");
                                    });
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        "assets/tuna.jpg",
                                      ))),
                            ),
                            Expanded(
                              child: FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      name.add("eel");
                                    });
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        "assets/eel.jpg",
                                      ))),
                            ),
                            Expanded(
                              child: FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      name.add("crab");
                                    });
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        "assets/crab.jpg",
                                      ))),
                            ),
                            Expanded(
                              child: FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      name.add("omelette");
                                    });
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        "assets/omelette.jpg",
                                      ))),
                            ),
                          ],
                        ),
                      )),
                      Expanded(
                          child: Container(
                        color: bg,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      name.add("squid");
                                    });
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        "assets/squid.jpg",
                                      ))),
                            ),
                            Expanded(
                              child: FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      name.add("saba");
                                    });
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        "assets/saba.jpg",
                                      ))),
                            ),
                            Expanded(
                              child: FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      name.add("inari");
                                    });
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        "assets/inari.jpg",
                                      ))),
                            ),
                            Expanded(
                              child: FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      name.add("maguro");
                                    });
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        "assets/maguro.jpg",
                                      ))),
                            ),
                            Expanded(
                              child: FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      name.add("wakame");
                                    });
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        "assets/wakame.jpg",
                                      ))),
                            ),
                            //End button
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //End row
          //Haft of the screen
          //This part show the list view, build by take the item in list
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.orange[100],
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: unique.length,
                        itemBuilder: (context, index) {
                          //return show how the List titles look like
                          return Container(
                            height: 6 * unitHeightValue,
                            //sapce  between titles
                            margin: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.blue[200],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [],
                                ),
                                Expanded(
                                  child: Container(
                                    height: 5 * unitHeightValue,
                                    width: 50,
                                    child: RaisedButton(
                                      onPressed: () {
                                        //This function for dele the list title
                                        // Everytime clike this button, it will remove itme in unique depen on index
                                        // setState because, everytime flutter need to redraw in order to show update
                                        setState(() {
                                          name.remove("${unique[index]}");
                                          dele = 2;
                                          print(name);
                                          //print(unique);
                                        }); // delete button
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(7.0)),
                                      color: Colors.red,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              // to get the name in unique list depen on index; example [a,b,c]>>a
                                              '${unique[index]}',
                                              style: TextStyle(
                                                fontSize: multiplier *
                                                    unitHeightValue,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                                //function to count how many unique has in the main list
                                                "${countOccurrencesUsingLoop(name, "${unique[index]}")} pcs",
                                                style: TextStyle(
                                                  fontSize: multiplier *
                                                      unitHeightValue,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                //Get image by take from unique list depen on index
                                                "assets/${unique[index]}.jpg"),
                                            fit: BoxFit.fitWidth),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6.0))),
                                  ),
                                ), //image
                              ],
                            ),
                          );
                        }),
                  ), //listView builber
                ), //end Tensorflow
                //Calculator
                Expanded(
                  child: Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Container(
                                    child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    color: Colors.green[200],
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Total Price",
                                            style: TextStyle(
                                                fontSize: multiplier *
                                                    unitHeightValue,
                                                fontWeight: FontWeight.bold)),
                                        // Show the total price
                                        Text("${totalPrice(name)}",
                                            style: TextStyle(
                                                fontSize: multiplier *
                                                    unitHeightValue,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.blue,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Total Paid",
                                            style: TextStyle(
                                                fontSize: multiplier *
                                                    unitHeightValue,
                                                fontWeight: FontWeight.bold)),
                                        //Show the answer from function
                                        Text("$answer",
                                            style: TextStyle(
                                                fontSize: multiplier *
                                                    unitHeightValue,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ))),
                            Expanded(
                                child: Container(
                              color: Colors.green,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Change",
                                      style: TextStyle(
                                          fontSize:
                                              multiplier * unitHeightValue,
                                          fontWeight: FontWeight.bold)),
                                  Text("$netTotal ",
                                      style: TextStyle(
                                          fontSize:
                                              multiplier * unitHeightValue,
                                          fontWeight: FontWeight.bold)),
                                  Text("Baht",
                                      style: TextStyle(
                                          fontSize:
                                              multiplier * unitHeightValue,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            )),
                          ],
                        ),
                      )), //show ans
                      //These are the numpad for calculator
                      Expanded(
                          flex: 3,
                          child: Container(
                            color: Colors.orange,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(children: <Widget>[
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
                                ),
                                Expanded(
                                  child: Row(children: <Widget>[
                                    buildNumberButton("4", onTap: () {
                                      addNumberToAnswer(4);
                                    }),
                                    buildNumberButton("5", onTap: () {
                                      addNumberToAnswer(5);
                                    }),
                                    buildNumberButton("6", onTap: () {
                                      addNumberToAnswer(6);
                                    }),
                                  ]),
                                ),
                                Expanded(
                                  child: Row(children: <Widget>[
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
                                ),
                                Expanded(
                                  child: Row(children: <Widget>[
                                    buildNumberButton("0", onTap: () {
                                      addNumberToAnswer(0);
                                    }),
                                  ]),
                                ),
                                //End numpad
                                //This button for delete input price
                                Expanded(
                                  flex: 2,
                                  child: Row(children: <Widget>[
                                    Expanded(
                                      child: FlatButton(
                                        color: Colors.red[300],
                                        height: 300,
                                        onPressed: () {
                                          removeAnswerLast();
                                          answer = "0";
                                          netTotal = 0;
                                        },
                                        child: Icon(Icons.backspace, size: 40),
                                      ),
                                    ),
                                    //This button for clear the answer
                                    Expanded(
                                      child: FlatButton(
                                        color: Colors.red,
                                        height: 300,
                                        onPressed: () {
                                          removeAnswerLast();
                                          answer = "0";
                                          netTotal = 0;
                                          setState(() {
                                            name.clear();
                                          });
                                        },
                                        child: Icon(Icons.delete, size: 40),
                                      ),
                                    ),
                                    Expanded(
                                      child: FlatButton(
                                        color: Colors.green,
                                        height: 300,
                                        onPressed: () {
                                          //the list will sent to sumary page
                                          if (netTotal >= 1 &&
                                              totalPrice(name) >= 1 &&
                                              int.parse(answer) <= 1200) {
                                            print("show showDialog");

                                            setState(
                                              () {
                                                answer = "0";
                                                netTotal = 0;
                                                dele = 2;

                                                // for summary

                                                t.add(DateFormat(
                                                        "dd-MM-yyyy hh:mm:ss")
                                                    .format(DateTime.now()));
                                                n.add("$name");
                                                p.add("${totalPrice(name)}");
                                                c.add("${name.length}");
                                                removeAnswerLast();
                                                //pass ok
                                                list.clear();
                                                uniqueStrings.clear();
                                                unique.clear();
                                                name.clear();
                                                //end summary
                                                //here
                                              },
                                            );
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                      child: Container(
                                                    width: 500,
                                                    height: 200,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      color: Colors.white,
                                                    ),
                                                    child: Column(children: [
                                                      Expanded(
                                                          child: Center(
                                                              child: Icon(
                                                                  Icons
                                                                      .check_circle_outline_rounded,
                                                                  color: Colors
                                                                      .green,
                                                                  size: 80))),
                                                      Expanded(
                                                          child: Center(
                                                              child: Text(
                                                                  "Transaction completed",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .green,
                                                                      fontSize:
                                                                          30))))
                                                    ]),
                                                  ));
                                                });
                                          } else if (netTotal < -1) {
                                            showDialog(
                                                //show the paymant is not enough
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                      child: Container(
                                                    width: 500,
                                                    height: 200,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      color: Colors.white,
                                                    ),
                                                    child: Column(children: [
                                                      Expanded(
                                                          child: Center(
                                                              child: Icon(
                                                                  Icons
                                                                      .payments_outlined,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 80))),
                                                      Expanded(
                                                          child: Center(
                                                              child: Text(
                                                                  "Payment is not enough ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize:
                                                                          25))))
                                                    ]),
                                                  ));
                                                });
                                          } else if (int.parse(answer) > 1200) {
                                            //show dialog for over paid, shold not be more that 1200 ,why customer pay more that 1200 for sushi?
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                      child: Container(
                                                    width: 500,
                                                    height: 200,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      color: Colors.white,
                                                    ),
                                                    child: Column(children: [
                                                      Expanded(
                                                          child: Center(
                                                              child: Icon(
                                                                  Icons.payment,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 80))),
                                                      Expanded(
                                                          child: Center(
                                                              child: Text(
                                                                  "Maximize paid shoud not over than $answer ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize:
                                                                          30))))
                                                    ]),
                                                  ));
                                                });
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                      child: Container(
                                                    width: 500,
                                                    height: 200,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      color: Colors.white,
                                                    ),
                                                    child: Column(children: [
                                                      Expanded(
                                                          child: Center(
                                                              child: Icon(
                                                                  Icons
                                                                      .block_outlined,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 80))),
                                                      Expanded(
                                                          child: Center(
                                                              child: Text(
                                                                  "Transaction is not complete",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize:
                                                                          25))))
                                                    ]),
                                                  ));
                                                });
                                          }
                                          //End showDialog
                                        },
                                        child: Icon(
                                          Icons.check_outlined,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                                //Button shows summary
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    child: FlatButton(
                                      color: Colors.pink[200],
                                      onPressed: () {
                                        var rount = new MaterialPageRoute(
                                            builder: (BuildContext contex) =>
                                                new SecondPage());
                                        Navigator.of(context).push(rount);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(
                                            Icons.history,
                                            size: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                //here
                                // Expanded(
                                //   child: Container(
                                //     width: double.infinity,
                                //     child: FlatButton(
                                //       color: Colors.red,
                                //       onPressed: () {
                                //         // t.add(DateFormat(
                                //         //         "dd-MM-yyyy hh:mm:ss")
                                //         //     .format(DateTime.now()));
                                //         // n.add("$name");
                                //         // p.add("${totalPrice(name)}");
                                //         // c.add("${name.length}");
                                //         // name.clear();
                                //         // print(n);
                                //         print(stackChildren);
                                //       },
                                //       child: Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.spaceAround,
                                //         children: [
                                //           Icon(
                                //             Icons.bug_report,
                                //             size: 30,
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ))
                    ],
                  )),
                ) //end me
              ],
            ),
          )
        ],
      ),
    );
  }

  // gets image from camera and runs detectObject
  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        removeAnswerLast();
        name.clear();
        dele = 0;
      } else {
        print("No image Selected");
      }
    });
    detectObject(_image);
  }

  // gets image from gallery and runs detectObject
  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        removeAnswerLast();
        name.clear();
        dele = 0;
      } else {
        print("No image Selected");
      }
    });
    detectObject(_image);
  }

  //Calcualton funcation
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
      if (int.parse(answer) < 1000) {
        if (number == 0 && answer == "0") {
          // Not do anything.
        } else if (number != 0 && answer == "0") {
          answer = number.toString();
        } else {
          answer += number.toString();
        }
        netTotal = int.parse(answer) - totalPrice(name);
        //print(int.parse(answer) - price);
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                  child: Container(
                width: 500,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
                child: Column(children: [
                  Expanded(
                      child: Center(
                          child: Icon(Icons.payment,
                              color: Colors.red, size: 80))),
                  Expanded(
                      child: Center(
                          child: Text(
                              "Maximize price shoud not over than $answer ",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 30))))
                ]),
              ));
            });
      }
    });
  }
}

//cal---------------------

//show Summary

class SecondPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SecondPageState();
  }
}

class _SecondPageState extends State<SecondPage> {
  final String titleString = "Summary";
  String time = DateFormat("dd-MM-yyyy hh:mm:ss").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(titleString),
      ),
      body: new Center(
          child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.orange,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: t
                      .length, //problem, depen on how many times i click green btn  from line 845
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.blue[200],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.blue[200],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      "Date",
                                    ),
                                  ),
                                  Center(child: Text("${t[index]}")),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.orange,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        "Pics ${c[index]} ",
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: Colors.red,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Total Price is ${p[index]}",
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.blue,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //problem show list of sushi
                                  Text(
                                    "List of sushi",
                                  ),

                                  Text(
                                    "${n[index]}",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Expanded(
                          //   flex: 1,
                          //   child: Container(
                          //     height: double.infinity,
                          //     color: Colors.red,
                          //     child: Column(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         //problem show list of sushi
                          //         RaisedButton(onPressed: () {
                          //           setState(() {
                          //             t.removeLast();
                          //           });
                          //         })
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      )),
    );
  }
}
