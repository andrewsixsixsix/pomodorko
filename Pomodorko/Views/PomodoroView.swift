//
//  PomodoroView.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 14.07.2024.
//

import SwiftUI

struct PomodoroView: View {
    @ObservedObject var pomodoro: Pomodoro
    @EnvironmentObject var theme: PomodoroTheme

    @State private var isShowSettings = false

    var body: some View {
        VStack(spacing: 48) {
            ModeLabel(mode: pomodoro.mode)
            VStack {
                TimerText(value: "25", weight: pomodoro.isActive ? .bold : .light)
                TimerText(value: "00", weight: pomodoro.isActive ? .bold : .light)
            }
            HStack(spacing: 16) {
                PomodoroButton(action: { isShowSettings.toggle() },
                               icon: "ellipsis",
                               size: Size(80, 80))

                PomodoroButton(action: { withAnimation(.none) { pomodoro.isActive.toggle() } },
                               cornerRadius: 32,
                               fill: Color(theme.fillColorDark),
                               icon: pomodoro.isActive ? "pause.fill" : "arrowtriangle.right.fill",
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
    PomodoroView(pomodoro: Pomodoro(mode: .focus))
        .environmentObject(PomodoroTheme(mode: .focus))
}

#Preview("Short break") {
    PomodoroView(pomodoro: Pomodoro(mode: .shortBreak))
        .environmentObject(PomodoroTheme(mode: .shortBreak))
}

#Preview("Long break") {
    PomodoroView(pomodoro: Pomodoro(mode: .longBreak))
        .environmentObject(PomodoroTheme(mode: .longBreak))
}
