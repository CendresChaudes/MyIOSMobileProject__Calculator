//
//  Button.swift
//  Calculator
//
//  Created by Роман on 15.09.2025.
//  Copyright © 2025 Роман Пронин (Personal Team). All rights reserved.
//

import UIKit

protocol IButtonFactory {

    static func makeButton(title: String, variant: Button.Variant) -> Button
}

final class ButtonFactory: IButtonFactory {

    static func makeButton(title: String, variant: Button.Variant) -> Button {
        switch variant {
        case .primary:
            return makePrimaryButton(title: title)
        case .secondary:
            return makeSecondaryButton(title: title)
        case .accent:
            return makeAccentButton(title: title)
        }
    }

    private static func makePrimaryButton(title: String) -> Button {
        Button(title: title, variant: .primary)
    }

    private static func makeSecondaryButton(title: String) -> Button {
        Button(title: title, variant: .secondary)
    }

    private static func makeAccentButton(title: String) -> Button {
        Button(title: title, variant: .accent)
    }
}
