//
//  Pomodoro.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 14.07.2024.
//

import Foundation

@Observable
class Pomodoro: ObservableObject {
    private(set) var isActive = false
    private(set) var pomodorosCounter = 0
    private(set) var startDate = Date()
    private(set) var timer: Timer = .init()

    var settings: Settings

    private(set) var sessionDuration: Int
    private(set) var timeLeft: Int
    private(set) var theme: Theme
    private(set) var mode: Mode {
        willSet {
            theme = Theme.forMode(newValue)

            switch newValue {
            case .focus:
                sessionDuration = settings.focusDurationSeconds
                timeLeft = settings.focusDurationSeconds
            case .shortBreak:
                pomodorosCounter += 1
                sessionDuration = settings.shortBreakDurationSeconds
                timeLeft = settings.shortBreakDurationSeconds
            case .longBreak:
                pomodorosCounter = 0
                sessionDuration = settings.longBreakDurationSeconds
                timeLeft = settings.longBreakDurationSeconds
            }
        }
    }

    private var isSessionInProgress: Bool {
        timeLeft < sessionDuration
    }

    init(mode: Mode) {
        let settings = Settings()
        self.settings = settings
        self.sessionDuration = settings.focusDurationSeconds
        self.timeLeft = settings.focusDurationSeconds

        self.mode = mode
        self.theme = Theme.forMode(mode)
    }

    /// Starts pomodoro session
    func start() {
        isActive = true

        if !isSessionInProgress {
            startDate = Date()
        }

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.update()
        }
    }

    private func update() {
        if !self.isActive {
            timer.invalidate()
            return
        }

        // TODO: take into account pauses made during session
        let elapsedTime = Int(Date().timeIntervalSince1970 - startDate.timeIntervalSince1970)
        timeLeft = sessionDuration - elapsedTime

        if timeLeft == 0 {
            timer.invalidate()
            self.skip()
        }
    }

    /// Stops current pomodoro session
    ///
    /// Sets `isActive` property to false, which forces timer to be invalidated.
    /// `timer.invalidate()` must be called from the thread which started it, so we do not call this method here
    func stop() {
        isActive = false
    }

    /// Skips current pomodoro session
    ///
    /// Focus mode is skipped to short or long break. Both short and long breaks are always skipped to focus mode
    func skip() {
        isActive = false
        mode = switch mode {
        case .focus:
            pomodorosCounter + 1 >= settings.pomodorosUntilLongBreak ? .longBreak : .shortBreak
        case .shortBreak, .longBreak:
            .focus
        }
    }

    /// Saves settings and resets current pomodoro session if its duration was changed
    func saveSettings() {
        guard let storedSettings = settings.getStored() else {
            resetSession()
            settings.save()
            return
        }

        let isSessionDurationChanged = switch mode {
        case .focus:
            settings.focusDuration != storedSettings.focusDuration
        case .shortBreak:
            settings.shortBreakDuration != storedSettings.shortBreakDuration
        case .longBreak:
            settings.longBreakDuration != storedSettings.longBreakDuration
        }

        if isSessionDurationChanged {
            resetSession()
        }

        settings.save()
    }

    private func resetSession() {
        isActive = false
        mode = mode
    }
}
