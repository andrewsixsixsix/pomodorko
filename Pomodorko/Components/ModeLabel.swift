//
//  ModeLabel.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 15.07.2024.
//

import SwiftUI

struct ModeLabel: View {
    let mode: Mode

    private var color: Color {
        Theme.forMode(mode).accentColor
    }

    private var fill: Color {
        Theme.forMode(mode).fillColor
    }

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
            .background(rectangle.fill(fill))
    }

    var body: some View {
        Label(name, systemImage: icon)
            .padding(8)
            .overlay {
                overlay
            }
            .foregroundStyle(color)
            .accessibilityLabel("Pomodoro mode")
            .accessibilityValue(name)
    }
}

#Preview("Focus") {
    ModeLabel(mode: .focus)
}

#Preview("Short break") {
    ModeLabel(mode: .shortBreak)
}

#Preview("Long break") {
    ModeLabel(mode: .longBreak)
}
