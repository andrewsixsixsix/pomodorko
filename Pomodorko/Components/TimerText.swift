//
//  TimerText.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 16.07.2024.
//

import SwiftUI

struct TimerText: View {
    let color: Color
    let value: String
    let weight: Font.Weight

    var body: some View {
        Text(value)
            .font(.system(size: 180, weight: weight))
            .foregroundStyle(color)
            .frame(height: 140)
    }
}

#Preview("Focus") {
    TimerText(color: Theme.forMode(.focus).accentColor, value: "25", weight: .light)
}

#Preview("Short break") {
    TimerText(color: Theme.forMode(.shortBreak).accentColor, value: "25", weight: .light)
}

#Preview("Long break") {
    TimerText(color: Theme.forMode(.longBreak).accentColor, value: "25", weight: .light)
}
