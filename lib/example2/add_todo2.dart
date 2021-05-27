import 'package:flutter/material.dart';

class TodoAddPage3 extends StatefulWidget {

  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage3> {
  String _text = '';
  double _currentSliderValue = 20;
  int SliderValue = 0;
  DateTime _date = new DateTime.now();
  String color = '';

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2016),
        lastDate: new DateTime.now().add(new Duration(days: 360))
    );
    if(picked != null) {
      setState(() {
        _date = picked;
        print(picked);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10,top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.blue,size: 40,),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Spacer(),
                ],
              ),

              Spacer(),
              Text('内容 (15文字以内)',style: TextStyle(fontSize: 25),),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Container(
                  color: Colors.grey.shade100,
                  child: TextField(
                    maxLines: 1,
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _text = value;
                      });
                    },
                  ),
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('時間：${_date.month}月${_date.day}日',style: TextStyle(fontSize: 25),),
                ],
              ),

              RaisedButton(onPressed: () => _selectDate(context),child: Text('日付選択')),
              Spacer(),

              /*
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('重要度：',style: TextStyle(fontSize: 30),),
                  Text('$SliderValue',style: TextStyle(fontSize: 30),),
                ],
              ),
              Slider(
                value: _currentSliderValue,
                min: 0,
                max: 100.0,
                divisions: 10,
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                    SliderValue =  _currentSliderValue.toInt();
                  });
                },
              ),
               */
              Text('種類 :  $color',style: TextStyle(fontSize: 30),),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          color = '🔴';
                        });
                      },
                      child: Text('🔴',style: TextStyle(fontSize: 40),),
                    ),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          color = '🟡';
                        });
                      },
                      child: Text('🟡',style: TextStyle(fontSize: 40),),
                    ),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          color = '🟢';
                        });
                      },
                      child: Text('🟢',style: TextStyle(fontSize: 40),),
                    ),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          color = '🔵';
                        });
                      },
                      child: Text('🔵',style: TextStyle(fontSize: 40),),
                    ),
                  ],
                ),
              ),

              Spacer(),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Container(
                  // 横幅いっぱいに広げる
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.08 ,
                  // リスト追加ボタン
                  child: ElevatedButton(
                    onPressed: () {
                      if (_text == '' || color == '') {
                        //ダイアログを出す。
                        print("空だよ");
                        if (_text.length >= 15) {
                          print('文字数を15文字以内にしてください');
                        }

                      }else{
                        print(_text.length);
                        final post ='$color  ${_date.month}/${_date.day}  $_text';
                        // $SliderValue%
                        Navigator.of(context).pop(post);
                       // WidgetKit.setItem('widgetData', jsonEncode(FlutterWidgetData(post)), 'group.com.ryutaro');
                       // WidgetKit.reloadAllTimelines();
                      }
                    },
                    child: Text('リスト追加',style: TextStyle(fontSize: 25 ,color: Colors.white),),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Container(
                  // 横幅いっぱいに広げる
                  width: double.infinity,
                  // キャンセルボタン
                  child: TextButton(
                    // ボタンをクリックした時の処理
                    onPressed: () {
                      //TODO キャンセルダイアログを出す
                      Navigator.of(context).pop();
                    },
                    child: Text('キャンセル',style: TextStyle(fontSize: 20),),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  //TODO ダイアログを出す。（空の時と文字数制限の時）
  
}

//