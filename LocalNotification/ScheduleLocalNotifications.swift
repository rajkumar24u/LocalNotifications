//
//  ScheduleLocalNotifications.swift
//  Directory
//
//  Created by sunarc on 06/07/17.
//  Copyright © 2017 sunarc. All rights reserved.
//

import UIKit
import UserNotifications

class ScheduleLocalNotifications: NSObject, UNUserNotificationCenterDelegate {

    func scheduleNotification() {
//        UNUserNotificationCenter.current().delegate = self
        
        authorizeNotification()
        scheduleNotificationDateWise()

    }
    
    //Authorization for Local Notification
    func authorizeNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            if let error = error {
                print("Error:- \(error)")
            } else if success == true {
                print("Permission Granted")
            }
        }
    }
    
    func scheduleNotificationDateWise() {
        
        for i in 0 ..< 60 {
            
            // Adding Action
            let likeAction = UNNotificationAction(identifier: "LikeID",
                                                  title: "Like", options: [.foreground])
            let dislikeAction = UNNotificationAction(identifier: "DislikeID",
                                                     title: "Dislike", options: [.foreground])
            
            let category = UNNotificationCategory(identifier: "app.likedislike.ios10\(i)",
                actions: [likeAction, dislikeAction],
                intentIdentifiers: [], options: [])
            UNUserNotificationCenter.current().setNotificationCategories([category])
            
            
            // Create Notification Content
            let notificationContent = UNMutableNotificationContent()
            
            // Configure Notification Content
            notificationContent.title = "iOS 10 UserNotifications"
            notificationContent.subtitle = "Local Notifications no \(i)"
            notificationContent.body = "The UserNotifications framework (UserNotifications.framework) supports the delivery and handling of local and remote notifications."
            notificationContent.categoryIdentifier = "app.likedislike.ios10"
            notificationContent.sound = UNNotificationSound.default()
            // Add Trigger
            let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
            
            // Create Notification Request
            let request = UNNotificationRequest(identifier: "app.likedislike.ios10\(i)",
                content: notificationContent, trigger: notificationTrigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
                if let error = error {
                    print("Error \(error)")
                }
            })
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.actionIdentifier == "LikeID" {
            let newDate = Date(timeInterval: 5, since: Date())
            print(newDate)
        }
        if response.actionIdentifier == "DislikeID" {
            print("Dislike Clicked")
        }
    }

    
}
