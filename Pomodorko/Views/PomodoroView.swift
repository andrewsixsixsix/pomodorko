//
//  PomodoroView.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 14.07.2024.
//

import SwiftUI

// TODO: accesebility
// TODO: timer text width should be bold when pomodoro is in active state
// TODO: replace "play" icon with "pause" in active state
// TODO: make theme globally accessible somehow

struct PomodoroView: View {
    @Binding var pomodoro: Pomodoro

    @State private var isShowSettings = false

    var body: some View {
        VStack(spacing: 48) {
            ModeLabel(mode: pomodoro.mode)
            VStack {
                TimerText(color: pomodoro.theme.accentColor, value: "25", weight: .light)
                TimerText(color: pomodoro.theme.accentColor, value: "00", weight: .light)
            }
            HStack(spacing: 16) {
                PomodoroButton(action: { isShowSettings = true },
                               icon: "ellipsis",
                               size: Size(80, 80),
                               theme: pomodoro.theme)
                PomodoroButton(action: {},
                               cornerRadius: 32,
                               fill: Color(pomodoro.theme.fillColorDark),
                               icon: "arrowtriangle.right.fill",
                               size: Size(128, 96),
                               theme: pomodoro.theme)
                PomodoroButton(action: {},
                               icon: "forward.fill",
                               size: Size(80, 80),
                               theme: pomodoro.theme)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(pomodoro.theme.mainColor)
        .sheet(isPresented: $isShowSettings) { SettingsView(theme: pomodoro.theme) }
    }
}

#Preview("Focus") {
    PomodoroView(pomodoro: .constant(Pomodoro(mode: .focus)))
}

#Preview("Short break") {
    PomodoroView(pomodoro: .constant(Pomodoro(mode: .shortBreak)))
}

#Preview("Long break") {
    PomodoroView(pomodoro: .constant(Pomodoro(mode: .longBreak)))
}
