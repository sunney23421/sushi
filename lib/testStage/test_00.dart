import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter',
    home: StaticImage(),
    theme: ThemeData.dark(),
  ));
}

class StaticImage extends StatefulWidget {
  @override
  _StaticImageState createState() => _StaticImageState();
}

//decal value
List list = [];

class _StaticImageState extends State<StaticImage> {
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
    });
  }

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

  void addItemToList() {
    setState(() {});
  }

  // display the bounding boxes over the detected objects
  List<Widget> renderBoxes(Size screen) {
    if (_recognitions == null) return [];
    if (_imageWidth == null || _imageHeight == null) return [];

    double factorX = screen.width;
    double factorY = _imageHeight / _imageHeight * screen.width;

    Color blue = Colors.blue;

    return _recognitions.map((re) {
      list.add("${re["detectedClass"]}");
      //print(list);
      //look

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
                      width: 4,
                    )),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
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
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Widget> stackChildren = [];

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
          Column(
              children: [
                Container(
                  child: Image.file(_image),
                ),
                Container(
                  child: Text("$list"),
                ),
              ],
            ),
    ));

    stackChildren.addAll(renderBoxes(size));

    if (_busy) {
      stackChildren.add(Center(
        child: CircularProgressIndicator(),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Object Detector"),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
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
            heroTag: "Fltbtn1",
            child: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                // names.removeAt(0);
              });
            },
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Stack(
                children: stackChildren,
              ),
            ),
          ),
          Expanded(
              child: Container(
            color: Colors.orange,
            child: Column(
              children: [
                Row(
                  children: [
                    RaisedButton(onPressed: () {
                      print(list);
                    }),
                    Text("$list"),
                  ],
                ),
                Row(
                  children: [
                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          list.add("value1");
                          print(list);
                        });
                      },
                      child: Text("add value into list"),
                    ),
                    Text(" $list"),
                  ],
                ),
                Row(
                  children: [
                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          list.clear();
                          print("clear list");
                        });
                      },
                      child: Text("clear list"),
                    ),
                    Text(" $list"),
                  ],
                ),
                Row(
                  children: [
                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          return _recognitions.map((re) {
                            list.add("${re["detectedClass"]}");
                          });
                        });
                      },
                      child: Text("lol list"),
                    ),
                    Text(" $list"),
                  ],
                )
              ],
            ),
          ))
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
      } else {
        print("No image Selected");
      }
    });
    detectObject(_image);
  }
}
