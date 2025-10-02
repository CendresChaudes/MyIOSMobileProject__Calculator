//
//  UserDefaultsThemeManager.swift
//  Theme
//
//  Created by Роман on 02.10.2025.
//  Copyright © 2025 Роман Пронин (Personal Team). All rights reserved.
//

import UIKit

protocol IUserDefaultsThemeManager {

    static var shared: Self { get }

    func saveTheme(_ theme: UIUserInterfaceStyle)
    func getTheme() -> UIUserInterfaceStyle
}

final class UserDefaultsThemeManager: UserDefaultsManager<String, Int>, IUserDefaultsThemeManager {

    static let shared = UserDefaultsThemeManager()

    private let THEME_KEY = "theme"

    private override init() {
        super.init()
    }

    func saveTheme(_ theme: UIUserInterfaceStyle) {
        var themeNumber: Int

        switch theme {
        case UIUserInterfaceStyle.unspecified:
            themeNumber = UIUserInterfaceStyle.unspecified.rawValue
        case UIUserInterfaceStyle.light:
            themeNumber = UIUserInterfaceStyle.light.rawValue
        case UIUserInterfaceStyle.dark:
            themeNumber = UIUserInterfaceStyle.dark.rawValue
        }

        create(value: themeNumber, forKey: THEME_KEY)
    }

    func getTheme() -> UIUserInterfaceStyle {
        var theme: UIUserInterfaceStyle?

        switch read(forKey: THEME_KEY) {
        case UIUserInterfaceStyle.unspecified.rawValue:
            theme = .unspecified
        case UIUserInterfaceStyle.light.rawValue:
            theme = .light
        case UIUserInterfaceStyle.dark.rawValue:
            theme = .dark
        default:
            theme = nil
        }

        return theme ?? .light
    }
}
