//
//  AppDelegate.swift
//  Live Activity with Push Notification
//
//  Created by sardar saqib on 06/12/2024.
//

import Foundation
import UIKit
import ActivityKit

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        /*UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current()
            .requestAuthorization(
                options: [.alert, .sound, .badge]) { granted, _ in
                    guard granted else { return }
                    UNUserNotificationCenter.current().getNotificationSettings { settings in
                        guard settings.authorizationStatus == .authorized else { return }
                        DispatchQueue.main.async {
                            application.registerForRemoteNotifications()
                        }
                    }
                }
        return true*/
        getPushToStartToken()
        observeActivityPushToken()
        return true
    }
    
    /*func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            guard let aps = userInfo["aps"] as? [String: AnyObject] else {
                completionHandler(.failed)
                return
            }
            print("got something, aka the \(aps)")
        }
        
        func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
            let token = tokenParts.joined()
            print("Device Token: \(token)")
        }
        
        func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
            print("Device Token not found.")
        }*/
    
    func getPushToStartToken() {
        if #available(iOS 17.2, *) {
            Task {
                for await data in Activity<PrayerAttributes>.pushToStartTokenUpdates {
                    let token = data.map {String(format: "%02x", $0)}.joined()
                            print("Activity PushToStart Token: \(token)")
                            //send this token to your notification server
                    }
            }
        }
    }
}

extension AppDelegate {
    func observeActivityPushToken() {
        Task {
            for await activity in Activity<PrayerAttributes>.activityUpdates {
                Task {
                    for await tokenData in activity.pushTokenUpdates {
                        let token = tokenData.map {String(format: "%02x", $0)}.joined()
                        print("Push token: \(token)")
                    }
                }
            }
        }
    }
}
