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
// TODO: save settings when closing settings sheet, initialize settings with saved or defaults

struct PomodoroView: View {
    @Binding var pomodoro: Pomodoro
    @EnvironmentObject var theme: PomodoroTheme

    @State private var isShowSettings = false

    var body: some View {
        VStack(spacing: 48) {
            ModeLabel(mode: pomodoro.mode)
            VStack {
                TimerText(value: "25", weight: .light)
                TimerText(value: "00", weight: .light)
            }
            HStack(spacing: 16) {
                PomodoroButton(action: { isShowSettings.toggle() },
                               icon: "ellipsis",
                               size: Size(80, 80))
                PomodoroButton(action: {},
                               cornerRadius: 32,
                               fill: Color(pomodoro.theme.fillColorDark),
                               icon: "arrowtriangle.right.fill",
                               size: Size(128, 96))
                PomodoroButton(action: {},
                               icon: "forward.fill",
                               size: Size(80, 80))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(theme.mainColor)
        .sheet(isPresented: $isShowSettings) { SettingsView() }
    }
}

#Preview("Focus") {
    PomodoroView(pomodoro: .constant(Pomodoro(mode: .focus)))
        .environmentObject(PomodoroTheme(mode: .focus))
}

#Preview("Short break") {
    PomodoroView(pomodoro: .constant(Pomodoro(mode: .shortBreak)))
        .environmentObject(PomodoroTheme(mode: .shortBreak))
}

#Preview("Long break") {
    PomodoroView(pomodoro: .constant(Pomodoro(mode: .longBreak)))
        .environmentObject(PomodoroTheme(mode: .longBreak))
}
