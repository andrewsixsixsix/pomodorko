//
//  ModeLabel.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 15.07.2024.
//

import SwiftUI

struct ModeLabel: View {
    let mode: Mode

    @EnvironmentObject var theme: PomodoroTheme

    private var icon: String {
        switch mode {
        case .focus:
            "brain"
        default:
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
    ModeLabel(mode: .focus)
        .environmentObject(PomodoroTheme(mode: .focus))
}

#Preview("Short break") {
    ModeLabel(mode: .shortBreak)
        .environmentObject(PomodoroTheme(mode: .shortBreak))
}

#Preview("Long break") {
    ModeLabel(mode: .longBreak)
        .environmentObject(PomodoroTheme(mode: .longBreak))
}
