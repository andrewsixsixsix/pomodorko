//
//  TimerText.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 16.07.2024.
//

import SwiftUI

struct TimerText: View {
    @EnvironmentObject var pomodoro: Pomodoro

    private var theme: Theme {
        pomodoro.theme
    }

    private var weight: Font.Weight {
        pomodoro.isActive ? .bold : .light
    }

    var body: some View {
        VStack {
            Text(String(format: "%02d", pomodoro.timeLeft / 60))
                .font(.system(size: 180, weight: weight))
                .foregroundStyle(theme.accentColor)
                .frame(height: 140)
                .frame(maxWidth: .infinity)

            Text(String(format: "%02d", pomodoro.timeLeft % 60))
                .font(.system(size: 180, weight: weight))
                .foregroundStyle(theme.accentColor)
                .frame(height: 140)
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview("Focus") {
    TimerText()
        .environmentObject(Pomodoro(mode: .focus))
}

#Preview("Short break") {
    TimerText()
        .environmentObject(Pomodoro(mode: .shortBreak))
}

#Preview("Long break") {
    TimerText()
        .environmentObject(Pomodoro(mode: .longBreak))
}
