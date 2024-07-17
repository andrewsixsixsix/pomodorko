//
//  SettingsView.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 16.07.2024.
//

import SwiftUI

struct SettingsView: View {
    @State private var isAutoResume = false
    @State private var isDarkMode = false
    @State private var isSound = false
    @State private var isNotifications = false

    @Environment(\.dismiss) private var dismiss

    let theme: Theme

    var body: some View {
        VStack(spacing: 28) {
            HStack {
                Text("Settings")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .imageScale(.large)
                }
            }
            .padding(.bottom, 12)
            Toggle(isOn: $isDarkMode) {
                Text("Dark mode")
            }
            .toggleStyle(SwitchToggleStyle(tint: theme.accentColor))
            CounterSetting(text: "Focus length",
                           value: 25,
                           theme: theme,
                           increment: {},
                           decrement: {})
            CounterSetting(text: "Pomodoros untill long break",
                           value: 25,
                           theme: theme,
                           increment: {},
                           decrement: {})
            CounterSetting(text: "Short break length",
                           value: 25,
                           theme: theme,
                           increment: {},
                           decrement: {})
            CounterSetting(text: "Long break length",
                           value: 25,
                           theme: theme,
                           increment: {},
                           decrement: {})
            Toggle(isOn: $isAutoResume) {
                Text("Auto resume timer")
            }
            .toggleStyle(SwitchToggleStyle(tint: theme.accentColor))
            Toggle(isOn: $isSound) {
                Text("Sound")
            }
            .toggleStyle(SwitchToggleStyle(tint: theme.accentColor))
            Toggle(isOn: $isNotifications) {
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
    SettingsView(theme: Theme.forMode(.focus))
}

#Preview("Short break") {
    SettingsView(theme: Theme.forMode(.shortBreak))
}

#Preview("Long break") {
    SettingsView(theme: Theme.forMode(.longBreak))
}
