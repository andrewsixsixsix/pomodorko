//
//  BGTaskManager.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 28.07.2024.
//

import Foundation
import BackgroundTasks

struct BGTaskManager {

    static func submit(_ taskId: String, in timeInterval: TimeInterval) {
        let request = BGAppRefreshTaskRequest(identifier: taskId)
        request.earliestBeginDate = Date.now + timeInterval

        try? BGTaskScheduler.shared.submit(request)
    }

    static func cancel(_ taskId: String) {
        BGTaskScheduler.shared.cancel(taskRequestWithIdentifier: taskId)
    }
}
