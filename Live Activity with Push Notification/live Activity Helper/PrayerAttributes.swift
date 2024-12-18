//
//  PrayerAttributes.swift
//  Live Activity with Push Notification
//
//  Created by sardar saqib on 06/12/2024.
//

import ActivityKit
import Foundation

struct PrayerAttributes : ActivityAttributes {
    
    public struct ContentState: Codable, Hashable {
        var prayerName: String
        var prayerTime: String
        //var startDate:Date
        //var endDate:Date
    }
}

