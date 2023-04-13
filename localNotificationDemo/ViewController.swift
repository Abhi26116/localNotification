//
//  ViewController.swift
//  localNotificationDemo
//
//  Created by mac on 28/03/23.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let center = UNUserNotificationCenter.current()
            center.delegate = self
                center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                    if granted {
                        print("User gave permissions for local notifications")
                    }
                }
        
                let content = UNMutableNotificationContent()
                content.title = "Core data app notification"
                content.body = "Item added in core data"
                let fireDate = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: Date().addingTimeInterval(2))
                let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: false)
                let uuid = UUID().uuidString
                let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
                center.add(request) { (error) in
                    if error != nil {
                        print("Error = \(error?.localizedDescription ?? "error local notification")")
                    }
                }    }
    
    //MARK:- UNUSerNotificationDelegates
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Usrinfo associated with notification == \(response.notification.request.content.userInfo)")

        completionHandler()
    }
}

