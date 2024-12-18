//
//  Live_Activity.swift
//  Live Activity
//
//  Created by sardar saqib on 06/12/2024.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for minutesOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minutesOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct Live_ActivityEntryView : View {
    var entry: Provider.Entry
    let currentDate = Date()
    

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)

            Text("Emoji:")
            let formattedTime = entry.date.formatted(.dateTime.hour().minute())
            if formattedTime == "17:11" {
                Text("one miniute update")
            }
            else if formattedTime == "17:12" {
                Text("two miniute update")
                    .onAppear {
                        do {
                           try LiveActivityManager.startActivity()
                        }
                        catch {
                            print(error.localizedDescription)
                        }
                    }
            }
            else if formattedTime == "17:11" {
                Text("three miniute update")
            }
            else {
                Text(entry.emoji)
            }
            
          
        }
    }
}

struct Live_Activity: Widget {
    let kind: String = "Live_Activity"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                Live_ActivityEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                Live_ActivityEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    Live_Activity()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
