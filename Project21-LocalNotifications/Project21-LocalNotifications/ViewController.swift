//
//  ViewController.swift
//  Project21-LocalNotifications
//
//  Created by Kamil Bloch on 16/11/2019.
//  Copyright © 2019 Kamil Bloch. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
    }
    
    var currentAction: String = ""
    
    @objc func registerLocal(){
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("yayy")
            } else {
                print("Oh..")
            }
        }
        
    }
    
    @objc func scheduleLocal() {
        registerCategories()
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese"
        
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
        
        
        let trigger: UNTimeIntervalNotificationTrigger?
                
        switch currentAction {
            case "showLater":
                trigger =  UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: false) // remind me after 24h
            default:
                trigger =  UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        }
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self as UNUserNotificationCenterDelegate
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more..", options: .foreground)
        let showLater = UNNotificationAction(identifier: "showLater", title: "Remind me later", options: .foreground)
        
        let category = UNNotificationCategory(identifier: "alarm", actions: [show, showLater], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "hello there")
        
        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        
        if let customData = userInfo["customData"] as? String {
            print("Custom data: \(customData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                showAlert(with: "default id")
                currentAction = UNNotificationDefaultActionIdentifier
            case "show":
                showAlert(with: "Hi! I'am alert")
                currentAction = "show"
            case "showLater":
                showAlert(with: "I will remind you in 24h")
                currentAction = "showLater"
                scheduleLocal()
            default:
                break
            }
        }
        completionHandler()
    }
    
    func showAlert(with message: String) {
        let alert = UIAlertController(title: "Choosed option", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "cancel", style: .cancel)
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
}

