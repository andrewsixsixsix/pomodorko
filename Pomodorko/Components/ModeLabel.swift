//
//  ModeLabel.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 15.07.2024.
//

import SwiftUI

struct ModeLabel: View {
    @EnvironmentObject var pomodoro: Pomodoro

    private var mode: Mode {
        pomodoro.mode
    }

    private var theme: Theme {
        pomodoro.theme
    }

    private var icon: String {
        switch mode {
        case .focus:
            "brain"
        case .shortBreak, .longBreak:
            "cup.and.saucer"
        }
    }

    private var name: String {
        mode.name
    }

    private var overlay: some View {
        let rectangle = RoundedRectangle(cornerRadius: 20)
        return rectangle
            .stroke(lineWidth: 1)
            .background(rectangle.fill(theme.fillColor))
    }

    var body: some View {
        Label(name, systemImage: icon)
            .padding(8)
            .overlay { overlay }
            .foregroundStyle(theme.accentColor)
    }
}

#Preview("Focus") {
    ModeLabel()
        .environmentObject(Pomodoro(mode: .focus))
}

#Preview("Short break") {
    ModeLabel()
        .environmentObject(Pomodoro(mode: .shortBreak))
}

#Preview("Long break") {
    ModeLabel()
        .environmentObject(Pomodoro(mode: .longBreak))
}
