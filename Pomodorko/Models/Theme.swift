//
//  Theme.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 14.07.2024.
//

import SwiftUI

enum Theme: String {
    case focus
    case longBreak
    case shortBreak

    var mainColor: Color {
        Color(rawValue.appending("Main"))
    }

    var accentColor: Color {
        Color(rawValue.appending("Accent"))
    }

    var fillColor: Color {
        Color(rawValue.appending("Fill"))
    }

    static func forMode(_ mode: Mode) -> Self {
        switch mode {
        case .focus:
            .focus
        case .longBreak:
            .longBreak
        case .shortBreak:
            .shortBreak
        }
    }
}
