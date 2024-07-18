//
//  Settings.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 18.07.2024.
//

import Foundation

@Observable
class Settings: ObservableObject {
    private let FOCUS_DURATION_STEP = 5
    private let SHORT_BREAK_DURATION_STEP = 5
    private let LONG_BREAK_DURATION_STEP = 5
    private let POMODOROS_UNTIL_LONG_BREAK_STEP = 1

    var isAutoResume: Bool
    var isDarkMode: Bool
    var isNotifications: Bool
    var isSound: Bool

    // duration in minutes
    var focusDuration: Int
    var longBreakDuration: Int
    var shortBreakDuration: Int
    var pomodorosUntilLongBreak: Int

    // settings are set to user defined or default
    init() {
        isAutoResume = false
        isDarkMode = false
        isNotifications = false
        isSound = false

        focusDuration = 25
        longBreakDuration = 30
        shortBreakDuration = 5
        pomodorosUntilLongBreak = 4
    }

    func incrementFocusDuration() {
        focusDuration += FOCUS_DURATION_STEP
    }

    func decrementFocusDuration() {
        if focusDuration == FOCUS_DURATION_STEP { return }
        focusDuration -= FOCUS_DURATION_STEP
    }

    func incrementLongBreakDuration() {
        longBreakDuration += LONG_BREAK_DURATION_STEP
    }

    func decrementLongBreakDuration() {
        if longBreakDuration == LONG_BREAK_DURATION_STEP { return }
        longBreakDuration -= LONG_BREAK_DURATION_STEP
    }

    func incrementShortBreakDuration() {
        shortBreakDuration += SHORT_BREAK_DURATION_STEP
    }

    func decrementShortBreakDuration() {
        if shortBreakDuration == SHORT_BREAK_DURATION_STEP { return }
        shortBreakDuration -= SHORT_BREAK_DURATION_STEP
    }

    func incrementPomodorosUntilLongDuration() {
        pomodorosUntilLongBreak += POMODOROS_UNTIL_LONG_BREAK_STEP
    }

    func decrementPomodorosUntilLongBreak() {
        if pomodorosUntilLongBreak == POMODOROS_UNTIL_LONG_BREAK_STEP { return }
        pomodorosUntilLongBreak -= POMODOROS_UNTIL_LONG_BREAK_STEP
    }
}
