//
//  Settings.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 18.07.2024.
//

import Foundation

@Observable
class Settings: Codable {
    var isAutoResume: Bool = false
    var isNotifications: Bool = false {
        willSet {
            if newValue {
                NotificationManager.authorize()
            }
        }
    }
    var isSound: Bool = false

    // duration in minutes
    private(set) var focusDuration: Int = 25
    private(set) var longBreakDuration: Int = 30
    private(set) var shortBreakDuration: Int = 5
    private(set) var pomodorosUntilLongBreak: Int = 4

    var focusDurationSeconds: Int {
        focusDuration * 60
    }

    var longBreakDurationSeconds: Int {
        longBreakDuration * 60
    }

    var shortBreakDurationSeconds: Int {
        shortBreakDuration * 60
    }

    init() {
        if let data = UserDefaults.standard.data(forKey: Constants.SETTINGS) {
            do {
                let settings = try JSONDecoder().decode(Settings.self, from: data)
    
                isAutoResume = settings.isAutoResume
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

    func getStored() -> Settings? {
        if let data = UserDefaults.standard.data(forKey: Constants.SETTINGS) {
            do {
                return try JSONDecoder().decode(Settings.self, from: data)
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }

    func incrementFocusDuration() {
        focusDuration += Constants.FOCUS_DURATION_STEP
    }

    func decrementFocusDuration() {
        guard focusDuration == Constants.FOCUS_DURATION_STEP else {
            return
        }
        focusDuration -= Constants.FOCUS_DURATION_STEP
    }

    func incrementLongBreakDuration() {
        longBreakDuration += Constants.LONG_BREAK_DURATION_STEP
    }

    func decrementLongBreakDuration() {
        guard longBreakDuration == Constants.LONG_BREAK_DURATION_STEP else {
            return
        }
        longBreakDuration -= Constants.LONG_BREAK_DURATION_STEP
    }

    func incrementShortBreakDuration() {
        shortBreakDuration += Constants.SHORT_BREAK_DURATION_STEP
    }

    func decrementShortBreakDuration() {
        guard shortBreakDuration == Constants.SHORT_BREAK_DURATION_STEP else {
            return
        }
        shortBreakDuration -= Constants.SHORT_BREAK_DURATION_STEP
    }

    func incrementPomodorosUntilLongDuration() {
        pomodorosUntilLongBreak += Constants.POMODOROS_UNTIL_LONG_BREAK_STEP
    }

    func decrementPomodorosUntilLongBreak() {
        guard pomodorosUntilLongBreak == Constants.POMODOROS_UNTIL_LONG_BREAK_STEP else {
            return
        }
        pomodorosUntilLongBreak -= Constants.POMODOROS_UNTIL_LONG_BREAK_STEP
    }
}
