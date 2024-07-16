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
            HStack {
                Button(action: {}, label: {
                    Text("Settings")
                })
                Button(action: {}, label: {
                    Text("Play")
                })
                Button(action: {}, label: {
                    Text("Next")
                })
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
