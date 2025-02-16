//
//  CounterSetting.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 17.07.2024.
//

import SwiftUI

struct CounterSetting: View {
    let text: String
    let value: Int

    let increment: () -> Void
    let decrement: () -> Void

    @EnvironmentObject var pomodoro: Pomodoro

    private var theme: Theme {
        pomodoro.theme
    }

    var body: some View {
        HStack {
            Text(text)

            Spacer()

            HStack {
                Text("\(value)")
                    .font(.system(size: 20))
                    .frame(width: 32)
                    .padding(.horizontal, 20)

                VStack(spacing: 8) {
                    Button {
                        increment()
                    } label: {
                        Image(systemName: "arrowtriangle.up.fill")
                            .imageScale(.small)
                            .foregroundStyle(theme.accentColor)
                    }

                    Button {
                        decrement()
                    } label: {
                        Image(systemName: "arrowtriangle.down.fill")
                            .imageScale(.small)
                            .foregroundStyle(theme.accentColor)
                    }
                }
                .padding(.trailing, 8)
            }
            .padding(.vertical, 8)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(theme.accentColor.opacity(0.15), lineWidth: 2)
            }
        }
    }
}

#Preview("Focus") {
    CounterSetting(text: "Focus duration", value: 25, increment: {}, decrement: {})
        .environmentObject(Pomodoro(mode: .focus))
}

#Preview("Short break") {
    CounterSetting(text: "Focus duration", value: 25, increment: {}, decrement: {})
        .environmentObject(Pomodoro(mode: .shortBreak))
}

#Preview("Long break") {
    CounterSetting(text: "Focus duration", value: 25, increment: {}, decrement: {})
        .environmentObject(Pomodoro(mode: .longBreak))
}
