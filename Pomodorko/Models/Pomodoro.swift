//
//  Pomodoro.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 14.07.2024.
//

import Foundation

@Observable
class Pomodoro: ObservableObject {
    var isActive: Bool = false
    var pomodorosCounter: Int = 0
    var settings: Settings = Settings()

    private(set) var theme: Theme
    private(set) var mode: Mode {
        willSet {
            theme = Theme.forMode(newValue)

            switch(newValue) {
            case .shortBreak:
                pomodorosCounter += 1
            case .longBreak:
                pomodorosCounter = 0
            default:
                break
            }
        }
    }

    init(mode: Mode) {
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
        default:
            .focus
        }
    }
}
