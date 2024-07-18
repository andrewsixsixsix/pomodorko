//
//  PomodoroButton.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 16.07.2024.
//

import SwiftUI

struct PomodoroButton: View {
    let action: () -> Void
    var cornerRadius: CGFloat = 24
    var fill: Color?
    let icon: String
    let size: Size

    @EnvironmentObject var theme: PomodoroTheme

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
    PomodoroButton(action: {},
                   fill: PomodoroTheme(mode: .focus).fillColorDark,
                   icon: "arrowtriangle.right.fill",
                   size: Size(80, 80))
    .environmentObject(PomodoroTheme(mode: .focus))
}

#Preview("Short break") {
    PomodoroButton(action: {},
                   fill: PomodoroTheme(mode: .shortBreak).fillColorDark,
                   icon: "arrowtriangle.right.fill",
                   size: Size(80, 80))
    .environmentObject(PomodoroTheme(mode: .shortBreak))
}

#Preview("Long breal") {
    PomodoroButton(action: {},
                   fill: PomodoroTheme(mode: .longBreak).fillColorDark,
                   icon: "arrowtriangle.right.fill",
                   size: Size(80, 80))
    .environmentObject(PomodoroTheme(mode: .longBreak))
}
