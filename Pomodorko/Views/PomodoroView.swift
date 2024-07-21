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

                PomodoroButton(action: { pomodoro.skip() },
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
