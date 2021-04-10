import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

void main() {
  runApp(new MaterialApp(
    home: new NewStaticImage(),
    theme: ThemeData.dark(),
  ));
}

class NewStaticImage extends StatefulWidget {
  @override
  _NewStaticImageState createState() => _NewStaticImageState();
}

class _NewStaticImageState extends State<NewStaticImage> {
  File _image;
  List _recognitions;
  List show = [];

  bool _busy;
  double _imageWidth, _imageHeight;

  final picker = ImagePicker();

  // this function loads the model
  loadTfModel() async {
    await Tflite.loadModel(
      //model: "models/ssd_mobilenet.tflite",
      //labels: "models/labels.txt",
      model: "assets/detect.tflite",
      labels: "assets/labelmap.txt",
    );
  }

  // this function detects the objects on the image
  detectObject(File image) async {
    var recognitions = await Tflite.detectObjectOnImage(
        path: image.path, // required
        model: "SSDMobileNet",
        // 500 each
        imageMean: 127.5,
        imageStd: 127.5,
        threshold: 0.4, // defaults to 0.1
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
      _recognitions = recognitions;
      showList.clear();
      reload();
    });
  }

  void reload() {
    setState(() {
      print("reloaded");
    });
  }

  void remove() {
    setState(() {
      //showList;
      showList.insert(0, "r");
      print("clear");
    });
  }

  void add() {
    setState(() {
      //showList;
      showList.clear();
      showList.add("lol");
      print("add");
    });
  }

  void addlist(context) {
    setState(() {
      showList.add(context);
      print("add");
    });
  }

  //String parentString = 'parent String';
  // List parentString = [];
  // void parentChange(newString) {
  //   setState(() {
  //     parentString.add(newString);
  //   });
  // }

  @override
  void initState() {
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

  List showList = [];
  List showListAdd = [];
  List a = [];
  List combiList = [];
  // display the bounding boxes over the detected objects
  List<Widget> renderBoxes(Size screen) {
    if (_recognitions == null) return [];
    if (_imageWidth == null || _imageHeight == null) return [];
    if (showList == null) return [];

    double factorX = screen.width;
    //double factorY = _imageHeight / _imageHeight * screen.width;
    double factorY = _imageHeight / _imageHeight * screen.width / 3;
    Color blue = Colors.blue;

//don't understatn suka...
    return _recognitions.map((re) {
      if (re["confidenceInClass"] > 0.50) {
        setState(() {
          showList.add("${re["detectedClass"]}");
        });

        //print("$showList");
      }

      return Container(
        child: Positioned(
            left: re["rect"]["x"] * factorX,
            top: re["rect"]["y"] * factorY,
            width: re["rect"]["w"] * factorX,
            height: re["rect"]["h"] * factorY,
            child: ((re["confidenceInClass"] > 0.50))
                ? Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: blue,
                      width: 3,
                    )),
                    child: Text(
                      "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
                      style: TextStyle(
                        background: Paint()..color = blue,
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  )
                : Container()),
      );
    }).toList();
  }

  // List<Widget> showAllList() {
  //   if (_recognitions == null) return [];
  //   return _recognitions.map((re) {
  //     return Container(
  //         //Text("${re["detectedClass"]}"),
  //         child: ((re["confidenceInClass"] > 0.50))
  //             ? Container(
  //                 child: Text("${re["detectedClass"]}"),
  //               )
  //             : Container());
  //   }).toList();
  // }

  /// show all list dont' dele

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<Widget> stackChildren = [];
    List<Widget> stackChildren2 = [];

    stackChildren.add(Positioned(
      // using ternary operator
      child: _image == null
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Please Select an Image"),
                ],
              ),
            )
          : // if not null then
          Container(child: Image.file(_image)),
    ));

    stackChildren.addAll(renderBoxes(size));
    //stackChildren2.addAll(showAllList());

    if (_busy) {
      stackChildren.add(Center(
        child: CircularProgressIndicator(),
      ));
    }

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Container(
              //color: Colors.red,
              child: Row(
                children: [
                  //for tf lite
                  Expanded(
                      child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: stackChildren,
                        ),
                        Column(
                          children: [
                            RaisedButton(onPressed: () {
                              getImageFromCamera();
                              //combiList.add(parentString);
                            }),
                            //Text("$showList")
                          ],
                        ),
                      ],
                    ),
                  )),
                  //for select sushi
                  Expanded(
                      child: Column(
                    children: [
                      Expanded(
                          child: Container(
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    Text("$showList"),
                                    Expanded(
                                        child: FlatButton(
                                      child: Image.asset(
                                        "assets/maguro.jpg",
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                      onPressed: () {
                                        //addlist("salmon");
                                        //showList.add("salmon");
                                      },
                                    )),
                                  ],
                                )),
                              ],
                            )),
                            Expanded(
                                child: Column(
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    Expanded(
                                      child: FlatButton(
                                        child: Image.asset(
                                          "assets/saba.jpg",
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                        onPressed: () {
                                          //addlist("saba");
                                          //showList.add("saba");
                                          setState(() {
                                            showList.add("sada");
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                              ],
                            )),
                          ],
                        ),
                      )),
                    ],
                  ))
                ],
              ),
            )), //ef foe pic
            Expanded(
                child: Container(
              child: Row(
                children: [
                  // Expanded(
                  //     child: Container(
                  //   child: Showlist(showList: parentString),
                  // )),
                  Expanded(
                      child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount: 2,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: 70,
                                  margin: EdgeInsets.all(2),
                                  color: Colors.blue[400],
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: Text("$showList"),
                                            ),
                                          ),
                                          Expanded(
                                            child: RaisedButton(
                                              onPressed: () {
                                                remove();
                                              },
                                              color: Colors.red,
                                              child: Container(
                                                child:
                                                    Icon(Icons.delete_forever),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Container(
                                          child:
                                              Image.asset("assets/salmon.jpg"),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        Expanded(
                            child: Container(
                                // child: NewCal(itemHolder: ""),
                                ))
                      ],
                    ),
                  )),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  // gets image from camera and runs detectObject
  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image Selected");
      }
    });
    detectObject(_image);
  }
  // gets image from gallery and runs detectObject

}
