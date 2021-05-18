import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_widgetkit/flutter_widgetkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FlutterWidgetData2.dart';
import 'add_todo2.dart';


class MyApp3 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey.shade300,
      ),
      home: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child :TodoListPage3(),
      ),
    );
  }
}


class TodoListPage3 extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage3> {
  List<String> todoList2 = [];
  String text = '';
  bool finish = false;

  @override
  void initState() {
    super.initState();
    _getPrefItems();
    initPlatformState2();
  }
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState2() async {
    WidgetKit.reloadAllTimelines();
    WidgetKit.reloadTimelines('test');

    final data = FlutterWidgetData('例)　6月21日　哲学概論レポート提出');
    final resultString = await WidgetKit.getItem('testString', 'group.com.ryutaro');
    final resultBool = await WidgetKit.getItem('testBool', 'group.com.ryutaro');
    final resultNumber = await WidgetKit.getItem('testNumber', 'group.com.ryutaro');
    final resultJsonString = await WidgetKit.getItem('testJson', 'group.com.ryutaro');

    var resultData;
    if(resultJsonString != null) {
      resultData = FlutterWidgetData.fromJson(jsonDecode(resultJsonString));
    }

    WidgetKit.setItem('testString', 'Hello World', 'group.com.ryutaro');
    WidgetKit.setItem('testBool', false, 'group.com.ryutaro');
    WidgetKit.setItem('testNumber', 10, 'group.com.ryutaro');
    WidgetKit.setItem('testJson', jsonEncode(data), 'group.com.ryutaro');
  }
  Future<void> sharePrefrence() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setStringList('key', todoList2);
  }
  _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      todoList2 = prefs.getStringList('key') ?? [];

    });
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
      /*
      appBar: AppBar(
        title: Text('',style: TextStyle(color: Colors.blue),),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.event,color: Colors.blue,),
          onPressed: () {
            WidgetKit.setItem('widgetData', jsonEncode(FlutterWidgetData(text)), 'group.com.ryutaro');
            WidgetKit.reloadAllTimelines();
          },
        ),
         ),
         */

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 20),
        child: ListView.builder(
            itemCount: todoList2.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(todoList2[index]),
                onDismissed: (direction) {
                  setState(() {
                    todoList2.removeAt(index);
                  });
                  if (direction == DismissDirection.endToStart) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("削除しました"))
                    );
                  }
                },

                child: Card(
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(onPressed: () {
                           setState(() {
                             if (finish == false) {
                               finish = true;
                               WidgetKit.removeItem('widgetData', 'group.com.ryutaro');
                               WidgetKit.reloadAllTimelines();

                             }else{
                               finish = false;
                               //これをWidget単位でする必要がある。
                               WidgetKit.setItem('widgetData', jsonEncode(FlutterWidgetData('true')), 'group.com.ryutaro');
                               WidgetKit.reloadAllTimelines();
                             }
                           });
                        },
                          icon: Icon((finish == false) ? Icons.check_box : Icons.check_box_outline_blank),
                        ),
                        Text(todoList2[index]),
                      ],
                    ),
                  ),
                ),
              );
            }
        ),
      ),
      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () async {
            final newListText = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return TodoAddPage3();
              }),
            );
            if (newListText != null) {
              setState(() {
                todoList2.add(newListText);
                text = newListText;
              });
            }
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}