//
//  Pomodoro.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 14.07.2024.
//

import Foundation

struct Pomodoro {
    var mode: Mode
    var theme: PomodoroTheme

    init(mode: Mode) {
        self.mode = mode
        self.theme = PomodoroTheme(mode: mode)
    }
}
