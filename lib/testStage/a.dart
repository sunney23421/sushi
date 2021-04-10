import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//this is the test for sent list to another page and show the list
void main() {
  runApp(MaterialApp(
    title: 'Flutter',
    home: Test(),
    theme: ThemeData.dark(),
  ));
}

class Test extends StatefulWidget {
  Test({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

List c = [];

class _TestState extends State<Test> {
  @override
  List a = ["a", "b", "c"];
  List b = ["d", "e", "f"];

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Container(
      color: Colors.red[200],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {
                setState(() {
                  c.add(a);
                  
                });
              },
              child: Text("add list A into list C"),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  c.add(b);
                });
              },
              child: Text("add list B into list C"),
            ),
            // RaisedButton(
            //   child: Text('Save'),
            //   onPressed: () {
            //     _save();
            //   },
            // ),
            // RaisedButton(
            //   child: Text('Read'),
            //   onPressed: () {
            //     _read();
            //   },
            // ),
            // RaisedButton(
            //   child: Text('clear'),
            //   onPressed: () {
            //     setState(() {
            //       _clear();
            //     });
            //   },
            // ),
            Container(
              width: 500,
              height: 500,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: c.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.orange[100],
                      child: Row(
                        children: [
                          Text("${c[index]}"),
                          RaisedButton(
                            onPressed: () {
                              setState(() {
                                print("${c[index]}");
                                print(c);
                                c.remove(c[index]);
                              });
                            },
                            color: Colors.red,
                          )
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    )));
  }

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key';
    final value = prefs.getStringList(key) ?? "empty";
    print('read: $value');
  }

  _save() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key';
    final value = c;
    prefs.setStringList(key, value); //need to sev ethe list to another pafe
    //but it's doesn't work,, only one list
    print('saved $value');
  }

  _clear() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key';
    final value = prefs.getStringList(key) ?? "empty";
    await prefs.clear();
    print('clear');
    print('clear $value');
  }
}
