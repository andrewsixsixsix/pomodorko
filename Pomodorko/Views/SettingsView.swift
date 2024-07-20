//
//  SettingsView.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 16.07.2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject var settings: Settings
    @EnvironmentObject var theme: PomodoroTheme

    var body: some View {
        VStack(spacing: 28) {
            HStack {
                Text("Settings")
                    .font(.title)
                    .fontWeight(.bold)

                Spacer()

                Button {
                    settings.save()
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .imageScale(.large)
                }
            }
            .padding(.bottom, 12)

            CounterSetting(text: "Focus duration",
                           value: settings.focusDuration,
                           increment: { settings.incrementFocusDuration() },
                           decrement: { settings.decrementFocusDuration() })

            CounterSetting(text: "Pomodoros until long break",
                           value: settings.pomodorosUntilLongBreak,
                           increment: { settings.incrementPomodorosUntilLongDuration() },
                           decrement: { settings.decrementPomodorosUntilLongBreak() })

            CounterSetting(text: "Short break duration",
                           value: settings.shortBreakDuration,
                           increment: { settings.incrementShortBreakDuration() },
                           decrement: { settings.decrementShortBreakDuration() })

            CounterSetting(text: "Long break duration",
                           value: settings.longBreakDuration,
                           increment: { settings.incrementLongBreakDuration() },
                           decrement: { settings.decrementLongBreakDuration() })

            Toggle(isOn: $settings.isAutoResume) {
                Text("Auto resume timer")
            }
            .toggleStyle(SwitchToggleStyle(tint: theme.accentColor))

            Toggle(isOn: $settings.isSound) {
                Text("Sound")
            }
            .toggleStyle(SwitchToggleStyle(tint: theme.accentColor))

            Toggle(isOn: $settings.isNotifications) {
                Text("Notifications")
            }
            .toggleStyle(SwitchToggleStyle(tint: theme.accentColor))

            Spacer()
        }
        .padding()
        .foregroundStyle(theme.accentColor)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(theme.mainColor)
    }
}

#Preview("Focus") {
    SettingsView()
        .environmentObject(Settings())
        .environmentObject(PomodoroTheme(mode: .focus))
}

#Preview("Short break") {
    SettingsView()
        .environmentObject(Settings())
        .environmentObject(PomodoroTheme(mode: .shortBreak))
}

#Preview("Long break") {
    SettingsView()
        .environmentObject(Settings())
        .environmentObject(PomodoroTheme(mode: .longBreak))
}
