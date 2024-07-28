//
//  Pomodoro.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 14.07.2024.
//

import Foundation

@Observable
class Pomodoro: ObservableObject {
    var settings: Settings

    private var pause: Pause?

    private(set) var isActive = false
    private(set) var pomodorosCounter = 0
    private(set) var startDate = Date()
    private(set) var timer: Timer = .init()

    private(set) var sessionDuration: Int
    private(set) var timeLeft: Int
    private(set) var theme: Theme
    private(set) var mode: Mode {
        willSet {
            pause = nil
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

    private var nextMode: Mode {
        switch mode {
        case .focus:
            pomodorosCounter + 1 >= settings.pomodorosUntilLongBreak ? .longBreak : .shortBreak
        case .shortBreak, .longBreak:
            .focus
        }
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
        if !isSessionInProgress {
            startDate = Date()
        }

        if let pauseDuration = pause?.duration {
            startDate.addTimeInterval(pauseDuration)
            pause = nil
        }

        isActive = true

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.update()
        }
    }

    private func update() {
        if !self.isActive {
            timer.invalidate()
            return
        }

        let elapsedTime = Int(Date().timeIntervalSince1970 - startDate.timeIntervalSince1970)
        timeLeft = sessionDuration - elapsedTime

        if timeLeft <= 0 {
            timer.invalidate()
            skip()
        }
    }

    /// Stops current pomodoro session
    ///
    /// Sets `isActive` property to false, which forces timer to be invalidated.
    /// `timer.invalidate()` must be called from the thread which started it, so we do not call this method here
    func stop() {
        isActive = false
        pause = .init()
    }

    /// Skips current pomodoro session
    ///
    /// Focus mode is skipped to short or long break. Both short and long breaks are always skipped to focus mode
    func skip() {
        mode = nextMode
        if settings.isAutoResume && isActive {
            start()
        } else {
            isActive = false
        }
    }

    /// Creates a background task to start next pomodoro session
    func scheduleNextSession() {
        guard isActive && settings.isAutoResume else {
            return
        }

        BGTaskManager.submit(Constants.BG_TASK_NEXT_SESSION, in: TimeInterval(timeLeft))
    }

    func scheduleNotification() {
        guard isActive && settings.isNotifications else {
            return
        }

        let title: String
        let body: String

        switch mode {
        case .focus:
            title = "Focus session is over"
            body = nextMode.name.appending(" is next")
        case .shortBreak, .longBreak:
            title = mode.name.appending(" is over")
            body = "Focus session is next"
        }

        NotificationManager.notify(title: title, body: body, timeInterval: TimeInterval(timeLeft), withSound: settings.isSound)
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

extension Pomodoro {
    struct Pause {
        var start: TimeInterval

        var duration: TimeInterval {
            Date().timeIntervalSince1970 - start
        }

        init() {
            start = Date().timeIntervalSince1970
        }
    }
}
