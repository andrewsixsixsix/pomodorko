//
//  PomodoroTheme.swift
//  Pomodorko
//
//  Created by Andrii Laptiiev on 14.07.2024.
//

import SwiftUI

class PomodoroTheme: ObservableObject {
    let theme: Theme

    init(mode: Mode) {
        self.theme = Theme.forMode(mode)
    }

    var accentColor: Color {
        theme.accentColor
    }

    var fillColor: Color {
        theme.fillColor
    }

    var fillColorDark: Color {
        theme.fillColorDark
    }

    var mainColor: Color {
        theme.mainColor
    }

    func forMode(_ mode: Mode) -> Theme {
        Theme.forMode(mode)
    }
}

extension PomodoroTheme {
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

        var fillColorDark: Color {
            Color(rawValue.appending("FillDark"))
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
}
