import WidgetKit
import SwiftUI
import Intents

struct FlutterData: Decodable, Hashable {
    let text: String
   
}

struct FlutterData2: Decodable, Hashable {
    let text2: String
    //var todoList : [String] = []
}

//TODO 大きさが３種類あるけど、一番小さいものはいらないかも



//いくつかを定義する
struct SimpleEntry: TimelineEntry {
    let date: Date
    let flutterData: FlutterData?
    let flutterData2: FlutterData2?
}

struct Provider: IntentTimelineProvider {
    //初めて出現するときのためのWidget　＝＞　例とかどのように記載するのかを記載。
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), flutterData: FlutterData(text: "例)　6月21日　哲学概論レポート提出"),flutterData2: FlutterData2(text2: "")
        )
    }

    //ダミーデータなどプレビュー用のWidget
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), flutterData: FlutterData(text: "例)　6月21日　哲学概論レポート提出"),flutterData2: FlutterData2(text2: "")
        )
        completion(entry)
    }

    //getTimelineは、現在の時間と何時間おきに更新するかなどのメソッド
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
     //   var todoList : [String] = []
        
        //通信部分には、UserDefaultsを使用します
        let sharedDefaults = UserDefaults.init(suiteName: "group.com.ryutaro")
        var flutterData: FlutterData? = nil
        var flutterData2: FlutterData2? = nil
        
        if(sharedDefaults != nil) {
            do {
              let shared = sharedDefaults?.string(forKey: "widgetData")
              if(shared != nil){
                let decoder = JSONDecoder()
                flutterData = try decoder.decode(FlutterData.self, from: shared!.data(using: .utf8)!)
                flutterData2 = try decoder.decode(FlutterData2.self, from: shared!.data(using: .utf8)!)
              }
            } catch {
              print(error)
            }
        }

        let currentDate = Date()
        let entryDate = Calendar.current.date(byAdding: .hour, value: 24, to: currentDate)!
        let entry = SimpleEntry(date: entryDate, flutterData: flutterData, flutterData2: flutterData2)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

//SwiftUIを使用してWidgetをレンダリング（もとになる情報を整形して表示）する役割
struct FlutterWidgetEntryView : View {
    var entry: Provider.Entry
    
    private var FlutterDataView: some View {
        Text(entry.flutterData!.text)
            
    }
    
    private var FlutterDataView2: some View {
        Text(entry.flutterData2!.text2)
    }
    
    private var NoDataView: some View {
      Text("")
    }
    
    var body: some View {
      if(entry.flutterData == nil) {
        NoDataView
      } else {
        Text("TODOリスト一覧")
        Divider()
        FlutterDataView
        Divider()
      }
    }
}

//種類や、表示名や説明などの他の構成を設定できる。
@main
struct FlutterWidget: Widget {
    let kind: String = "FlutterWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            FlutterWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Flutter Example Widget")
        .description("This is an example widget which communicates with a Flutter App.")
    }
}

struct FlutterWidget_Previews: PreviewProvider {
    static var previews: some View {
        FlutterWidgetEntryView(entry: SimpleEntry(date: Date(), flutterData: nil, flutterData2: nil))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
