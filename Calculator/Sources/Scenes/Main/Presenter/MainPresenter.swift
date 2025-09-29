//
//  MainPresenter.swift
//  Calculator
//
//  Created by Роман on 16.09.2025.
//  Copyright © 2025 Роман Пронин (Personal Team). All rights reserved.
//

import Foundation

protocol IMainPresenter {

    var buttons: [CalculatorButton.Button] { get }
    func handleNumberButton(with number: Int)
    func handleSimpleBaseOperationButton(with operation: CalculatorButton.Button.Operation.Base)
    func handleInfoButton() -> (title: String, message: String)
    func handleAlgebraicOperationButton(with operation: CalculatorButton.Button.Operation.Algebraic)
}

final class MainPresenter {

    private let model: ICalculatorButton
    private unowned let view: IMainViewController

    private var tempValue = ""
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

    func handleSimpleBaseOperationButton(with operation: CalculatorButton.Button.Operation.Base) {
        switch operation {
        case .clear:
            handleClearButton()
        case .changeSign:
            handleChangeSignButton()
        case .percent:
            handlePercentButton()
        case .decimal:
            handleDecimalButton()
        default:
            fatalError(#function + ": unsupported operation")
        }
    }

    func handleInfoButton() -> (title: String, message: String) {
        (title: "Информация", message: "Разработчик: @CendresChaudes")
    }

    private func handleClearButton() {
        let text = ""

        tempValue = ""
        displayText = text
        updateDisplay(with: displayText)
    }

    func handleAlgebraicOperationButton(with operation: CalculatorButton.Button.Operation.Algebraic) {
        guard displayText != ERROR_MESSAGE else { return }
        guard let newValue = Double(displayText) else { return }

        if tempValue == "" {
            tempValue = displayText
        } else if operation == .divide && newValue == 0 {
            tempValue = ERROR_MESSAGE
            updateDisplay(with: ERROR_MESSAGE)
            return
        } else {
            let oldValue = Double(tempValue) ?? 0

            var sum = oldValue
            switch operation {
            case .sum:
                sum += newValue
            case .subtract:
                sum -= newValue
            case .multiply:
                sum *= newValue
            case .divide:
                sum /= newValue
            default:
                fatalError(#function + ": unsupported operation")
            }

            let isInt = sum.truncatingRemainder(dividingBy: 1) == 0
            tempValue = String(format: isInt ? "%.0f" : String(sum), sum)
        }

        displayText = ""
        updateDisplay(with: displayText)
        print("Current result: \(tempValue)")
    }

    private func handleChangeSignButton() {
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

    private func handlePercentButton() {
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

    private func handleDecimalButton() {
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
