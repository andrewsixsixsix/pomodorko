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
    private(set) var mode: Mode

    init(mode: Mode) {
        self.isActive = false
        self.mode = mode
    }
}
