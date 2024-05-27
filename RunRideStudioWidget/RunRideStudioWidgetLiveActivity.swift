//
//  RunRide_WidgetLiveActivity.swift
//  RunRide Widget
//
//  Created by Stoyan Delev on 7.03.24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct RunRideStudioWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct RunRideStudioWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: RunRideStudioWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension RunRideStudioWidgetAttributes {
    fileprivate static var preview: RunRideStudioWidgetAttributes {
        RunRideStudioWidgetAttributes(name: "World")
    }
}

extension RunRideStudioWidgetAttributes.ContentState {
    fileprivate static var smiley: RunRideStudioWidgetAttributes.ContentState {
        RunRideStudioWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: RunRideStudioWidgetAttributes.ContentState {
         RunRideStudioWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: RunRideStudioWidgetAttributes.preview) {
   RunRideStudioWidgetLiveActivity()
} contentStates: {
    RunRideStudioWidgetAttributes.ContentState.smiley
    RunRideStudioWidgetAttributes.ContentState.starEyes
}
