//
//  PomodorkoApp.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 14.07.2024.
//

import SwiftUI

@main
struct PomodorkoApp: App {
    @StateObject private var pomodoro = Pomodoro(mode: .focus)

    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            PomodoroView()
        }
        .environmentObject(pomodoro)
        .onChange(of: scenePhase) { oldPhase, newPhase in
            switch newPhase {
            case .active:
                NotificationManager.removeNotifications()
            case .background:
                pomodoro.scheduleNotification()
            case .inactive:
                break
            @unknown default:
                break
            }
        }
    }
}
