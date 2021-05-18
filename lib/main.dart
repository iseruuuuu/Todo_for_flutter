import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_for_freinds_app/example/widgetkit.dart';
import 'package:todo_for_freinds_app/example2/main2.dart';

import 'add_todo_view.dart';

void main() {
  runApp(MyApp3());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child :TodoListPage(),
      ),
    );
  }
}


class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}


class _TodoListPageState extends State<TodoListPage> {
  // Todoリストのデータ
  List<String> todoList = [];

  Future<void> sharePrefrence() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setStringList('key', todoList);
  }


  _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      todoList = prefs.getStringList('key') ?? [];

    });
  }

  @override
  void initState() {
    super.initState();
    _getPrefItems();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    setState(() {
      sharePrefrence();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('',style: TextStyle(color: Colors.blue),),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: todoList.length,

          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(todoList[index]),
              onDismissed: (direction) {
                setState(() {
                  todoList.removeAt(index);
                });

                if (direction == DismissDirection.endToStart) {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("削除しました"))
                  );
                }
              },

              child: SizedBox(
                //TODO 折り畳みが理想。
                height: 100,
                child: Card(
                  child: ListTile(
                    title: Text(todoList[index]),
                  ),
                ),
              ),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newListText = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return TodoAddPage();
            }),
          );
          if (newListText != null) {
            setState(() {
              todoList.add(newListText);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}