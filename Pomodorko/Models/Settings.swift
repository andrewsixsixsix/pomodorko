//
//  Settings.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 18.07.2024.
//

import Foundation

@Observable
class Settings: ObservableObject, Codable {
    var isAutoResume: Bool = false
    var isDarkMode: Bool = false
    var isNotifications: Bool = false
    var isSound: Bool = false

    // duration in minutes
    private(set) var focusDuration: Int = 25
    private(set) var longBreakDuration: Int = 30
    private(set) var shortBreakDuration: Int = 5
    private(set) var pomodorosUntilLongBreak: Int = 4

    init() {
        if let data = UserDefaults.standard.data(forKey: Constants.SETTINGS) {
            do {
                let settings = try JSONDecoder().decode(Settings.self, from: data)
    
                isAutoResume = settings.isAutoResume
                isDarkMode = settings.isDarkMode
                isNotifications = settings.isNotifications
                isSound = settings.isSound

                focusDuration = settings.focusDuration
                longBreakDuration = settings.longBreakDuration
                shortBreakDuration = settings.shortBreakDuration
                pomodorosUntilLongBreak = settings.pomodorosUntilLongBreak
            } catch {
                return
            }
        }
    }

    func save() {
        do {
            let data = try JSONEncoder().encode(self)
            UserDefaults.standard.set(data, forKey: Constants.SETTINGS)
        } catch {
            return
        }
    }

    func incrementFocusDuration() {
        focusDuration += Constants.FOCUS_DURATION_STEP
    }

    func decrementFocusDuration() {
        if focusDuration == Constants.FOCUS_DURATION_STEP { return }
        focusDuration -= Constants.FOCUS_DURATION_STEP
    }

    func incrementLongBreakDuration() {
        longBreakDuration += Constants.LONG_BREAK_DURATION_STEP
    }

    func decrementLongBreakDuration() {
        if longBreakDuration == Constants.LONG_BREAK_DURATION_STEP { return }
        longBreakDuration -= Constants.LONG_BREAK_DURATION_STEP
    }

    func incrementShortBreakDuration() {
        shortBreakDuration += Constants.SHORT_BREAK_DURATION_STEP
    }

    func decrementShortBreakDuration() {
        if shortBreakDuration == Constants.SHORT_BREAK_DURATION_STEP { return }
        shortBreakDuration -= Constants.SHORT_BREAK_DURATION_STEP
    }

    func incrementPomodorosUntilLongDuration() {
        pomodorosUntilLongBreak += Constants.POMODOROS_UNTIL_LONG_BREAK_STEP
    }

    func decrementPomodorosUntilLongBreak() {
        if pomodorosUntilLongBreak == Constants.POMODOROS_UNTIL_LONG_BREAK_STEP { return }
        pomodorosUntilLongBreak -= Constants.POMODOROS_UNTIL_LONG_BREAK_STEP
    }
}
