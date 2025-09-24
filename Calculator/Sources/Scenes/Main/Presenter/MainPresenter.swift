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
    func handleNumberButton(with number: Int)
    func handleClearButton()
    func handleChangeSignButton()
    func handlePercentButton()
    func handleDecimalButton()
}

final class MainPresenter {

    private let model: ICalculatorButton
    private unowned let view: IMainViewController

    private var displayText = ""
    private let ERROR_MESSAGE = "Ошибка"

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

    func handleNumberButton(with number: Int) {
        if displayText == ERROR_MESSAGE {
            displayText = ""
        }

        let number = String(number)
        displayText += number
        updateDisplay(with: displayText)
    }

    func handleClearButton() {
        let text = ""

        displayText = text
        updateDisplay(with: displayText)
    }

    func handleChangeSignButton() {
        guard Double(displayText) != nil && !displayText.isEmpty else {
            displayText = ERROR_MESSAGE
            updateDisplay(with: displayText)
            return
        }

        if displayText.first == "-" {
            displayText.removeFirst()
        } else {
            displayText = "-" + displayText
        }

        updateDisplay(with: displayText)
    }

    func handlePercentButton() {
        guard let value = Double(displayText) else {
            displayText = ERROR_MESSAGE
            updateDisplay(with: displayText)
            return
        }

        if displayText != "0" {
            displayText = "\(Decimal(value) * 0.01)"
        }

        updateDisplay(with: displayText)
    }

    func handleDecimalButton() {
        if displayText == "" {
            displayText = "0."
        } else if Double(displayText) != nil && !displayText.contains(".") {
            displayText += "."
        } else if !displayText.contains(".") {
            displayText = ERROR_MESSAGE
        }

        updateDisplay(with: displayText)
    }

    private func updateDisplay(with text: String) {
        view.setDisplay(text: text)
    }
}
