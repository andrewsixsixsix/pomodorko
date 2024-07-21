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

    @EnvironmentObject var pomodoro: Pomodoro

    private var theme: Theme {
        pomodoro.theme
    }

    var body: some View {
        Text(value)
            .font(.system(size: 180, weight: weight))
            .foregroundStyle(theme.accentColor)
            .frame(height: 140)
    }
}

#Preview("Focus") {
    TimerText(value: "25", weight: .light)
        .environmentObject(Pomodoro(mode: .focus))
}

#Preview("Short break") {
    TimerText(value: "25", weight: .light)
        .environmentObject(Pomodoro(mode: .shortBreak))
}

#Preview("Long break") {
    TimerText(value: "25", weight: .light)
        .environmentObject(Pomodoro(mode: .longBreak))
}
