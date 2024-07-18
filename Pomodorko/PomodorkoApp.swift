//
//  PomodorkoApp.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 14.07.2024.
//

import SwiftUI

@main
struct PomodorkoApp: App {
    // TODO: this should be a @StateObject
    @State private var pomodoro = Pomodoro(mode: .focus)
    @StateObject private var theme = PomodoroTheme(mode: .focus)

    var body: some Scene {
        WindowGroup {
            PomodoroView(pomodoro: $pomodoro)
        }
        .environmentObject(theme)
    }
}
