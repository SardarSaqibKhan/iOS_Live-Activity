//
//  LiveActivityManager.swift
//  Live Activity with Push Notification
//
//  Created by sardar saqib on 06/12/2024.
//

import Foundation
import ActivityKit
import OSLog

enum LiveActivityManagerError: Error {
    case failedToGetId
}

class LiveActivityManager {
    
    static func startActivity() throws -> String {
        
        var activity: Activity<PrayerAttributes>?
        let startDate = Calendar.current.date(byAdding: .minute, value: 0, to: Date())!
        let endDate = Calendar.current.date(byAdding: .minute, value:  1, to: Date())!
        let staleDate = Calendar.current.date(byAdding: .second, value:  60, to: Date())!
        
        let activityAttributes = PrayerAttributes()
        let contentState = PrayerAttributes.ContentState(prayerName: "Fajr", prayerTime : "04:58")
        //PrayerAttributes.ContentState(prayerName: "Asr", startDate: startDate, endDate: endDate)
        let activityContent = ActivityContent(state: contentState,  staleDate: staleDate, relevanceScore: 100)
        
        do {
            activity = try Activity.request(attributes: activityAttributes, content: activityContent, pushType: .token)
            guard let id = activity?.id else { throw LiveActivityManagerError.failedToGetId }
            
            Task {
                for await pushToken in activity!.pushTokenUpdates {
                    let pushTokenString = pushToken.reduce("") {
                          $0 + String(format: "%02x", $1)
                    }


                    Logger().log("New push token: \(pushTokenString)")
                    
                    //try await self.sendPushToken(pushTokenString: pushTokenString)
                }
            }
           
            return id
        } catch {
            throw error
        }
    }
    
    static func updateActivity(activityId:String) async {
        let updatedContentState = PrayerAttributes.ContentState(prayerName: "Dhur", prayerTime: "12:30")
        let activity = Activity<PrayerAttributes>.activities.first(where: { $0.id == activityId })
        await activity?.update(using: updatedContentState)
    }
    
    static func endActivity(_ id: String) async {
        await Activity<PrayerAttributes>.activities.first(where: { $0.id == id })?.end(dismissalPolicy: .immediate)
    }
    
    func sendPushToken(pushTokenString:String) async {
        print(pushTokenString)
    }
}
