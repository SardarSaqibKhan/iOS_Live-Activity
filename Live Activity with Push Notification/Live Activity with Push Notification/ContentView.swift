//
//  ContentView.swift
//  Live Activity with Push Notification
//
//  Created by sardar saqib on 06/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State var currentActivityId = ""
    var body: some View {
        VStack(spacing:20) {
            Text("Live Activity With Push Notifications")
                .font(.headline)
            Button {
                do {
                    currentActivityId = try LiveActivityManager.startActivity()
                }
                catch {
                    print(error.localizedDescription)
                }
                
            } label: {
                Text("Start Activity")
            }
            .buttonStyle(.plain)
            .padding(.vertical, 8)
            .padding(.horizontal, 8)
            .background(RoundedRectangle(cornerRadius: 4).stroke(.blue, style: .init(lineWidth: 2)))
            
            Button {
                Task {
                    await LiveActivityManager.updateActivity(activityId: currentActivityId)
                }
            } label: {
                Text("Update Activity")
            }
            .buttonStyle(.plain)
            .padding(.vertical, 8)
            .padding(.horizontal, 8)
            .background(RoundedRectangle(cornerRadius: 4).stroke(.blue, style: .init(lineWidth: 2)))
            
            Button {
                Task {
                    await LiveActivityManager.endActivity(currentActivityId)
                }
            } label: {
                Text("End Activity")
            }
            .buttonStyle(.plain)
            .padding(.vertical, 8)
            .padding(.horizontal, 8)
            .background(RoundedRectangle(cornerRadius: 4).stroke(.blue, style: .init(lineWidth: 2)))


        }
        .padding()
    }
}

#Preview {
    ContentView()
}
