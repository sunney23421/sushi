import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _textFieldController = TextEditingController();
  final GlobalKey<TodoList> _key = GlobalKey();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Colors.pink[100], title: Text('Todo List')),
      body: TodoListS(
        key: _key,
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: () => _displayDialog(context)),
    );
  }

  _displayDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Insert Your to do'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "ie. Wash dishes"),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('ADD'),
                onPressed: () {
                  /*var todo =  Todo(title: _textFieldController.value.text);
                  todol.setTodo(todo);*/

                  _key.currentState
                      .setTodo(Todo(title: _textFieldController.text));
                  setState(() {});
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
//end class

class Todo {
  String title;

  Todo({
    this.title,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
      };
}
//End class
class TodoListS extends StatefulWidget {
  TodoListS({Key key}) : super(key: key);
  @override
  TodoList createState() => TodoList();
}

class TodoList extends State<TodoListS> {
  List<Todo> todos = [Todo(title: 'Checktheicon'), Todo(title: 'help me')];

  void setTodo(Todo todo) {
    todos.add(todo);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(todos[index].title),
          //leading: Icon(todos[index].icons),
        );
      },
    );
  }
}
