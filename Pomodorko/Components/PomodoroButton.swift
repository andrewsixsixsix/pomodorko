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
    let theme: Theme

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
                   fill: Theme.focus.fillColorDark,
                   icon: "arrowtriangle.right.fill",
                   size: Size(80, 80),
                   theme: Theme.focus)
}

#Preview("Short break") {
    PomodoroButton(action: {},
                   fill: Theme.shortBreak.fillColorDark,
                   icon: "arrowtriangle.right.fill",
                   size: Size(80, 80),
                   theme: Theme.shortBreak)
}

#Preview("Long breal") {
    PomodoroButton(action: {},
                   fill: Theme.longBreak.fillColorDark,
                   icon: "arrowtriangle.right.fill",
                   size: Size(80, 80),
                   theme: Theme.longBreak)
}
