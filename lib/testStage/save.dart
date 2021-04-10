import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: TODOApp(),
        ),
      ),
    );
  }
}

class TODOApp extends StatefulWidget {
  TODOApp({Key key}) : super(key: key);

  @override
  _TODOAppState createState() => _TODOAppState();
}

class _TODOAppState extends State<TODOApp> {
  TextEditingController _todoController = TextEditingController();
  List<String> todoList = List();
  bool _isLoading = false;

  _saveList(list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList("key", list);

    return true;
  }

  _getSavedList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList("key") != null)
      todoList = prefs.getStringList("key");
    setState(() {});
  }

  @override
  void initState() {
   
    super.initState();
    setState(() {
      _isLoading = true;
    });
    _getSavedList();

    setState(() {
      _isLoading = false;
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () {
                  _saveList(todoList);
                  Navigator.of(context).pop(true);
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Add Items',
                        ),
                        controller: _todoController,
                        onSubmitted: (text) {
                          // do what you want with the text
                          todoList.add(_todoController.text);
                          _todoController.clear();
                          setState(() {});
                        },
                      ),
                    ),
                    todoList == null
                        ? Container(
                            child: Center(
                              child: Text('Please Add the items'),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: todoList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(todoList[index]),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
      ),
    );
  }
}
