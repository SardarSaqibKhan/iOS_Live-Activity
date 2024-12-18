//
//  Live_ActivityLiveActivity.swift
//  Live Activity
//
//  Created by sardar saqib on 06/12/2024.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct Live_ActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var prayerName: String
        var prayerTime: String
        
    }

    // Fixed non-changing properties about your activity go here!
   // var name: String
}

struct Live_ActivityLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PrayerAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Next Prayer is : \(context.state.prayerName)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    HStack {
                        Text("🕌")
                        Text(context.state.prayerName)
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.isStale ? "Expired" : context.state.prayerTime)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    
                    Button(intent: BoostIntent(activityId: context.activityID), label: {
                        Text(context.isStale ? "Remove Activity" : "End! Activity")
                            .lineLimit(1)

                    })
                    .foregroundStyle(.red)
                    .buttonStyle(.plain)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                    .background(RoundedRectangle(cornerRadius: 4).stroke(.red, style: .init(lineWidth: 2)))
                }
            } compactLeading: {
                HStack {
                    Text("🕌")
                    Text(context.state.prayerName)
                }
                
            } compactTrailing: {
                Text(context.isStale ? "Expired" : context.state.prayerTime)
            } minimal: {
                Text("🕌")
                Text(context.state.prayerName)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension Live_ActivityAttributes {
    fileprivate static var preview: Live_ActivityAttributes {
        Live_ActivityAttributes()
    }
}

extension Live_ActivityAttributes.ContentState {
    fileprivate static var smiley: Live_ActivityAttributes.ContentState {
        Live_ActivityAttributes.ContentState(prayerName: "Fajr", prayerTime: "04:58")
     }
     
     fileprivate static var starEyes: Live_ActivityAttributes.ContentState {
         Live_ActivityAttributes.ContentState(prayerName: "Fajr", prayerTime: "04:58")
     }
}

#Preview("Notification", as: .content, using: Live_ActivityAttributes.preview) {
   Live_ActivityLiveActivity()
} contentStates: {
    Live_ActivityAttributes.ContentState.smiley
    Live_ActivityAttributes.ContentState.starEyes
}
