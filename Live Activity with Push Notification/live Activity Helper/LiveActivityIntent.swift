//
//  LiveActivityIntent.swift
//  Live Activity with Push Notification
//
//  Created by sardar saqib on 09/12/2024.
//

import SwiftUI
import AppIntents

struct BoostIntent: LiveActivityIntent {
    init() {
        
    }
    
    init(activityId: String) {
        self.activityId = activityId
    }
    
    static var title: LocalizedStringResource = "Refresh Activity"
    static var description = IntentDescription("Get the newest Energy Status")
        
    @Parameter
    private var activityId: String?
    
    func perform() async throws -> some IntentResult{
        print("refreshing \(String(describing: activityId))")
        if let activityId = activityId {
            await LiveActivityManager.endActivity(activityId)
        }
        return .result()
    }
}
