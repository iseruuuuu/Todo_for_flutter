/*

import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_widgetkit/flutter_widgetkit.dart';
import 'FlutterWidgetData.dart';




class MyApp2 extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp2> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('iOS Widget Showcase'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Enter a text 🙏🏻',
              ),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: TextField(
                      controller: textController
                  )),
              RaisedButton(onPressed: () {
                WidgetKit.setItem('widgetData', jsonEncode(FlutterWidgetData(textController.text)), 'group.com.ryutaro');
                WidgetKit.reloadAllTimelines();
              }, child: Text('Update Widget 🥳')),



              RaisedButton(onPressed: () {
                WidgetKit.removeItem('widgetData', 'group.com.ryutaro');
                WidgetKit.reloadAllTimelines();
              }, child: Text('Remove Widget Data ⚠️'))
            ],
          ),
        ),
      ),
    );
  }
}


 */