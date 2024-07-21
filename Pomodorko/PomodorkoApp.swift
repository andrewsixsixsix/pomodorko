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

    var body: some Scene {
        WindowGroup {
            PomodoroView()
        }
        .environmentObject(pomodoro)
    }
}
