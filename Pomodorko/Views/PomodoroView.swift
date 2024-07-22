//
//  PomodoroView.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 14.07.2024.
//

import SwiftUI

struct PomodoroView: View {
    @EnvironmentObject var pomodoro: Pomodoro

    @State private var isShowSettings = false

    var theme: Theme {
        pomodoro.theme
    }

    var body: some View {
        VStack(spacing: 48) {
            ModeLabel()

            TimerText()

            HStack(spacing: 16) {
                PomodoroButton(icon: "ellipsis", size: Size(80, 80)) { isShowSettings.toggle() }

                PomodoroButton(cornerRadius: 32,
                               fill: Color(theme.fillColorDark),
                               icon: pomodoro.isActive ? "pause.fill" : "arrowtriangle.right.fill",
                               size: Size(128, 96)) {
                    withAnimation(.none) {
                        pomodoro.isActive ? pomodoro.stop() : pomodoro.start()
                    }
                }

                PomodoroButton(icon: "forward.fill", size: Size(80, 80)) { pomodoro.skip() }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(theme.mainColor)
        .sheet(isPresented: $isShowSettings) { SettingsView() }
    }
}

#Preview("Focus") {
    PomodoroView()
        .environmentObject(Pomodoro(mode: .focus))
}

#Preview("Short break") {
    PomodoroView()
        .environmentObject(Pomodoro(mode: .shortBreak))
}

#Preview("Long break") {
    PomodoroView()
        .environmentObject(Pomodoro(mode: .longBreak))
}
