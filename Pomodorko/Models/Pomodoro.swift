//
//  Pomodoro.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 14.07.2024.
//

import Foundation

@Observable
class Pomodoro: ObservableObject {
    var isActive = false
    var pomodorosCounter = 0
    var timer: Timer = .init()

    var settings: Settings
    var timeLeft: Int

    private(set) var theme: Theme
    private(set) var mode: Mode {
        willSet {
            theme = Theme.forMode(newValue)

            switch(newValue) {
            case .focus:
                break
            case .shortBreak:
                pomodorosCounter += 1
            case .longBreak:
                pomodorosCounter = 0
            }
        }
    }

    init(mode: Mode) {
        let settings = Settings()
        self.settings = settings
        self.timeLeft = settings.focusDuration * 60

        self.mode = mode
        self.theme = Theme.forMode(mode)
    }

    /// Skips current pomodoro mode
    ///
    /// Focus mode is skipped to short or long break. Both short and long breaks are always skipped to focus mode
    func skip() {
        mode = switch(mode) {
        case .focus:
            pomodorosCounter + 1 >= settings.pomodorosUntilLongBreak ? .longBreak : .shortBreak
        case .shortBreak, .longBreak:
            .focus
        }
    }
}
