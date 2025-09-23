//
//  MainPresenter.swift
//  Calculator
//
//  Created by Роман on 16.09.2025.
//  Copyright © 2025 Роман Пронин (Personal Team). All rights reserved.
//

import UIKit

protocol IMainPresenter {

    var buttons: [CalculatorButton.Button] { get }
    func updateDisplay(with text: String)
}

final class MainPresenter {

    private let model: ICalculatorButton
    private unowned let view: IMainViewController

    private var displayText = ""

    struct Dependencies {

        let model: ICalculatorButton
        let view: IMainViewController
    }

    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.view = dependencies.view
    }
}

// MARK: - IMainPresenter

extension MainPresenter: IMainPresenter {

    var buttons: [CalculatorButton.Button] {
        model.buttons
    }

    func updateDisplay(with text: String) {
        displayText += text
        view.setDisplay(text: displayText)
    }
}
