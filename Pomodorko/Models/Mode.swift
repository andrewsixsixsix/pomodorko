//
//  Mode.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 14.07.2024.
//

import Foundation

enum Mode: String {
    case focus
    case shortBreak
    case longBreak

    var name: String {
        switch self {
        case .focus:
            "Focus"
        case .shortBreak:
            "Short Break"
        case .longBreak:
            "Long Break"
        }
    }
}
