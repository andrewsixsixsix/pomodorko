//
//  PomodorkoApp.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 14.07.2024.
//

import SwiftUI
import BackgroundTasks

@main
struct PomodorkoApp: App {
    @StateObject private var pomodoro = Pomodoro(mode: .focus)

    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            PomodoroView()
        }
        .backgroundTask(.appRefresh(Constants.BG_TASK_NEXT_SESSION)) { await pomodoro.skip() }
        .environmentObject(pomodoro)
        .onChange(of: scenePhase) { _, newPhase in
            switch newPhase {
            case .active:
                BGTaskManager.cancel(Constants.BG_TASK_NEXT_SESSION)
                NotificationManager.removeNotifications([Constants.NOTIF_SESSION_END])
            case .background:
                pomodoro.scheduleNextSession()
                pomodoro.scheduleNotification()
            case .inactive:
                break
            @unknown default:
                break
            }
        }
    }
}
