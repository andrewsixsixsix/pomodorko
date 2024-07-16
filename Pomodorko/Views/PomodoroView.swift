//
//  PomodoroView.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 14.07.2024.
//

import SwiftUI

struct PomodoroView: View {
    @Binding var pomodoro: Pomodoro

    var body: some View {
        VStack {
            ModeLabel(mode: pomodoro.mode)
            Text("25")
            Text("00")
            HStack(spacing: 12) {
                PomodoroButton(action: {},
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
