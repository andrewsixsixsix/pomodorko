//
//  Pomodoro.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 14.07.2024.
//

import Foundation

struct Pomodoro {
    var mode: Mode
    var theme: Theme

    init(mode: Mode) {
        self.mode = mode
        self.theme = Theme.forMode(mode)
    }
}
