//
//  NotificationManager.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 25.07.2024.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let center = UNUserNotificationCenter.current()

    static func authorize() {
        center.requestAuthorization(options: [.alert, .sound]) { (success, error) in }
    }

    static func notify(title: String, body: String, timeInterval: TimeInterval, withSound: Bool) {
        center.getNotificationSettings(completionHandler: { settings in
            switch settings.authorizationStatus {
            case .authorized:
                scheduleNotification(title, body, timeInterval, withSound)
            case .denied, .ephemeral, .notDetermined, .provisional:
                break
            @unknown default:
                break
            }
        })
    }

    static func removeNotifications() {
        center.removeAllPendingNotificationRequests()
    }

    private static func scheduleNotification(_ title: String, _ body: String, _ timeInterval: TimeInterval, _ withSound: Bool) {
        let content = UNMutableNotificationContent()

        content.title = title
        content.body = body
        content.sound = withSound ? .default : .none

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        center.add(request) { _ in }
    }
}
