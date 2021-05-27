class FlutterWidgetData {
  final String text2;

  FlutterWidgetData(this.text2);

  FlutterWidgetData.fromJson(Map<String, dynamic> json) : text2 = json['text'];

  Map<String, dynamic> toJson() =>
      {
        'text': text2,
      };
}

/*
class FlutterWidgetData2 {
  final List<String> todoList2 = [];

  FlutterWidgetData2(this.todoList2);

  FlutterWidgetData2.fromJson(Map<List<String>, dynamic> json) : todoList2 = json['text2'];

  Map<List<String>, dynamic> toJson() =>
      {
        'text2' : todoList2,
      };
}
 */


