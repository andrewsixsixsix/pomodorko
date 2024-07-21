//
//  Pomodoro.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 14.07.2024.
//

import Foundation

@Observable
class Pomodoro: ObservableObject {
    var isActive: Bool
    private(set) var mode: Mode {
        willSet {
            theme = Theme.forMode(newValue)
        }
    }
    var settings: Settings
    private(set) var theme: Theme

    init(mode: Mode) {
        self.isActive = false
        self.mode = mode
        self.settings = Settings()
        self.theme = Theme.forMode(mode)
    }

    func skip() {
        mode = switch(mode) {
        case .focus:
            .shortBreak
        case .shortBreak:
            .longBreak
        case .longBreak:
            .focus
        }
    }
}
