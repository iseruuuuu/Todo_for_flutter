import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_widgetkit/flutter_widgetkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FlutterWidgetData2.dart';
import 'add_todo2.dart';

class MyApp3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
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
  String listString = '';

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
      //TODO todoList2をなんとかしてStringにすることで行けそう？？
      // listString = todoList2.map((e) => listString).join('');
      WidgetKit.setItem('widgetData', jsonEncode(FlutterWidgetData(todoList2.join('\n'))), 'group.com.ryutaro');
      WidgetKit.reloadAllTimelines();
    });
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    setState(() {
      sharePrefrence();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 20),
        child: ListView.builder(
            itemCount: todoList2.length,
            itemBuilder: (context, index) {
              return Dismissible(
                // スワイプ方向がendToStart（画面左から右）の場合のバックグラウンドの設定
                background: Container(
                  alignment: Alignment.centerLeft,
                  color: Colors.greenAccent[700],
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                    child:  Icon(Icons.thumb_up, color: Colors.white),),),
                // スワイプ方向がstartToEnd（画面右から左）の場合のバックグラウンドの設定
                secondaryBackground: Container(
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
                    child:  Icon(Icons.restore_from_trash, color: Colors.white),
                  ),
                ),
                key: Key(todoList2[index]),
                onDismissed: (direction) {
                  setState(() {
                    //どちらにせよ消えてしまう。
                    todoList2.removeAt(index);
                  });
                  // スワイプ方向がendToStart（画面左から右）の場合の処理
                  if (direction == DismissDirection.endToStart) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("削除しました"))
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade200)
                      ),
                      child: ListTile(
                        title: FlatButton(
                          onPressed: () {
                            WidgetKit.setItem('widgetData', jsonEncode(FlutterWidgetData(todoList2.join('\n'))), 'group.com.ryutaro');
                            WidgetKit.reloadAllTimelines();
                            print(index);
                          },
                          child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(todoList2[index],style: TextStyle(fontSize: 15),)),
                        ),
                      ),
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