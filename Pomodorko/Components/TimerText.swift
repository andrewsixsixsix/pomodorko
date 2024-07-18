//
//  TimerText.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 16.07.2024.
//

import SwiftUI

struct TimerText: View {
    let value: String
    let weight: Font.Weight

    @EnvironmentObject var theme: PomodoroTheme

    var body: some View {
        Text(value)
            .font(.system(size: 180, weight: weight))
            .foregroundStyle(theme.accentColor)
            .frame(height: 140)
    }
}

#Preview("Focus") {
    TimerText(value: "25", weight: .light)
        .environmentObject(PomodoroTheme(mode: .focus))
}

#Preview("Short break") {
    TimerText(value: "25", weight: .light)
        .environmentObject(PomodoroTheme(mode: .shortBreak))
}

#Preview("Long break") {
    TimerText(value: "25", weight: .light)
        .environmentObject(PomodoroTheme(mode: .longBreak))
}
