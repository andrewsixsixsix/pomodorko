//
//  PomodoroButton.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 16.07.2024.
//

import SwiftUI

struct PomodoroButton: View {
    var cornerRadius: CGFloat = 24
    var fill: Color?
    let icon: String
    let size: Size
    let action: () -> Void

    @EnvironmentObject var pomodoro: Pomodoro

    private var theme: Theme {
        pomodoro.theme
    }

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .imageScale(.large)
                .foregroundColor(theme.accentColor)
                .padding(24)
        }
        .frame(width: size.width, height: size.height)
        .background {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(fill ?? theme.fillColor)
        }
    }
}

#Preview("Focus") {
    PomodoroButton(fill: Theme.forMode(.focus).fillColorDark,
                   icon: "arrowtriangle.right.fill",
                   size: Size(80, 80),
                   action: {})
    .environmentObject(Pomodoro(mode: .focus))
}

#Preview("Short break") {
    PomodoroButton(fill: Theme.forMode(.shortBreak).fillColorDark,
                   icon: "arrowtriangle.right.fill",
                   size: Size(80, 80),
                   action: {})
    .environmentObject(Pomodoro(mode: .shortBreak))
}

#Preview("Long breal") {
    PomodoroButton(fill: Theme.forMode(.shortBreak).fillColorDark,
                   icon: "arrowtriangle.right.fill",
                   size: Size(80, 80),
                   action: {})
    .environmentObject(Pomodoro(mode: .longBreak))
}
